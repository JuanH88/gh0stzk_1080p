#!/bin/bash

tiramisu -o "{\"summary\":\"#summary\", \"source\":\"#source\", \"body\":\"#body\", \"icon\":\"#icon\"}" | while read -r line; do
    while true; do
        number=$(od -An -N2 -d /dev/urandom)
        if [[ $number -ge 10000 ]] && [[ $number -le 99999 ]]; then
            echo $number > "notifid"
            break
        fi
    done

    if ! grep -qE "Spotify|VOLUME|MICROPHONE|Brightness" <<< "$line"; then
        echo "$line" >> ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh
        bash ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh > /dev/null 2>&1
    fi

    number=$(head -n 1 "notifid")
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notification="$line"
    ([[ $(eww -c ~/.config/bspwm/rices/vwv/bar/ active-windows | grep notificationwidget) == "" ]] && eww -c ~/.config/bspwm/rices/vwv/bar/ open notificationwidget --no-daemonize )
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notificationreveal=true 

    (sleep 3s; [[ $(head -n 1 "notifid") == $number ]] && eww -c ~/.config/bspwm/rices/vwv/bar/ update notificationreveal=false && sleep 0.5s && eww -c ~/.config/bspwm/rices/vwv/bar/ close notificationwidget) &
done
