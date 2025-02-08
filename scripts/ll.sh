#!/bin/bash
pidof hyprpaper || (
  hyprpaper &
  disown
)
monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')
cd /home/abir/wallpapers/
choice=$(fd . --type f -d 1 --format {/.} | shuf | fzf --cycle --preview='~/.config/hypr/scripts/utils/fzf-preview.sh {}' --preview-window=right,70% --info=hidden --color prompt:green,pointer:green,current-bg:-1,current-fg:green,gutter:-1,border:bright-black,current-hl:red,hl:red)
# hyprctl dispatch movetoworkspacesilent special:load
choice=$(fd $choice)

if [ $choice ]; then
  choice="/home/abir/wallpapers/$choice"
  hyprctl -q hyprpaper reload $monitor,$choice
  hyprctl -q hyprpaper unload unused
  killall auto_wallpaper_current.sh && pkill -f "sleep 3600"
  killall mpv
fi
