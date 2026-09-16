#!/usr/bin/env bash

# Per-app theme switcher, swaps the generic theme file of each app for the selected variant in its "themes/" folder
themes_source_dir="${HOME}/.config/rofi/themes"
current_theme_cache="${HOME}/.cache/current-theme"
wallpaper_dir="${HOME}/.config/wallpapers"
theme_icon=""
transition_type="any"
transition_duration="2"
transition_fps="60"

# App -> "config_dir:generic_theme_file:reload_command" (empty reload_command = no live reload)
declare -A themed_apps=(
    [Hyprland]="${HOME}/.config/hypr:theme.lua:hyprctl reload"
    [Hyprlock]="${HOME}/.config/hypr:theme.conf:"
    [Waybar]="${HOME}/.config/waybar:theme.css:pkill -SIGUSR2 waybar"
    [SwayNC]="${HOME}/.config/swaync:theme.css:swaync-client -rs"
    [Rofi]="${HOME}/.config/rofi:theme.rasi:"
    [Kitty]="${HOME}/.config/kitty:theme.conf:pkill -SIGUSR1 kitty"
    [Foot]="${HOME}/.config/foot:theme.ini:"
)

# Waybar kills the process group of any command it spawns when it reloads, so detach from the launcher before reloading Waybar below
if [[ -z "$THEME_SWITCHER_DETACHED" ]]; then
    THEME_SWITCHER_DETACHED=1 setsid --fork "$0" "$@"
    exit 0
fi

# Fallback in case themes directory does not exist
if [[ ! -d "$themes_source_dir" ]]; then
    notify-send -u critical "Theme Switcher" "Themes directory \"${themes_source_dir}\" not found"
    exit 1
fi

# Search themes and exit if none found, otherwise continue
mapfile -t theme_names < <(find "$themes_source_dir" -maxdepth 1 -type f -iname "*.rasi" -printf "%f\n" | sed 's/\.rasi$//' | sort)

if [[ ${#theme_names[@]} -eq 0 ]]; then
    notify-send -u critical "Theme Switcher" "No themes found in \"${themes_source_dir}\""
    exit 1
fi

menu_entries=""
declare -A theme_by_entry
for theme_name in "${theme_names[@]}"; do
    label="$(tr '-' ' ' <<<"$theme_name" | sed 's/\b\(.\)/\u\1/g')"
    menu_entries+="${theme_icon} ${label}\n"
    theme_by_entry["${theme_icon} ${label}"]="$theme_name"
done

# Outputting the theme list to Rofi and saving the result
selected_entry="$(pkill rofi || echo -en "$menu_entries" | rofi -dmenu -i -config ~/.config/rofi/modes/theme-switcher.rasi)"

# Sanity checks
[[ -z "$selected_entry" ]] && exit 0

selected_theme="${theme_by_entry[$selected_entry]}"

if [[ -z "$selected_theme" ]]; then
    notify-send -u critical "Theme Switcher" "Unknown theme \"${selected_entry}\" selected"
    exit 1
fi

selected_label="${selected_entry#"${theme_icon} "}"

# Setting the selected theme for every app and reloading the ones supporting it
for app in "${!themed_apps[@]}"; do
    IFS=':' read -r config_dir generic_file reload_cmd <<<"${themed_apps[$app]}"
    extension="${generic_file##*.}"
    source_file="${config_dir}/themes/${selected_theme}.${extension}"

    if [[ ! -f "$source_file" ]]; then
        notify-send "Theme Switcher" "No \"${selected_label}\" variant for \"${app}\", skipping"
        continue
    fi

    cp -f "$source_file" "${config_dir}/${generic_file}"
    [[ -n "$reload_cmd" ]] && $reload_cmd &>/dev/null
done

# Caching the selected theme so the wallpaper switcher can scope its menu to it
echo "$selected_theme" >"$current_theme_cache"

# Search wallpapers belonging to the theme and exit if none found, otherwise continue
theme_wallpaper_dir="$(find -L "$wallpaper_dir" -type d -iname "$selected_theme" | head -n1)"

if [[ -z "$theme_wallpaper_dir" ]]; then
    notify-send "Theme Switcher" "No wallpapers found for \"${selected_label}\" theme"
    exit 0
fi

mapfile -t theme_wallpapers < <(find -L "$theme_wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

if [[ ${#theme_wallpapers[@]} -eq 0 ]]; then
    notify-send "Theme Switcher" "No wallpapers found for \"${selected_label}\" theme"
    exit 0
fi

# Setting a random wallpaper belonging to the selected theme
awww img "${theme_wallpapers[$((RANDOM % ${#theme_wallpapers[@]}))]}" \
    --transition-type "$transition_type" \
    --transition-duration "$transition_duration" \
    --transition-fps "$transition_fps"
