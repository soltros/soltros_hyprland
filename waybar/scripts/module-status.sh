#!/bin/bash

# Script to check if waybar modules are hidden
# This outputs CSS classes that waybar will apply

STATE_DIR="$HOME/.cache/waybar"

# Check each module and output class if hidden
CLASSES=""

for module in tray mpris idle_inhibitor pulseaudio battery; do
    if [ -f "$STATE_DIR/${module}_hidden" ]; then
        CLASSES="$CLASSES ${module}-hidden"
    fi
done

# Output classes for waybar to use
echo "$CLASSES" | xargs
