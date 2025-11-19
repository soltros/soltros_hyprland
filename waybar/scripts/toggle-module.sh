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
echo "/* Dynamically hidden modules */" > "$DYNAMIC_CSS"

for module in tray; do
    if [ -f "$STATE_DIR/${module}_hidden" ]; then
        css_module=$(echo "$module" | tr '_' '-')
        cat >> "$DYNAMIC_CSS" << 'EOF'
#tray {
    min-width: 0 !important;
    padding: 0 !important;
    margin: 0 !important;
    opacity: 0 !important;
    transform: scaleX(0) !important;
}
EOF
    fi
done

# Reload waybar to apply changes
pkill -SIGUSR2 waybar
