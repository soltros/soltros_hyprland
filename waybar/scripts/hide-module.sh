#!/bin/bash

# Script to hide a waybar module using CSS class manipulation
# Usage: hide-module.sh <module-name>

MODULE=$1
STATE_DIR="$HOME/.cache/waybar"
STATE_FILE="$STATE_DIR/${MODULE}_hidden"

# Create cache directory if it doesn't exist
mkdir -p "$STATE_DIR"

# Check current state and toggle
if [ -f "$STATE_FILE" ]; then
    # Module is currently hidden, show it
    rm "$STATE_FILE"

    # Add class to show the module by updating waybar style
    CLASS_TO_REMOVE="hidden"

    # Use hyprctl to restart waybar to apply changes
    pkill -SIGUSR2 waybar
else
    # Module is currently visible, hide it
    touch "$STATE_FILE"

    # Use hyprctl to restart waybar to apply changes
    pkill -SIGUSR2 waybar
fi
