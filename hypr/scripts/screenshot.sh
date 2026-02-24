#!/bin/bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILENAME="$DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

case $1 in
    full)
        # Tela inteira
        grim "$FILENAME"
        notify-send "Screenshot" "Tela inteira salva em $FILENAME"
        ;;
    area)
        # Área selecionada
        grim -g "$(slurp)" "$FILENAME"
        notify-send "Screenshot" "Área salva em $FILENAME"
        ;;
    window)
        # Janela ativa
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$FILENAME"
        notify-send "Screenshot" "Janela salva em $FILENAME"
        ;;
    clip)
        # Área selecionada para clipboard
        grim -g "$(slurp)" - | wl-copy
        notify-send "Screenshot" "Copiado para área de transferência"
        ;;
    *)
        echo "Uso: screenshot.sh {full|area|window|clip}"
        ;;
esac
