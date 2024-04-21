#!/usr/bin/env bash
# Author : rxyhn

BRIGHTNESS_STEPS=5

up() {
	brightnessctl set "${BRIGHTNESS_STEPS:-5}%+" -q
	brightness=$(brightnessctl i | grep -oP '\(\K[^%\)]+')
	[ $brightness -lt 100 ] && brightness=`expr $brightness`  
	dunstify -a "BRIGHTNESS" "Brightness" "Increasing to $brightness%" -h int:value:"$brightness" -i display-brightness-low-symbolic -r 5555 -u normal
}

down() {
	brightnessctl set "${BRIGHTNESS_STEPS:-5}%-" -q
	brightness=$(brightnessctl i | grep -oP '\(\K[^%\)]+')
	[ $brightness -gt 0 ] && brightness=`expr $brightness`  
	dunstify -a "BRIGHTNESS" "Brightness" "Decreasing to $brightness%" -h int:value:"$brightness" -i display-brightness-low-symbolic -r 5555 -u normal
}

case $1 in
  up) up;;
  down) down;;
esac
