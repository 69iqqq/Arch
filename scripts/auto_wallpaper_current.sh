#!/bin/bash
while true; do
  # horiz
  pidof hyprpaper || (hyprpaper &)
  hyprctl -q hyprpaper reload eDP-1,$(fd . /home/abir/wallpapers/ --type f -d 1 | shuf -n 1)
  hyprctl -q hyprpaper unload unused
  sleep 3600
done
