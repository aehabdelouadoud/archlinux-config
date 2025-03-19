#!/bin/bash
# overdue=$(task +OVERDUE count)
# due=$(task +DUE count)

# TODO: Add checking is the daemon running or not.

pending=$(task +PENDING count)

if [[ $pending -gt 0 ]]; then
  notify-send -u normal -i $HOME/dotfiles/scripts/tasknify/assets/taskwarrior.svg "Tasknify" "You have <span color='#D8A657' font='15px'><b>$pending</b></span> tasks to finish"
  paplay $HOME/dotfiles/scripts/tasknify/assets/notification-sound.mp3
fi
