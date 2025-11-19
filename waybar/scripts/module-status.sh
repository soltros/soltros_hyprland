#!/bin/bash

# Script to check module status and output appropriate icon
# Usage: module-status.sh <module-name>

MODULE=$1
STATE_DIR="$HOME/.cache/waybar"
STATE_FILE="$STATE_DIR/${MODULE}_hidden"

if [ -f "$STATE_FILE" ]; then
    # Module is hidden - show chevron pointing right to indicate it can be shown
    echo '{"text": "❯", "tooltip": "Show tray"}'
else
    # Module is visible - show chevron pointing left to indicate it can be hidden
    echo '{"text": "❮", "tooltip": "Hide tray"}'
fi
