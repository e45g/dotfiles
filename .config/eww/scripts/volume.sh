#!/bin/bash

get_volume() {
    volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
    if [ "$volume" -gt 50 ]; then
        icon=" "
    elif [ "$volume" -gt 0 ]; then
        icon=" "
    else
        icon=" "
    fi
    echo "$volume% $icon"
}

get_volume
pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "sink" || echo "$event" | grep -q "server"; then
        get_volume
    fi
done
