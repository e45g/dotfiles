#!/bin/sh

$HOME/.config/bspwm/hdmi_detect.sh

dunst &
# pkill eww
# eww daemon
# eww open bar
polybar --reload top &
picom --config ~/.config/picom/picom.conf &

# feh --bg-scale $HOME/.config/bspwm/wallpapers/$(($RANDOM % 3 + 1)).png
feh --bg-fill $HOME/.config/bspwm/wallpapers/2.png
