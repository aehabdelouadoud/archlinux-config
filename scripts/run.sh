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

# Get list of applications
apps=$(find /usr/share/applications ~/.local/share/applications -name "*.desktop" -print0 |
  xargs -0 grep -E '^Name=' |
  cut -d= -f2 |
  sort -u)

# Show menu and get user selection
selected_app=$(echo "$apps" | eval "$MENU")

# Find and launch the selected application
if [[ -n "$selected_app" ]]; then
  desktop_file=$(grep -ril "^Name=$selected_app" /usr/share/applications ~/.local/share/applications | head -n 1)
  if [[ -n "$desktop_file" ]]; then
    gtk-launch "$(basename "$desktop_file" .desktop)"
  else
    notify-send "Error" "Application not found!"
  fi
fi
