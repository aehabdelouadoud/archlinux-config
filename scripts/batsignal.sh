#!/bin/bash

# Ensure batsignal is installed and in PATH before running this script.
# Start batsignal with specified parameters.
batsignal -b -w 20 -W "Battery is at 20%. Connect the charger soon." -c 10 -C "Battery is critical! Connect the charger immediately." -d 5 -D "systemctl suspend" -f 90 -F "Battery is fully charged." -m 60

