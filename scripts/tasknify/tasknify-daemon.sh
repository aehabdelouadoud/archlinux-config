#!/bin/bash

PIDFILE="$HOME/.tasknify.pid"
LOGFILE="$HOME/.tasknify.log"
SLEEP_DURATION=100

# Ensure only one instance runs
if [ -f "$PIDFILE" ]; then
  echo "Daemon already running (PID $(cat $PIDFILE))." >&2
  exit 1
fi

# Save PID
echo $$ >"$PIDFILE"

# Cleanup on exit
trap 'rm -f "$PIDFILE"; exit' SIGTERM SIGINT

# Main loop
while true; do
  # Run your notification script
  "$HOME/dotfiles/scripts/tasknify/tasknify.sh" >>"$LOGFILE" 2>&1 # Optional: Log output

  # Wait 30 minutes
  sleep "$SLEEP_DURATION"
done

rm "$PIDFILE"
