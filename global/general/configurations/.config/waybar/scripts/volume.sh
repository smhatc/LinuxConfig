#!/usr/bin/env bash

# Volume control for the default output and input devices, takes "raise-output", "lower-output", "mute-output", "raise-input", "lower-input", or "mute-input"
volume_step="5"
volume_limit="1"
output_device="@DEFAULT_AUDIO_SINK@"
input_device="@DEFAULT_AUDIO_SOURCE@"

action="$1"

# Raising is capped at the limit to keep the volume from overshooting 100%
case "$action" in
    raise-output)
        wpctl set-volume -l "$volume_limit" "$output_device" "${volume_step}%+"
        ;;
    lower-output)
        wpctl set-volume "$output_device" "${volume_step}%-"
        ;;
    mute-output)
        wpctl set-mute "$output_device" toggle
        ;;
    raise-input)
        wpctl set-volume -l "$volume_limit" "$input_device" "${volume_step}%+"
        ;;
    lower-input)
        wpctl set-volume "$input_device" "${volume_step}%-"
        ;;
    mute-input)
        wpctl set-mute "$input_device" toggle
        ;;
    *)
        notify-send -u critical "Volume" "Unknown action \"${action}\", expected \"raise-output\", \"lower-output\", \"mute-output\", \"raise-input\", \"lower-input\", or \"mute-input\""
        exit 1
        ;;
esac
