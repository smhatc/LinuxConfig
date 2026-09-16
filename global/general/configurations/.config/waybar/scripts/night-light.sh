#!/usr/bin/env bash

# Night light toggle, stops the running night light or starts one at a warmer color temperature, then refreshes the status bar's module
night_light="hyprsunset"
night_light_temperature="3000"
status_bar="waybar"
status_bar_signal="RTMIN+1"
refresh_delay="0.25"

# Detached from the caller so a status bar reload cannot take the night light down with it
if ! pkill "$night_light"; then
    setsid --fork "$night_light" -t "$night_light_temperature" &>/dev/null
fi

# Give the daemon a moment to settle before the module re-reads its state
sleep "$refresh_delay"
pkill -"$status_bar_signal" "$status_bar"
