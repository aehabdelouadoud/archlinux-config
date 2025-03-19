#!/usr/bin/env bash

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
    -p  -l 11 --border=0 \
    -R 2 \
    --fn 'FiraCode Nerd Font 9'"

find /usr/share/applications ~/.local/share/applications -name "*.desktop" -print0 |
  xargs -0 grep -E '^Name=' |
  cut -d= -f2 |
  sort -u |
  eval "$MENU" |
  xargs -I {} sh -c "gtk-launch $(basename "$(grep -ril "Name={}" /usr/share/applications ~/.local/share/applications)")"
