#!/bin/sh

EMOJIFILE="$HOME/.local/bin/emojis"

# Rofi loads the file much faster than dmenu
# Also dmenu doesn't show emojis with multiple codes correctly
SYMBOL=$(rofi -dmenu -p ">" < "$EMOJIFILE" | cut -d ' ' -f 1)
#SYMBOL=$(sed '/U+.*U+/d' < "$EMOJIFILE" | dmenu -l 15 | cut -d ' ' -f 1)

[ -n "$SYMBOL" ] && printf "%s" "$SYMBOL" | xclip -selection CLIPBOARD && notify-send "$SYMBOL copied"
