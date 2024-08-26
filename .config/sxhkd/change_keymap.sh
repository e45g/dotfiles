if [ "$(setxkbmap -query | awk '/layout/{print $2}')" = "us" ]; then
    setxkbmap -layout cz
  else
    setxkbmap -layout us
  fi
