#!/bin/bash

# Idle time threshold in milliseconds (5 minutes = 300,000 ms)
IDLE_THRESHOLD=300000

while true; do
  # Get the current idle time in milliseconds
  IDLE_TIME=$(hyprctl monitors -j | jq '.[0].idle')

  # If the idle time exceeds the threshold, run hyprlock
  if [ "$IDLE_TIME" -ge "$IDLE_THRESHOLD" ]; then
    hyprlock
    # Sleep for a while to avoid spamming hyprlock
    sleep 60
  fi

  # Check again after a short delay
  sleep 5
done

