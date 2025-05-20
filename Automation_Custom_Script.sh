#!/bin/bash

# Configuration file path for BT and Wifi config
CONFIG_FILE="/boot/config.txt"

# Lines to be added to disable Bluetooth and Wifi on Raspberry Pi
LINE1="dtoverlay=disable-wifi"
LINE2="dtoverlay=disable-bt"

# Function to add a line if it does not already exist
add_line() {
    local line=$1
    local file=$2
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

###########################################
# Disabling WiFi and Bluetooth on the Pi
###########################################

# Check if the file exists
if [ -f "$CONFIG_FILE" ]; then
    # Check if LINE1 exists in the file, if not, append it
    add_line "$LINE1" "$CONFIG_FILE"

    # Append LINE2 to the end of the file
    echo "$LINE2" >> "$CONFIG_FILE"

    echo "Lines processed and added as necessary."
else
    echo "Configuration file $CONFIG_FILE not found."
fi
