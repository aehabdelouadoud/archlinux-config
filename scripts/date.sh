#!/bin/bash

# Function to generate professional availability
generate_availability() {
    local start_date=$(date -d "$1" +"%Y-%m-%d")  # Starting date (e.g., today, tomorrow, etc.)
    local num_days=$2  # Number of days to generate slots for

    echo "Dear Sir/Madam,"
    echo ""
    echo "Thank you for your time. Below are the proposed time slots for your convenience:"
    echo ""

    for i in $(seq 0 $((num_days - 1))); do
        local date_en=$(date -d "$start_date + $i days" +"%A, %B %d, %Y")
        
        echo "• $date_en: 10:00 AM - 12:00 PM or 2:00 PM - 4:00 PM"
        echo ""  # Empty line for better readability
    done

    echo "Please let me know if any of these slots work for you, or feel free to suggest alternate times."
    echo "Looking forward to your reply."
    echo ""
    echo "Best regards,"
    echo "Abdelouadoud AIT EL HAJ"
}

# Call the function with arguments (e.g., start from tomorrow, for 3 days)
generate_availability "$1" 3

