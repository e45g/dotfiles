#!/bin/bash

# Get the connected status of HDMI-1-0
HDMI_STATUS=$(xrandr --query | grep "HDMI-1-0 connected")

# If HDMI-1-0 is connected
if [ "$HDMI_STATUS" != "" ]; then
    # Set HDMI-1-0 as primary display a
    xrandr --output HDMI-1-0 --auto --left-of eDP
    xrandr --output eDP --auto --primary
    # Set BSPWM monitor and desktops for HDMI-1-0
    bspc monitor eDP -d 1 2 3 4 5 6
    bspc monitor HDMI-1-0 -d 7 8 9
    bspc wm -O eDP HDMI-1-0

else
    # If HDMI-1-0 is not connected, use eDP (internal display)
    xrandr --output eDP --auto --primary --output HDMI-1-0 --off
    # Set BSPWM monitor and desktops for eDP
    bspc monitor eDP -d 1 2 3 4 5 6
fi

# Set eDP as the primary monitor
bspc monitor eDP -p

# Set initial focus to eDP
bspc monitor eDP -f

# Reload BSPWM configuration
# bspc wm -r
