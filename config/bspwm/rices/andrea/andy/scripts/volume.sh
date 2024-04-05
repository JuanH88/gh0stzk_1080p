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
  echo "images/$( [[ $vol == "0" ]] && echo "mute" || echo "volume" ).png"
}

case "$1" in
  --vol) get_vol;;
  --icon) get_icon;;
  --toggle-muted) amixer -D pulse set Master toggle;;
esac
