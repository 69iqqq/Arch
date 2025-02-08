#!/bin/bash
#
# # Check if Waybar is running
# if pgrep -x "ironbar" >/dev/null; then
#   # If Waybar is running, kill the process
#   echo "Waybar is running. Disabling..."
#   # pkill -x "waybar"
#   pkill -x "ironbar"
# else
#   # If Waybar is not running, start it
#   echo "Waybar is not running. Enabling..."
#   # waybar &
#   ironbar &
#   # waybar -c ~/.config/waybar/configs/config -s ~/.config/waybar/styling/style.css &
# fi
#
# Check if swaync is running
# if pgrep -x "swaync" >/dev/null; then
#   # If swaync is running, kill the process
#   echo "swaync is running. Disabling..."
#   pkill -x "swaync"
# else
#   # If swaync is not running, start it
#   echo "swaync is not running. Enabling..."
#   swaync &
# fi

echo "Checking if ironbar is running..."
if pgrep -x "ironbar" >/dev/null; then
  echo "ironbar is running. Killing all instances..."
  pkill -x "ironbar"
  sleep 1 # Give it time to stop completely
else
  echo "ironbar is not running. Starting it..."
  /home/abir/.cargo/bin/ironbar &
  disown
fi

# Start a fresh instance of ironbar
