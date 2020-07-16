#!/bin/sh

EMOJIFILE="$HOME/.local/bin/emojis"

SYMBOL=$(rofi -dmenu -p ">" < "$EMOJIFILE" | cut -d ' ' -f 1)

# If nothing was selected
[ -z "$SYMBOL" ] && exit

# Otherwise send a notification
printf "%s" "$SYMBOL" | xclip && notify-send "$SYMBOL copied"
