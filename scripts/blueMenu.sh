#!/bin/bash

# Check if bluetoothctl and dmenu are installed
if ! command -v bluetoothctl &> /dev/null || ! command -v wmenu &> /dev/null; then
    notify-send "PLEASE INSTALL BLUETOOTHCTL AND DMENU TO USE THIS SCRIPT."
    exit 1
fi

notify-send "SCANNING FOR BLUETOOTH DEVICES..."

# Get a list of devices and extract their names and MAC addresses
devices=$(bluetoothctl devices | grep -oP '(?<=Device ).*')

# Create an associative array to store device names and their MAC addresses
declare -A device_map

while IFS= read -r device_info; do
    mac_address=$(echo "$device_info" | awk '{print $1}')
    device_name=$(echo "$device_info" | awk '{$1=""; print $0}' | sed 's/^[ \t]*//')
    device_map["$device_name"]="$mac_address"
done <<< "$devices"

# Use dmenu to select a device by name
selected_device=$(printf '%s\n' "${!device_map[@]}" | wmenu -il 3 -f "JetBrainsMono Nerd Font 12" -N 1d2021 -n ebdbb2 -M 689d6a -m 1d2021 -S 689d6a -s 1d2021 -p "BLUETOOTH DEVICE:")

# Check if a device was selected
if [ -z "$selected_device" ]; then
    notify-send "NO DEVICE SELECTED. EXITING."
    exit 1
fi

# Get the MAC address of the selected device
selected_mac="${device_map[$selected_device]}"

notify-send "CONNECTING TO BLUETOOTH DEVICE: $selected_device ($selected_mac)"

# Start bluetoothctl in a subshell to connect to the selected device by its MAC address
(
echo "power on"                   # Ensure Bluetooth is powered on
sleep 2                            # Wait for Bluetooth to power on
echo "connect $selected_mac"      # Connect to the selected device by its MAC address
sleep 5                            # Wait for the connection to establish (adjust as needed)
) | bluetoothctl

notify-send "CONNECTION COMPLETE."
