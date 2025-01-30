#!/bin/bash

# Check for required commands
if ! command -v pactl &> /dev/null; then
    echo "pactl not found! Please install pulseaudio-utils"
    exit 1
fi

if ! command -v notify-send &> /dev/null; then
    echo "notify-send not found! Please install libnotify-bin"
    exit 1
fi

show_notification() {
    local vol=$1
    local icon="audio-volume-high-symbolic"
    [ "$vol" -eq 0 ] && icon="audio-volume-muted-symbolic"
    [ "$vol" -lt 33 ] && icon="audio-volume-low-symbolic"
    [ "$vol" -ge 33 ] && [ "$vol" -lt 66 ] && icon="audio-volume-medium-symbolic"

    notify-send -u low -t 2000 -h int:value:$vol -h string:synchronous:volume \
        "Volume: $vol%" \
        --icon="$icon" \
        --hint=string:x-dunst-stack-tag:volume
}

get_current_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1 | tr -d '%'
}

adjust_volume() {
    case $1 in
        inc)
            pactl set-sink-volume @DEFAULT_SINK@ +1%
            ;;
        dec)
            current_vol=$(get_current_volume)
            if [ "$current_vol" -le 5 ]; then
                pactl set-sink-volume @DEFAULT_SINK@ -1%
            else
                pactl set-sink-volume @DEFAULT_SINK@ -1%
            fi
            ;;
        mute)
            pactl set-sink-mute @DEFAULT_SINK@ toggle
            ;;
    esac
}

# Main execution
case $1 in
    inc|dec|mute)
        adjust_volume "$1"
        # Get updated volume (handle mute differently)
        if [ "$1" = "mute" ]; then
            muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -oP 'Mute: \K\w+')
            if [ "$muted" = "yes" ]; then
                notify-send -u low -t 2000 --icon=audio-volume-muted-symbolic "Volume Muted"
            else
                show_notification "$(get_current_volume)"
            fi
        else
            show_notification "$(get_current_volume)"
        fi
        ;;
    *)
        echo "Usage: $0 [inc|dec|mute]"
        exit 1
        ;;
esac

