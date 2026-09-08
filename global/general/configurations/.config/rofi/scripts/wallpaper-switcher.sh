#!/usr/bin/env bash

# Per-theme wallpaper switcher, pulls recursively from "~/.config/wallpapers" (symlinked to repo)
wallpaper_dir="${HOME}/.config/wallpapers"
current_theme_cache="${HOME}/.cache/current-theme"
transition_type="any"
transition_duration="2"
transition_fps="60"

# Fallback in case wallpaper directory does not exist
if [[ ! -d "$wallpaper_dir" ]]; then
    notify-send -u critical "Wallpaper Switcher" "Wallpaper directory \"${wallpaper_dir}\" not found"
    exit 1
fi

# Scope to the active theme's wallpaper folder when one is set; otherwise show everything
search_dir="$wallpaper_dir"
if [[ -s "$current_theme_cache" ]]; then
    current_theme="$(<"$current_theme_cache")"
    theme_dir="$(find -L "$wallpaper_dir" -type d -iname "$current_theme" | head -n1)"
    [[ -n "$theme_dir" ]] && search_dir="$theme_dir"
fi

# Search wallpapers and exit if none found, otherwise continue
mapfile -t wallpapers < <(find -L "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    notify-send -u critical "Wallpaper Switcher" "No wallpapers found in \"${search_dir}\""
    exit 1
fi

menu_entries=""
declare -A path_by_label
for wallpaper in "${wallpapers[@]}"; do
    filename="$(basename "$wallpaper")"
    label="${filename%.*}"
    menu_entries+="${label}\0icon\x1f${wallpaper}\n"
    path_by_label["$label"]="$wallpaper"
done

# Outputting the wallpaper list to Rofi and saving the result
selected_label="$(pkill rofi || echo -en "$menu_entries" | rofi -dmenu -i -config ~/.config/rofi/modes/wallpaper-switcher.rasi)"

# Sanity checks
[[ -z "$selected_label" ]] && exit 0

selected_path="${path_by_label[$selected_label]}"

if [[ -z "$selected_path" || ! -f "$selected_path" ]]; then
    notify-send -u critical "Wallpaper Switcher" "Selected wallpaper \"${selected_label}\" not found"
    exit 1
fi

# Setting the selected wallpaper
awww img "$selected_path" \
    --transition-type "$transition_type" \
    --transition-duration "$transition_duration" \
    --transition-fps "$transition_fps"
