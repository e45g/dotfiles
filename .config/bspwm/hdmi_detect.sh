#!/bin/bash

# Get the connected status of HDMI-1-0
HDMI_STATUS=$(xrandr --query | grep "HDMI-1-0 connected")

# If HDMI-1-0 is connected
if [ "$HDMI_STATUS" != "" ]; then
    # Set HDMI-1-0 as primary display and turn off others
    xrandr --output HDMI-1-0 --auto --primary --output eDP --off
    # Set BSPWM monitor and desktops for HDMI-1-0
    bspc monitor HDMI-1-0 -d 1 2 3 4 5 6
else
    # If HDMI-1-0 is not connected, use eDP (internal display)
    xrandr --output eDP --auto --primary --output HDMI-1-0 --off
    # Set BSPWM monitor and desktops for eDP
    bspc monitor eDP -d 1 2 3 4 5 6
fi

# Reload BSPWM configuration
# bspc wm -r
