#!/bin/bash

# Configuration file path for BT and Wifi config
CONFIG_FILE="/boot/config.txt"

# Lines to be added to disable Bluetooth and Wifi on Raspberry Pi
LINE1="dtoverlay=disable-wifi"
LINE2="dtoverlay=disable-bt"

# Main folder to be created to hold docker configs as well as subfolders got docker configs
MAIN_FOLDER="/home/dietpi/compose-files"
SUBFOLDERS=("pihole" "adguardhome" "dozzle" "unifi-netapp")

# Function to add a line if it does not already exist
add_line() {
    local line=$1
    local file=$2
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

###########################################
# Configurations for BT and Wifi for Pi
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

###########################################
# Configurations for Docker Compose files 
###########################################

# Create the main folder if it does not exist
if [ ! -d "$MAIN_FOLDER" ]; then
    mkdir -p "$MAIN_FOLDER"
    chown dietpi:dietpi "$MAIN_FOLDER"
    echo "Folder $MAIN_FOLDER created and ownership set to dietpi."
else
    echo "Folder $MAIN_FOLDER already exists."
fi

# Create subfolders and set ownership
for folder in "${SUBFOLDERS[@]}"; do
    subfolder_path="$MAIN_FOLDER/$folder"
    if [ ! -d "$subfolder_path" ]; then
        mkdir -p "$subfolder_path"
        chown dietpi:dietpi "$subfolder_path"
        echo "Subfolder $subfolder_path created and ownership set to dietpi."
    else
        echo "Subfolder $subfolder_path already exists."
    fi
done
