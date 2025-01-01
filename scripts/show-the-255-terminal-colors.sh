#!/bin/bash
# This script displays the 256 terminal colors with their respective codes in a box format.

# Function to print a color block with the color code
print_color_block() {
  local code=$1
  printf "\e[48;5;%sm\e[38;5;%sm%4d\e[0m " "$code" "$((code < 16 ? 15 : 0))" "$code"
}

# Print the color blocks in a box format
for i in {0..255}; do
  print_color_block $i
  # Print a newline every 16 colors
  if (( (i + 1) % 16 == 0 )); then
    echo
  fi
done

