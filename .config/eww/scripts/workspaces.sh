
#!/bin/bash

# Subscribe to BSPWM events for desktop changes or node transfers
bspc subscribe desktop node_transfer | while read -r _ ; do
    current=$(bspc query -D -d focused --names) # Get the currently focused workspace
    total=6                                     # Total number of workspaces
    workspaces=""                               # String to hold workspace icons
    
    for ((i=1; i<=$total; i++)); do
        # Check if the workspace has any open windows
        open_windows=$(bspc query -N -d "$i" | wc -l)

        if [ "$i" -eq "$current" ]; then
            icon="󰄯"  # Icon for the current workspace
        elif [ "$open_windows" -gt 0 ]; then
            icon=""  # Icon for workspace with open windows
        else
            icon="󰄰"  # Icon for empty workspace
        fi
        
        # Build the workspaces string with proper formatting
        if [ "$i" -eq "$total" ]; then
            workspaces+="$icon"
        else
            workspaces+="$icon  "
        fi
    done
    
    # Output the formatted workspace icons
    echo "(box (label :text \"$workspaces\" ))"
done
