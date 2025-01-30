#!/bin/bash

# Check if notify-send is available
if ! command -v notify-send &> /dev/null; then
    echo "notify-send not found! Please install libnotify-bin"
    exit 1
fi

show_notification() {
    local percent=$1
    notify-send -u low -t 2000 -h int:value:$percent -h string:synchronous:brightness \
        "Brightness: $percent%" \
        --icon=display-brightness-symbolic
}

adjust_brightness() {
    if [ "$1" = "inc" ]; then
        brightnessctl set +1%
    elif [ "$1" = "dec" ]; then
        current_percent=$(brightnessctl info | grep -oP '\d+(?=%)' | head -n1)
        if [ "$current_percent" -lt 10 ]; then
            brightnessctl set -1
        else
            brightnessctl set 1%-
        fi
    fi

    # Get updated brightness percentage
    new_percent=$(brightnessctl info | grep -oP '\d+(?=%)' | head -n1)
    show_notification "$new_percent"
}

# Argument check
case $1 in
    inc|dec) adjust_brightness "$1" ;;
    *) echo "Usage: $0 [inc|dec]"; exit 1 ;;
esac

