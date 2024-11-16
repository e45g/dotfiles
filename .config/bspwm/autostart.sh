#!/bin/sh

xrandr
$HOME/.config/bspwm/hdmi_detect.sh

picom --config $HOME/.config/picom/picom.conf &
dunst &
eww open bar

feh --bg-scale $HOME/.config/bspwm/wallpaper.png
