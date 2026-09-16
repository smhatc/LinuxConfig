#!/usr/bin/env bash

# Notification menu control, takes "show" to toggle the notification panel or "dnd" to toggle do not disturb
notification_menu="swaync-client"
show_opts="-t"
dnd_opts="-d"

action="$1"

case "$action" in
    show)
        "$notification_menu" "$show_opts"
        ;;
    dnd)
        "$notification_menu" "$dnd_opts"
        ;;
    *)
        notify-send -u critical "Notification Menu" "Unknown action \"${action}\", expected \"show\" or \"dnd\""
        exit 1
        ;;
esac
