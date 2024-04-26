#!/usr/bin/env bash

#  ██╗   ██╗ ██████╗ ██╗     ██╗   ██╗███╗   ███╗███████╗
#  ██║   ██║██╔═══██╗██║     ██║   ██║████╗ ████║██╔════╝
#  ██║   ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗  
#  ╚██╗ ██╔╝██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝  
#   ╚████╔╝ ╚██████╔╝███████╗╚██████╔╝██║ ╚═╝ ██║███████╗
#    ╚═══╝   ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝
#  gh0stzk            https://github.com/gh0stzk/dotfiles

get_vol () {
	volumen=$(amixer -D pulse get Master | grep -m 1 -oP '[0-9]+(?=%)')
	[[ $(amixer -D pulse get Master | grep '\[off\]') ]] && echo "0" || echo "${volumen}"
}

get_icon () {
	local vol=$(get_vol)
	echo "$( [[ $vol == "0" ]] && echo "󰝟 " || echo "󰕾 " )"
}

down() {
	amixer -D pulse sset Master 5%-
	volume=$(amixer -D pulse get Master | grep -m 1 -oP '[0-9]+(?=%)')
	[ $volume -gt 0 ] && volume=`expr $volume`  
	dunstify -a "VOLUME" "Sound" "Decreasing to $volume%" -h int:value:"$volume" -i audio-volume-low-symbolic -r 2593 -u normal
}

up() {
	amixer -D pulse sset Master 5%+
	volume=$(amixer -D pulse get Master | grep -m 1 -oP '[0-9]+(?=%)')
	[ $volume -lt 100 ] && volume=`expr $volume`  
	dunstify -a "VOLUME" "Sound" "Increasing to $volume%" -h int:value:"$volume" -i audio-volume-high-symbolic -r 2593 -u normal
}

mute() {
	if [ "$(amixer -D pulse get Master | grep '\[on\]')" ]; then
		amixer -D pulse set Master mute
		dunstify -a "VOLUME" "Sound" "Muted" -i audio-volume-muted-symbolic -r 2593 -u normal
	else 
		amixer -D pulse set Master unmute
		dunstify -a "VOLUME" "Sound" "Unmuted" -i audio-volume-high-symbolic -r 2593 -u normal
	fi
}

mute_mic() {
	if [[ "$(amixer -D pulse get Capture | grep '\[on\]')" ]]; then
		amixer -D pulse set Capture nocap
		dunstify -a "MICROPHONE" "Sound" "No Capture" -i microphone-sensitivity-muted-symbolic -r 2593 -u normal
	else
		amixer -D pulse set Capture cap
		dunstify -a "MICROPHONE" "Sound" "Capture" -i microphone-sensitivity-muted-symbolic -r 2593 -u normal
	fi
}

case "$1" in
	--vol) get_vol;;
	--icon) get_icon;;
	--toggle-muted) amixer -D pulse set Master toggle;;
	--inc) up;;
	--dec) down;;
	--toggle) mute;;
	--toggle_mic) mute_mic;;
esac
