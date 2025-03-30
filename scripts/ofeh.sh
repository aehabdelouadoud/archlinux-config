#!/bin/bash

# Function to display help message
usage() {
  echo "Usage: $0 <URL>"
  echo ""
  echo "Arguments:"
  echo "  <URL>   The URL of the image to download and display."
  echo ""
  echo "Options:"
  echo "  -h, --help  Show this help message and exit."
  echo ""
  echo "Description:"
  echo "  This script downloads an image from the given URL and opens it with the 'feh' image viewer."
}

# If -h or --help is passed, show help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

# Main functionality: download image and open with feh
if [[ -n "$1" ]]; then
  wget -O /tmp/temp_image.jpg "$1" && feh /tmp/temp_image.jpg
else
  echo "Error: URL is required."
  usage
  exit 1
fi

