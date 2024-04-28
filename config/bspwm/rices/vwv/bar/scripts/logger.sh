#!/usr/bin/env bash

function _set_vars() {
  export DUNST_CACHE_DIR="$HOME/.cache/dunst"
  export DUNST_LOG="$DUNST_CACHE_DIR/notifications.txt"
}
_set_vars

function _unset_vars() {
  unset DUNST_CACHE_DIR
  unset DUNST_LOG
}

mkdir "$DUNST_CACHE_DIR" 2>/dev/null
touch "$DUNST_LOG" 2>/dev/null

function create_cache() {
  local summary
  local body
  [ -z "$DUNST_SUMMARY" ] && summary="Summary unavailable." || summary="$DUNST_SUMMARY"
  [ -z "$DUNST_BODY" ] && body="Body unavailable." || body="$DUNST_BODY"
  
  # Exclude notifications by summary
  if grep -qE "Spotify|Sound|Brightness" <<< "$summary"; then
    return
  fi

  # Fix for discord web
  if [[ $body == *"discord"* ]]; then
    fixed_body=$(echo $DUNST_BODY | awk FNR==3)
    if [[ ${#fixed_body} -ge 25 ]]; then
      body=$(python -c "print('${fixed_body}' + ' ...')")
    else
      body=$fixed_body
    fi
  fi

  # Fix for spotify
  if [[ $DUNST_APP_NAME == "Spotify" ]]; then
    body="$(playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}' 2>/dev/null)"
    if [[ ${#DUNST_SUMMARY} -ge 25 ]]; then
      fixed_summary=$(echo $DUNST_SUMMARY | cut -c 1-25)
      summary=$(python -c "print('${fixed_summary}' + ' ...')")
    else
      summary=$DUNST_SUMMARY
    fi
  fi

  # pipe stdout -> pipe cat stdin (cat conCATs multiple files and sends to stdout) -> absorb stdout from cat
  # concat: "one" + "two" + "three" -> notice how the order matters i.e. "one" will be prepended
  #print '(notification-card :class "notification-card notification-card-'$urgency' notification-card-'$DUNST_APP_NAME'" :SL "'$DUNST_ID'" :L "dunstctl history-pop '$DUNST_ID'" :body "'$body'" :summary "'$summary'" :image "'$ICON_PATH'" :application "'$DUNST_APP_NAME'")' \
  printf '%s\n' '(box :orientation "v" :space-evenly "false" :valign "end" :class "notificationbox" (box :spacing 10 :space-evenly "false" (label :class "summary" :text "'"$(echo $DUNST_APP_NAME | tr '[:lower:]' '[:upper:]')"'" :halign "start")) (label :class "body" :text "'"$body"'" :halign "start" :limit-width "30"))' | cat - "$DUNST_LOG" | sponge "$DUNST_LOG"
}

function make_literal() {
  local caches="$(tr '\n' ' ' < "$DUNST_LOG")"
  local ncard="(box :orientation 'vertical' :class 'notification-scroll-box' :spacing 10 :space-evenly 'false' (box :orientation 'v' :spacing 10 $caches))"
  [[ "$caches" == "" ]] && printf '%s\n' '(box :orientation "vertical" :class "notification-scroll-box" :spacing 10 :space-evenly "false")' || { eww -c ~/.config/bspwm/rices/vwv/bar update notifsliteral="ok"; printf '%s\n' "$ncard"; }
  if [ "$(cat $DUNST_LOG | wc --lines)" -gt 5 ]; then
    printf '%s\n' "(scroll :height 420 :vscroll true $ncard)"
  fi
}

function clear_logs() {
  killall dunst 2>/dev/null
  dunst -config ~/.config/bspwm/rices/vwv/dunstrc & disown
  printf '%s\n' > "$DUNST_LOG"
  rm -rf $HOME/.cache/temp*.png
}

function subscribe() {
  make_literal
  local lines=$(cat $DUNST_LOG | wc -l)
  while sleep 0.1; do
    local new=$(cat $DUNST_LOG | wc -l)
    [[ $lines -ne $new ]] && lines=$new && printf '%s\n'
  done | while read -r _; do make_literal; done
}

case "$1" in
  "pop") sed -i '1d' "$DUNST_LOG";;
  "drop") sed -i '$d' "$DUNST_LOG";;
  "rm_id") sed -i '/SL "'$1'"/d' "$DUNST_LOG" $2;;
  "clear") clear_logs;;
  "subscribe") subscribe;;
  *) create_cache;;
esac

sed -i '/^$/d' "$DUNST_LOG"
_unset_vars

# vim:ft=zsh
