#!/bin/sh

symbol() {
[ $(cat /sys/class/net/w*/operstate) = down ] && echo 󰖪 && exit
echo 󰖩
}

name() {
    nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d ':' -f2
}
getboth() {
    echo "$(name) $(symbol)"
}

getboth && exit
