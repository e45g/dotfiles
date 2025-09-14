#!/bin/bash

HDMI_NAME="HDMI-1-0"
EDP_NAME="eDP-1"

# Get the connected status of HDMI-1-1
HDMI_STATUS=$(xrandr --query | grep "$HDMI_NAME connected")

# If HDMI-1-1 is connected
if [ "$HDMI_STATUS" != "" ]; then
    # --auto or --mode 1920x1080
    # xrandr --output HDMI-1-0 --primary --mode 1920x1080
    xrandr --output "$HDMI_NAME" --primary --auto
    xrandr --output "$EDP_NAME" --auto --left-of "$HDMI_NAME"
    # Set BSPWM monitor and desktops for HDMI-1-1
    bspc monitor "$HDMI_NAME" -d 1 2 3 4 5 6
    bspc monitor "$EDP_NAME" -d 7 8 9
    bspc wm -O "$HDMI_NAME" "$EDP_NAME"

else
    # If HDMI-1-1 is not connected, use eDP (internal display)
    xrandr --output "$EDP_NAME" --auto --primary --output "$HDMI_NAME" --off
    # Set BSPWM monitor and desktops for eDP
    bspc monitor "$EDP_NAME" -d 1 2 3 4 5 6
fi

# Set eDP as the primary monitor
# bspc monitor "$EDP_NAME" -p

# Set initial focus to eDP
bspc monitor "$EDP_NAME" -f

# Reload BSPWM configuration
# bspc wm -r
