#!/bin/bash

swww-daemon

swww img "$(find ~/.config/hypr/assets/wallpapers -type f | shuf -n 1)" --transition-type any

