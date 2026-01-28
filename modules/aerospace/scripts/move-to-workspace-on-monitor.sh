#!/bin/bash

# Usage: move-to-workspace-on-monitor.sh <workspace_number_1_to_10>

if [ -z "$1" ]; then
    echo "Usage: $0 <workspace_number>"
    exit 1
fi

local_workspace=$1

# Get the currently focused monitor
current_monitor=$(aerospace list-monitors --focused)

# Get list of all monitors in order (main first, then others)
all_monitors=($(aerospace list-monitors))

# Find the index of the current monitor
monitor_index=0
for i in "${!all_monitors[@]}"; do
    if [ "${all_monitors[$i]}" == "$current_monitor" ]; then
        monitor_index=$i
        break
    fi
done

# Calculate the actual workspace number
actual_workspace=$((monitor_index * 10 + local_workspace))

# Move the current window to the workspace
aerospace move-node-to-workspace "$actual_workspace"
