#!/bin/bash

# Script to toggle waybar tray visibility by swapping configs
# Usage: toggle-module.sh tray

CONFIG_DIR="$HOME/.config/waybar"
STATE_DIR="$HOME/.cache/waybar"
STATE_FILE="$STATE_DIR/tray_hidden"

# Create cache directory if it doesn't exist
mkdir -p "$STATE_DIR"

# Check current state and swap configs
if [ -f "$STATE_FILE" ]; then
    # Tray is currently hidden, show it
    rm "$STATE_FILE"
    # Use config WITH tray
    cp "$CONFIG_DIR/config-with-tray.jsonc" "$CONFIG_DIR/config.jsonc"
else
    # Tray is currently visible, hide it
    touch "$STATE_FILE"
    # Use config WITHOUT tray (remove tray from modules-right)
    sed '/"tray",/d; /"tray": {/,/}/d' "$CONFIG_DIR/config-with-tray.jsonc" > "$CONFIG_DIR/config.jsonc"
fi

# Reload waybar to apply changes
pkill -SIGUSR2 waybar
