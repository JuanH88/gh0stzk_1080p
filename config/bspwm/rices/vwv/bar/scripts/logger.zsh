#!/usr/bin/env zsh

function _set_vars() {
  typeset -gx DUNST_CACHE_DIR="$HOME/.cache/dunst"
  typeset -gx DUNST_LOG="$DUNST_CACHE_DIR/notifications.txt"
  typeset -gx ICON_THEME="Papirus"
  typeset -gx SPOTIFY_TITLE="$(playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}' 2>/dev/null)"
}
_set_vars

function _unset_vars() {
  unset DUNST_CACHE_DIR
  unset DUNST_LOG
}

mkdir "$DUNST_CACHE_DIR" 2>/dev/null
touch "$DUNST_LOG" 2>/dev/null

function create_cache() {
  local urgency
  case "$DUNST_URGENCY" in
    "LOW"|"NORMAL"|"CRITICAL") urgency="$DUNST_URGENCY";;
    *) urgency="OTHER";;
  esac

  local summary
  local body
  [ "$DUNST_SUMMARY" = "" ] && summary="Summary unavailable." || summary="$DUNST_SUMMARY"
  [ "$DUNST_BODY" = "" ] && body="Body unavailable." || body="$(print "$DUNST_BODY" | recode html)"
  
  if [[ "$summary" == *"Spotify"* ]] || [[ "$body" == *"Spotify"* ]] \
     || [[ "$summary" == *"Sound"* ]] || [[ "$body" == *"VOLUME"* ]] \
     || [[ "$summary" == *"MICROPHONE"* ]] || [[ "$body" == *"MICROPHONE"* ]] \
     || [[ "$summary" == *"Brightness"* ]] || [[ "$body" == *"Brightness"* ]]; then
    return
  fi

  local glyph
  case "$urgency" in
    "LOW") glyph="";;
    "NORMAL") glyph="";;
    "CRITICAL") glyph="";;
    *) glyph="";;
  esac

  # Fix for discord web
  if [[ $body == *"discord"* ]]
  then
    fixed_body=$(echo $DUNST_BODY | awk FNR==3)
    if [[ ${#fixed_body} -ge 30 ]]
    then
      body=$(python -c "print('${fixed_body}' + ' ...')")
    else
      body=$fixed_body
    fi
  fi

  # Fix for spotify
  if [[ $DUNST_APP_NAME == "Spotify" ]]
  then
    if [[ ${#DUNST_BODY} -ge 30 ]]
    then
      fixed_body=$(echo $DUNST_BODY | cut -c 1-30)
      body=$(python -c "print('${fixed_body}' + ' ...')")
    else
      body=$DUNST_BODY
    fi 
    if [[ ${#DUNST_SUMMARY} -ge 25 ]]
    then
      fixed_summary=$(echo $DUNST_SUMMARY | cut -c 1-25)
      summary=$(python -c "print('${fixed_summary}' + ' ...')")
    else
      summary=$DUNST_SUMMARY
    fi
  fi

  if [[ $DUNST_ICON_PATH == "" ]]
  then
    ICON_PATH=/usr/share/icons/Papirus/128x128/apps/$DUNST_APP_NAME.svg
  else
    FIXED_ICON_PATH=$(echo ${DUNST_ICON_PATH} | sed 's/32x32/48x48/g')
    ICON_PATH=$FIXED_ICON_PATH
  fi

  if [[ $DUNST_APP_NAME == "Spotify" ]]
  then
    ICON_PATH=$HOME/.cache/temp-$SPOTIFY_TITLE.png
  fi

  # pipe stdout -> pipe cat stdin (cat conCATs multiple files and sends to stdout) -> absorb stdout from cat
  # concat: "one" + "two" + "three" -> notice how the order matters i.e. "one" will be prepended
  #print '(notification-card :class "notification-card notification-card-'$urgency' notification-card-'$DUNST_APP_NAME'" :SL "'$DUNST_ID'" :L "dunstctl history-pop '$DUNST_ID'" :body "'$body'" :summary "'$summary'" :image "'$ICON_PATH'" :application "'$DUNST_APP_NAME'")' \
  print '(box :orientation "v" :space-evenly "false" :valign "end" :class "notificationbox" (box :spacing 10 :space-evenly "false" (label :class "summary" :text "'$summary'" :halign "start")) (label :class "body" :text "'$body'" :halign "start" :limit-width "25"))' \
    | cat - "$DUNST_LOG" \
    | sponge "$DUNST_LOG"
}

function compile_caches() { tr '\n' ' ' < "$DUNST_LOG" }
eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral="ok"
function make_literal() {
  local caches="$(compile_caches)"
  local ncard="$(print "(box :orientation 'vertical' :class 'notification-scroll-box' :spacing 10 :space-evenly 'false' $caches)")"
  [[ "$caches" == "" ]] && print '' || print $ncard
  if [ "$(cat $DUNST_LOG | wc --lines)" -gt 5 ]; then
    print "(scroll :height 420 :vscroll true $ncard)"
  fi
}

function clear_logs() {
  killall dunst 2>/dev/null
  eww -c ~/.config/bspwm/rices/vwv/bar/ update notifsliteral=""
  dunst -config ~/.config/bspwm/rices/vwv/dunstrc & disown
  print > "$DUNST_LOG"
  rm -rf $HOME/.cache/temp*.png
}

function pop() { sed -i '1d' "$DUNST_LOG" }

function drop() { sed -i '$d' "$DUNST_LOG" }

function remove_line() { sed -i '/SL "'$1'"/d' "$DUNST_LOG" }

function critical_count() { 
  local crits=$(cat $DUNST_LOG | grep CRITICAL | wc --lines)
  local total=$(cat $DUNST_LOG | wc --lines)
  [ $total -eq 0 ] && echo 0 || echo $(((crits*100)/total))
}

function normal_count() { 
  local norms=$(cat $DUNST_LOG | grep NORMAL | wc --lines)
  local total=$(cat $DUNST_LOG | wc --lines)
  [ $total -eq 0 ] && echo 0 || echo $(((norms*100)/total))
}

function low_count() { 
  local lows=$(cat $DUNST_LOG | grep LOW | wc --lines)
  local total=$(cat $DUNST_LOG | wc --lines)
  [ $total -eq 0 ] && echo 0 || echo $(((lows*100)/total))
}

function tot_count() {
    echo `cat $DUNST_LOG | wc --lines`
}

function subscribe() {
  make_literal
  local lines=$(cat $DUNST_LOG | wc -l)
  while sleep 0.1; do
    local new=$(cat $DUNST_LOG | wc -l)
    [[ $lines -ne $new ]] && lines=$new && print
  done | while read -r _ do; make_literal done
}

case "$1" in
  "pop") pop;;
  "drop") drop;;
  "clear") clear_logs;;
  "subscribe") subscribe;;
  "rm_id") remove_line $2;;
  "crits") critical_count;;
  "lows") low_count;;
  "norms") normal_count;;
  "tot") tot_count;;
  *) create_cache;;
esac

sed -i '/^$/d' "$DUNST_LOG"
_unset_vars

# vim:ft=zsh
