#!/bin/bash

# Get the current active window address
active_window=$(hyprctl activewindow -j | jq -r '.address')

# Get the floating state of the active window
is_floating=$(hyprctl activewindow -j | jq -r '.floating')

# Toggle floating
hyprctl dispatch togglefloating

# If it was tiled (false), it's now floating - hide waybar
if [ "$is_floating" = "false" ]; then
    pkill -SIGUSR1 waybar
# If it was floating (true), it's now tiled - show waybar
elif [ "$is_floating" = "true" ]; then
    pkill -SIGUSR2 waybar
fi
