#!/bin/bash

# Get the list of used workspaces
used_workspaces=$(hyprctl workspaces | grep 'workspace ID' | awk '{print $3}' | sort -n)

# Find the next empty workspace
next_empty=1
for ws in $used_workspaces; do
    if [ "$ws" -eq "$next_empty" ]; then
        next_empty=$((next_empty + 1))
    else
        break
    fi
done

# Move to the next empty workspace
hyprctl dispatch workspace "$next_empty"
