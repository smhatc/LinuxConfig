#!/usr/bin/env bash

# Brightness control, "up" and "down" adjust the laptop panel through brightnessctl, while "dim" and "restore" cover every display by also driving any external monitors through ddcutil (DDC/CI)
step_percent="5"
internal_dim_value="10"
external_dim_percent="10"
external_brightness_cache="${XDG_RUNTIME_DIR:-/tmp}/external-monitor-brightness"
external_monitor_lock="${XDG_RUNTIME_DIR:-/tmp}/external-monitor-brightness.lock"
ddc_timeout="5"

action="$1"

# Lists every monitor answering over DDC/CI as "bus<TAB>connector|make:model:serial" (laptop panels report as invalid displays and are left out)
detect_external_monitors() {
    timeout "$ddc_timeout" ddcutil detect --terse 2>/dev/null | awk '
        /^Display [0-9]+/ { in_display = 1; next }
        /^[^ ]/ { in_display = 0; next }
        in_display && /I2C bus:/ { sub(/.*\/dev\/i2c-/, ""); bus = $0 }
        in_display && /DRM connector:/ { sub(/.*DRM connector:[ \t]*/, ""); connector = $0 }
        in_display && /Monitor:/ { sub(/.*Monitor:[ \t]*/, ""); print bus "\t" connector "|" $0; in_display = 0 }
    '
}

# Talks to one external monitor by its I2C bus
external_brightness() {
    local bus="$1"
    shift

    timeout "$ddc_timeout" ddcutil --bus "$bus" "$@" 2>/dev/null
}

# Stepping only adjusts the laptop panel, since DDC/CI steps at a different pace and would drift out of sync with it
case "$action" in
    up)
        brightnessctl -n2 set "${step_percent}%+" >/dev/null
        ;;
    down)
        brightnessctl -n2 set "${step_percent}%-" >/dev/null
        ;;
    dim)
        brightnessctl -s set "$internal_dim_value" >/dev/null

        # ddcutil has no save/restore of its own, so each monitor's current value is cached before dimming, keyed by identity since bus numbers can shift on hotplug
        (
            flock -w "$ddc_timeout" 9 || exit 0

            : >"$external_brightness_cache"
            while IFS=$'\t' read -r bus identity; do
                current_brightness="$(external_brightness "$bus" getvcp 10 --terse | awk '{print $4}')"
                [[ -z "$current_brightness" ]] && continue

                printf '%s\t%s\n' "$identity" "$current_brightness" >>"$external_brightness_cache"
                external_brightness "$bus" setvcp 10 "$external_dim_percent" --noverify >/dev/null
            done < <(detect_external_monitors)
        ) 9>"$external_monitor_lock"
        ;;
    restore)
        brightnessctl -r >/dev/null

        # Only monitors that were dimmed get restored, so one plugged in while idle keeps its own brightness
        (
            flock -w "$ddc_timeout" 9 || exit 0
            [[ -s "$external_brightness_cache" ]] || exit 0

            while IFS=$'\t' read -r bus identity; do
                saved_brightness="$(awk -F '\t' -v id="$identity" '$1 == id { print $2 }' "$external_brightness_cache")"
                [[ -z "$saved_brightness" ]] && continue

                external_brightness "$bus" setvcp 10 "$saved_brightness" --noverify >/dev/null
            done < <(detect_external_monitors)
        ) 9>"$external_monitor_lock"
        ;;
    *)
        notify-send -u critical "Brightness" "Unknown action \"${action}\", expected \"up\", \"down\", \"dim\", or \"restore\""
        exit 1
        ;;
esac
