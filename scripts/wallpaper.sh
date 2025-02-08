WALLPAPER_DIR="$HOME/wallpapers"

# Use Rofi to display a menu of wallpapers, including icons for .jpg files
SELECTED_WALLPAPER=$(for a in "$WALLPAPER_DIR"/*.{jpg,png}; do
  echo -en "$(basename "$a")\0icon\x1f$a\n"
done | rofi -dmenu -replace -config ~/scripts/style.rasi -p " ")

if [ -n "$SELECTED_WALLPAPER" ]; then

  # hyprctl hyprpaper preload "$WALLPAPER_DIR/$SELECTED_WALLPAPER"
  # hyprctl hyprpaper wallpaper ", $WALLPAPER_DIR/$SELECTED_WALLPAPER"

  SYMLINK_CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
  SYMLINK_LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
  TARGET_FILE=$(readlink -f "$SYMLINK_CONFIG_FILE")
  TARGET_FILE2=$(readlink -f "$SYMLINK_LOCK_CONFIG")

  wal -i "$WALLPAPER_DIR/$SELECTED_WALLPAPER"

  sed -i -e "s|preload = .*|preload = $WALLPAPER_DIR/$SELECTED_WALLPAPER|" \
    -e "s|wallpaper = ,.*|wallpaper = ,$WALLPAPER_DIR/$SELECTED_WALLPAPER|" "$TARGET_FILE"
  sed -i -e "s|path = .*|path = $WALLPAPER_DIR/$SELECTED_WALLPAPER|" "$TARGET_FILE2"

  killall hyprpaper
  hyprpaper

fi
