#!/bin/bash

swww-daemon

while true; do
    swww img "$(find ~/.config/hypr/assets/wallpapers -type f | shuf -n 1)" --transition-type any
    sleep 600 # 10 minutes
done

