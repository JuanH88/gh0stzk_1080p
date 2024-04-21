#!/bin/bash

IFS=$'\n'

notifs="(box :orientation \"v\" :spacing 10"

if [ -s ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh ]; then
    echo "ignore this"
else 
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral=""
    exit 1
fi

last_lines=$(tail -n 5 ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh)

for line in $last_lines; do
    notifs+="(box :orientation \"v\" :space-evenly \"false\" :valign \"end\" :class \"notificationbox\" \
            (box :spacing 10 :space-evenly \"false\" \
                (label :class \"summary\" :text \"$(echo "$line" | jq -r '.summary' | cut -c1-40)\" :halign \"start\") \
            ) \
            (label :class \"body\" :text \"$(echo "$line" | jq -r '.body' | cut -c1-40)\" :halign \"start\") \
            )"
done

eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral="$notifs)"

IFS=
{"summary":"Screenshot Tool", "source":"Screenshot Tool", "body":"Screenshot taken successfully!", "icon":"/home/sebas/Imágenes/Screenshots/1713488153.png"}
{"summary":"Screenshot Tool", "source":"Screenshot Tool", "body":"Screenshot taken successfully!", "icon":"/home/sebas/Imágenes/Screenshots/1713488325.png"}
{"summary":"Brightness 65%", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/brightness.svg"}
{"summary":"Brightness 65%", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/brightness.svg"}
{"summary":"Brightness 60%", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/brightness.svg"}
{"summary":"sxhkd", "source":"dunstify", "body":"The configuration file has been reloaded successfully!", "icon":"/home/sebas/.config/bspwm/assets/reload.svg"}
{"summary":"'tiramisu' is not installed.", "source":"dunstify", "body":"", "icon":""}
{"summary":"Battery Low", "source":"notify-send", "body":"Connect Charger", "icon":""}
{"summary":"Mute", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/mute.png"}
{"summary":"Unmute", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/vol.png"}
{"summary":"Volume : 35%", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/vol.png"}
{"summary":"Volume : 30%", "source":"dunstify", "body":"", "icon":"/home/sebas/.config/bspwm/assets/vol.png"}
