#!/bin/bash

FILE=~/.config/bspwm/rices/vwv/bar/lightlock
if [ -f "$FILE" ]; then
    sed -i -e 's/#e2e2e2/#252525/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/#d3d3d3/#1a1a1a/g' ~/.config/bspwm/rices/vwv/bar/eww.scss
    sed -i -e 's/#f5f5f5/#111111/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc

    sed -i -e 's/white/DUMMY/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/black/white/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/DUMMY/black/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc

    sed -i -e 's/#c5c5c5/#1b1b1b/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/#464646/#d6d6d6/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    rm $FILE
    pkill dunst && pkill rofi
else
    sed -i -e 's/#111111/#f5f5f5/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/#1a1a1a/#d3d3d3/g' ~/.config/bspwm/rices/vwv/bar/eww.scss
    sed -i -e 's/#252525/#e2e2e2/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc

    sed -i -e 's/white/DUMMY/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/black/white/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/DUMMY/black/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc

    sed -i -e 's/#1b1b1b/#c5c5c5/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    sed -i -e 's/#d6d6d6/#464646/g' ~/.config/bspwm/rices/vwv/bar/eww.scss ~/.config/bspwm/rices/vwv/config.rasi ~/.config/bspwm/rices/vwv/dunstrc
    touch $FILE
    pkill dunst && pkill rofi
fi
