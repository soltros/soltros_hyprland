#!/bin/bash

# Script to toggle waybar module visibility
# Usage: toggle-module.sh <module-name>

MODULE=$1
STATE_DIR="$HOME/.cache/waybar"
STATE_FILE="$STATE_DIR/${MODULE}_hidden"

# Create cache directory if it doesn't exist
mkdir -p "$STATE_DIR"

# Toggle the state
if [ -f "$STATE_FILE" ]; then
    # Module is currently hidden, show it
    rm "$STATE_FILE"
else
    # Module is currently visible, hide it
    touch "$STATE_FILE"
fi

# Generate dynamic CSS to hide modules
DYNAMIC_CSS="$STATE_DIR/dynamic.css"

if [ -f "$STATE_DIR/tray_hidden" ]; then
    # Tray is hidden - completely hide and collapse the tray
    cat > "$DYNAMIC_CSS" << 'EOF'
/* Dynamically hidden modules */
#tray > * {
    min-height: 0;
    min-width: 0;
    padding: 0;
    margin: 0;
    border: 0;
    font-size: 0;
}
#tray {
    min-width: 0;
    padding: 0;
    margin: 0;
    border: 0;
}
EOF
else
    # Tray is visible - empty CSS file
    echo "/* Dynamically hidden modules */" > "$DYNAMIC_CSS"
fi

# Reload waybar to apply changes
pkill -SIGUSR2 waybar
