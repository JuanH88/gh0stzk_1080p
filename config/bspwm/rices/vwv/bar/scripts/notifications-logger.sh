#!/bin/bash

# Notifications Tiramisu or Dunst(dunstrc)
{ tiramisu -o "{\"summary\":\"#summary\", \"source\":\"#source\", \"body\":\"#body\"}" || { [[ -n $DUNST_ID ]] && echo "{\"summary\":\"$DUNST_SUMMARY\", \"source\":\"$DUNST_APP_NAME\", \"body\":\"$DUNST_BODY\"}"; }; } | while read -r line; do
    # Generar un número aleatorio para el ID
    while true; do
        number=$(od -An -N2 -d /dev/urandom | tr -d ' ')
        if [[ $number -ge 10000 ]] && [[ $number -le 99999 ]]; then
            break
        fi
    done

    # Insertar el número aleatorio como "id" en el JSON
    line=$(jq --arg number "$number" '. + {id: $number}' <<< "$line")

    # Formatear el JSON en una sola línea
    line=$(echo "$line" | jq -c '.')

    # Extraer el cuerpo de la notificación para verificar duplicados
    body=$(echo "$line" | jq -r '.body')

    # Verificar si ya existe una notificación con el mismo cuerpo en el historial
    if ! grep -qF "\"body\":\"$body\"" ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh; then
        if ! grep -qE "Spotify|VOLUME|MICROPHONE|Brightness" <<< "$line"; then
            echo "$line" >> ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh
            bash ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh > /dev/null 2>&1
        fi

        eww -c ~/.config/bspwm/rices/vwv/bar/ update notification="$line"
        ([[ $(eww -c ~/.config/bspwm/rices/vwv/bar/ active-windows | grep notificationwidget) == "" ]] && eww -c ~/.config/bspwm/rices/vwv/bar/ open notificationwidget --no-daemonize )
        eww -c ~/.config/bspwm/rices/vwv/bar/ update notificationreveal=true

        (sleep 3s && eww -c ~/.config/bspwm/rices/vwv/bar/ update notificationreveal=false && sleep 0.5s && eww -c ~/.config/bspwm/rices/vwv/bar/ close notificationwidget) &
    fi
done
