#!/bin/sh

EMOJIFILE="$HOME/.local/bin/emojis"

WIDTH=1200
LINES=20

# Show a list of emoji and put the selected emoji to variable $SYMBOL
SYMBOL=$(rofi -dmenu \
-lines "$LINES" \
-p ">" \
-width "$WIDTH" \
< "$EMOJIFILE" | cut -d ' ' -f 1)

# If nothing was selected
[ -z "$SYMBOL" ] && exit

# Otherwise send a notification
printf "%s" "$SYMBOL" | xclip && notify-send "$SYMBOL copied"
