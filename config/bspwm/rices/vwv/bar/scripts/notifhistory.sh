#!/bin/bash

IFS=$'\n'

notifs="(box :orientation \"v\" :spacing 10"

if [ -s ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh ]; then
    echo "ignore this"
else 
    eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral=""
    exit 1
fi

last_lines=$(awk '/^IFS=$/{count=1;next} count{++count; lines[count]=$0} END{for(i=count; i>0; i--) print lines[i]}' ~/.config/bspwm/rices/vwv/bar/scripts/notifhistory.sh)
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
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"PXNDX - Romance en Re sostenido", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"PXNDX - Romance en Re sostenido", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Santi Muk - Besos, Limón y Miel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Santi Muk - Besos, Limón y Miel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Policias y Ladrones - :)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Policias y Ladrones - :)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Molinette Cinema - Mariana", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Molinette Cinema - Mariana", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter - Rincón Yucateco", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter - Rincón Yucateco", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Buen Viaje", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Buen Viaje", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Comisario Pantera - Amiga - Bonus Track", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Comisario Pantera - Amiga - Bonus Track", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Molinette Cinema - Ansiedad", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Molinette Cinema - Ansiedad", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter - Murciélago", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter - Murciélago", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Zoé - Luna - En Vivo", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Zoé - Luna - En Vivo", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Volamos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Volamos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Cosmovision - Red Eyes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Cosmovision - Red Eyes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Costera - Me Quitas El Aire", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Costera - Me Quitas El Aire", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Odisseo - Los Imanes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Odisseo - Los Imanes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter, Ana Torroja - Cachito De Galaxia", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Porter, Ana Torroja - Cachito De Galaxia", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Mamá TV - ﻿Mamá Tv Gluten Free", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Mamá TV - ﻿Mamá Tv Gluten Free", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Corazón Attack - 100 Años", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Corazón Attack - 100 Años", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"División Minúscula - Humanos Como Tú", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"División Minúscula - Humanos Como Tú", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha, Ximena Sariñana - Respiro (Cap. 8)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha, Ximena Sariñana - Respiro (Cap. 8)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Estéreo Waves - Hiroshima", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Estéreo Waves - Hiroshima", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Nunca Me Dejes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Nunca Me Dejes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"DLD - Todo Cuenta", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"DLD - Todo Cuenta", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Little Jesus - ﻿Químicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Little Jesus - ﻿Químicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"DRIMS - ¿Qué Nos Pasó?", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"DRIMS - ¿Qué Nos Pasó?", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Santi Muk - Besos, Limón y Miel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Santi Muk - Besos, Limón y Miel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Química", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Química", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Volamos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Nuevo Vintage - Volamos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Camilo Séptimo - Como Tú", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Camilo Séptimo - Como Tú", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha - Únicos", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Ultra P, Películas Geniales - Todo Mal", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Señor Kino - Verde Pastel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Señor Kino - Verde Pastel", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Nunca Me Dejes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Reyno - Nunca Me Dejes", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"León Larregui - Como Tú (Magic Music Box)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"León Larregui - Como Tú (Magic Music Box)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha, Ximena Sariñana - Respiro (Cap. 8)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Siddhartha, Ximena Sariñana - Respiro (Cap. 8)", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Daniel Quién - Aroma A Nostalgia", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Daniel Quién - Aroma A Nostalgia", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Los Plastics Revolution - Cuernavaca", "icon":""}
{"summary":"Reproductor multimedia VLC", "source":"vlc", "body":"Los Plastics Revolution - Cuernavaca", "icon":""}
