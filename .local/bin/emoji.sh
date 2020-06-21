#!/bin/sh

EMOJIFILE="$HOME/.local/bin/emojis"

##############
# Dimensions #
##############
WIDTH=1200
LINES=20

##############
# Appearance #
##############
FONT="Terminus 18"

# Linepadding needs to be set depending on the font so the emoji won't get
# clipped vertically
LINEPADDING=8

BG="#282828"; FG="#a89984"; HLBG="#d65d0e"; HLFG="#ebdbb2"
#BG="#000000"; FG="#bbbbbb"; HLBG="#005577"; HLFG="#eeeeee"
#BG="#ccffffff"; FG="#000000"; HLBG="#5c5cff"; HLFG="#000000"
BORDERCOLOR="#504945"
BW=4
PADDING=0
LINEMARGIN=0

# Show a list of emoji and put the selected emoji to variable $SYMBOL
SYMBOL=$(rofi -dmenu -font "$FONT" -separator-style none -columns 1 \
-bw "$BW" \
-color-normal "0,$FG,0,$HLBG,$HLFG" \
-color-window "$BG, $BORDERCOLOR, $HLBG" \
-line-margin "$LINEMARGIN" \
-line-padding "$LINEPADDING" \
-lines "$LINES" \
-p "Copy emoji to clipboard" \
-padding "$PADDING" \
-width "$WIDTH" \
< "$EMOJIFILE" | cut -d ' ' -f 1)

# If nothing was selected
[ -z "$SYMBOL" ] && exit

# Otherwise send a notification
printf "%s" "$SYMBOL" | xclip && notify-send "$SYMBOL copied"
