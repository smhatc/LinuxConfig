#!/usr/bin/env bash

# Show "drun" mode of Rofi
pkill rofi || rofi -show drun -config "~/.config/rofi/modes/app-launcher.rasi"
