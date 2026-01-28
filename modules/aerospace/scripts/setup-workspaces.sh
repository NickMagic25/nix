#!/bin/bash

# Get list of monitors (excluding the main/built-in display)
monitors=($(aerospace list-monitors | grep -v "main" | grep -v "built-in"))

# Main monitor uses workspaces 1-10 (already configured)
workspace_start=11

# For each additional monitor, assign 10 workspaces
for i in "${!monitors[@]}"; do
    monitor="${monitors[$i]}"

    # Assign workspaces to this monitor
    for j in {0..9}; do
        workspace_num=$((workspace_start + j))
        aerospace workspace-to-monitor-force-assignment "$workspace_num" "$monitor"
    done

    workspace_start=$((workspace_start + 10))
done
