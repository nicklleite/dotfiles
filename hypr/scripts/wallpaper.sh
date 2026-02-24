#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Listar wallpapers e escolher com wofi
SELECTED=$(ls -1 "$WALLPAPER_DIR" | wofi --dmenu --prompt "Escolher wallpaper:")

if [ -n "$SELECTED" ]; then
    killall hyprpaper
    echo "preload = $WALLPAPER_DIR/$SELECTED" > ~/.config/hypr/hyprpaper.conf
    echo "wallpaper = ,$WALLPAPER_DIR/$SELECTED" >> ~/.config/hypr/hyprpaper.conf
    echo "splash = false" >> ~/.config/hypr/hyprpaper.conf
    hyprpaper &
    notify-send "Wallpaper" "Alterado para: $SELECTED"
fi
