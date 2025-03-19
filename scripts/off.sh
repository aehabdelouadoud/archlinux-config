#!/bin/bash

# Configure menu tool (bemenu with Gruvbox Material colors)
MENU="bemenu \
    --nb '#32302F' --nf '#ddc7a1' \
    --sb '#32302f' --sf '#ebdbb2' \
    --hb '#D8A657' --hf '#292828' \
    --fb '#504945' --ff '#bdae93' \
    --tb '#504945' --tf '#a9b665' \
    --cb '#a9b665' --cf '#EA6962' \
    --bdr '#32302F' \
    --ignorecase \
    -p '󰌆 ' -l 10 --border=0 \
    -R 2 \
    --fn 'FiraCode Nerd Font 9'"

choice=$(echo -e "Lock screen\nSleep\nTurn off" | eval "$MENU")

case "$choice" in
"Lock screen") i3lock ;;
"Sleep") systemctl suspend ;;
"Turn off")
  confirm=$(echo -e "No\nYes" | eval "$MENU" -p "Are you sure? ")
  if [ "$confirm" = "Yes" ]; then
    systemctl poweroff
  else
    notify-send "Shutdown canceled."
  fi
  ;;
*) echo "No valid option selected." ;;
esac
