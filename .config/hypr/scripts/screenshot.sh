#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 [--monitor | --window | --select]"
    echo "  --monitor  : Capture the current monitor"
    echo "  --window   : Capture a specific window"
    echo "  --select   : Select a region to capture"
    exit 1
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    usage
fi

# Parse arguments
case $1 in
    --monitor)
        MODE="monitor"
        ;;
    --window)
        MODE="window"
        ;;
    --select)
        MODE="region"
        ;;
    *)
        usage
        ;;
esac

# Capture based on mode
case $MODE in
    monitor)
        grimblast save output /tmp/temp_screenshot.png
        satty -f /tmp/temp_screenshot.png
        ;;
    window)
        grimblast save window /tmp/temp_screenshot.png
        satty -f /tmp/temp_screenshot.png
        ;;
    region)
        grimblast save area /tmp/temp_screenshot.png
        satty -f /tmp/temp_screenshot.png
        ;;
esac

rm /temp/temp_screenshot.png

