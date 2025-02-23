#!/usr/bin/env bash

# Configure menu tool (bemenu with Gruvbox Material colors)
MENU="bemenu \
    --nb '#32302F' --nf '#ddc7a1' \
    --sb '#32302f' --sf '#ebdbb2' \
    --hb '#D8A657' --hf '#292828' \
    --fb '#504945' --ff '#bdae93' \
    --tb '#504945' --tf '#a9b665' \
    --cb '#a9b665' --cf '#EA6962' \
    --bdr '#32302F' \
    --ignorecase \
    -p '󰌆 ' -l 10 --border=0 \
    -R 2 \
    --fn 'FiraCode Nerd Font 9'"

PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

# Detect clipboard tool
if [ -n "$WAYLAND_DISPLAY" ]; then
    CLIP="wl-copy"
    CLEAR_CLIP="wl-copy --clear"
else
    CLIP="xclip -selection clipboard"
    CLEAR_CLIP="echo -n | xclip -selection clipboard"
fi

# Get password entries
entries=$(find "$PASSWORD_STORE_DIR" -type f -name '*.gpg' 2>/dev/null | sed -e "s|^$PASSWORD_STORE_DIR/||" -e 's/\.gpg$//' | sort)

# Function to check password strength
check_password_strength() {
    local password="$1"
    local score=0
    [[ ${#password} -ge 12 ]] && ((score+=1))        # Length check
    [[ $password =~ [A-Z] ]] && ((score+=1))         # Uppercase check
    [[ $password =~ [a-z] ]] && ((score+=1))         # Lowercase check
    [[ $password =~ [0-9] ]] && ((score+=1))         # Number check
    [[ $password =~ [^a-zA-Z0-9] ]] && ((score+=1))  # Special character check

    case $score in
        0|1) echo "Very Weak";;
        2) echo "Weak";;
        3) echo "Moderate";;
        4) echo "Strong";;
        5) echo "Very Strong";;
    esac
}

# Function to generate a strong password
generate_password() {
    tr -dc 'A-Za-z0-9!@#$%^&*()-_=+' < /dev/urandom | head -c 16
}

# Choose Action
action=$(printf "View\nAdd\nEdit" | eval "$MENU -p ' Action'")

case $action in
    "Add")
        # Get entry name
        entry_name=$(echo "" | eval "$MENU -p 'New Entry Name: '")
        [ -z "$entry_name" ] && exit 0

        # Choose password entry method
        pass_method=$(printf "Manually Enter\nGenerate Automatically" | eval "$MENU -p ' Password Method'")

        if [[ "$pass_method" == "Generate Automatically" ]]; then
            password=$(generate_password)
            confirm=$(printf "Use This\nRegenerate" | eval "$MENU -p 'Generated: $password'")
            while [[ "$confirm" == "Regenerate" ]]; do
                password=$(generate_password)
                confirm=$(printf "Use This\nRegenerate" | eval "$MENU -p 'Generated: $password'")
            done
        else
            # Manually enter password with strength check
            while true; do
                password=$(echo "" | eval "$MENU -p 'Enter Password: '")
                [ -z "$password" ] && exit 0

                strength=$(check_password_strength "$password")
                confirm=$(printf "Proceed\nRe-enter Password" | eval "$MENU -p 'Password Strength: $strength'")

                [[ "$confirm" == "Proceed" ]] && break
            done
        fi

        # Collect extra fields
        extra_fields=()
        while true; do
            field_name=$(printf "Done\nusername\nemail\nurl\ncustom" | eval "$MENU -p 'Add Field (or Done): '")
            [[ "$field_name" == "Done" || -z "$field_name" ]] && break

            field_value=$(echo "" | eval "$MENU -p 'Enter value for $field_name: '")
            [ -z "$field_value" ] && continue

            extra_fields+=("$field_name: $field_value")
        done

        # Create pass entry
        {
            echo "$password"
            for field in "${extra_fields[@]}"; do
                echo "$field"
            done
        } | pass insert -m "$entry_name"

        notify-send "menupass" "󰌆 Entry '$entry_name' added!" -t 2000
        exit 0
        ;;
    "Edit")
        selected=$(echo "$entries" | eval "$MENU -p '󰌆 Select to Edit: '")
        [ -z "$selected" ] && exit 0
        hyprctl dispatch exec "[size 70%;float] kitty -e pass edit \"$selected\""
        exit 0
        ;;
    "View")
        selected=$(echo "$entries" | eval "$MENU -p '󰌆 Search: '")
        ;;
esac

[ -z "$selected" ] && exit 0

# Parse password file
content=$(pass show "$selected" 2>/dev/null)
if [ $? -ne 0 ]; then
    notify-send "menupass" "Error: Could not retrieve password." -t 2000
    exit 1
fi

fields=("password: $(head -n1 <<< "$content")")
while read -r line; do
    [[ $line =~ ^([^:]+):\ (.*) ]] && fields+=("${BASH_REMATCH[1]}: ${BASH_REMATCH[2]}")
done < <(tail -n +2 <<< "$content")

# Field selection
field=$(printf "%s\n" "${fields[@]%%:*}" | eval "$MENU -p ' Select Field:'")
[ -z "$field" ] && exit 0

# Extract value
value=$(grep "^${field}:" <<< "$content" | cut -d: -f2- | xargs)

if [[ "$field" == "url" || "$field" == "Wi-Fi" ]]; then
    action=$(printf "Copy to clipboard\nOpen with xdg-open\nGenerate QR Code" | eval "$MENU -p ' URL Action'")

    case $action in
        "Copy to clipboard")
            echo -n "$value" | $CLIP
            ;;
        "Open with xdg-open")
            xdg-open "$value"
            ;;
        "Generate QR Code")
            echo -n "$value" | qrencode -o- | display
            ;;
    esac
else
    echo -n "$value" | $CLIP
fi
(sleep 45; $CLEAR_CLIP) &>/dev/null &
notify-send "menupass" "󰌆 Copied ${field}!" -t 2000

