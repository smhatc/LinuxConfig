#!/usr/bin/env bash

# Power options
lock="󰍁 Lock              [L]"
exit="󰖭 Exit Environment  [E]"
logout="󰿅 Log Out           [G]"
suspend=" Suspend           [S]"
reboot=" Reboot            [R]"
poweroff=" Power Off         [P]"

# Outputting the power options to Rofi and saving the result
selected=$(pkill rofi || echo -e "${lock}\n${exit}\n${logout}\n${suspend}\n${reboot}\n${poweroff}" | rofi -dmenu -config "~/.config/rofi/modes/power-menu.rasi")

# Taking the appropriate action based on the returned result
[[ "$selected" == "$lock" ]] && loginctl lock-session
if [[ "$selected" == "$exit" ]]; then
    [[ -f "$(command -v hypridle)" ]] && pkill hypridle
    [[ -f "$(command -v udiskie)" ]] && pkill udiskie
    [[ -f "$(command -v awww)" ]] && pkill awww-daemon
    [[ -f "/usr/libexec/polkit-gnome-authentication-agent-1" ]] && pkill /usr/libexec/polkit-gnome-authentication-agent-1
    [[ -f "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" ]] && pkill /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    [[ -f "$(command -v swaync)" ]] && pkill swaync
    [[ -f "$(command -v waybar)" ]] && pkill waybar
    [[ -f "$(command -v hyprland)" ]] && hyprctl dispatch exit
fi
[[ "$selected" == "$logout" ]] && loginctl terminate-user "$USER"
[[ "$selected" == "$suspend" ]] && systemctl suspend
[[ "$selected" == "$reboot" ]] && systemctl reboot
[[ "$selected" == "$poweroff" ]] && systemctl poweroff
