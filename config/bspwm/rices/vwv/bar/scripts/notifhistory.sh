#!/bin/bash

IFS=$'\n'

notifs="(box :orientation \"v\" :spacing 10"

if [ -s ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh ]; then
    echo "ignore this"
else 
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral=""
    exit 1
fi

last_lines=$(awk '/^IFS=$/{count=1;next} count{++count; lines[count]=$0} END{for(i=count; i>0; i--) print lines[i]}' ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh | tail -n 15)
line_count=$(awk '/^IFS=$/{count=1;next} count{++count} END{print count}' ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh)

for line in $last_lines; do
    notifs+="(box :orientation \"v\" :space-evenly \"false\" :valign \"end\" :class \"notificationbox\" \
            (box :spacing 10 :space-evenly \"false\" \
                (label :class \"summary\" :text \"$(echo "$line" | jq -r '.summary' | cut -c1-40)\" :halign \"start\") \
            ) \
            (label :class \"body\" :text \"$(echo "$line" | jq -r '.body' | cut -c1-40)\" :halign \"start\" :limit-width "25") \
            )"
done

if [ "$line_count" -gt 5 ]; then
    ncard="(box :orientation 'vertical' :class 'notification-scroll-box' :spacing 10 :space-evenly 'false' $notifs))"
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral="(scroll :height 420 :vscroll true $ncard)"
else
    eww -c /home/sebas/.config/bspwm/rices/vwv/bar/ update notifsliteral="$notifs)"
fi
    
IFS=
