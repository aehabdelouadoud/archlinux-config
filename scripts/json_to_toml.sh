#!/bin/bash

# Function to convert JSON to TOML
json_to_toml() {
    local json_file="$1"
    local toml_file="$2"

    # Read JSON and convert to TOML
    jq -r 'to_entries | map("\(.key) = \(.value | @json)") | .[]' "$json_file" > "$toml_file"

    # Display a success message
    echo "Converted $json_file to $toml_file"
}

# Run the function with arguments
json_to_toml "$1" "$2"

