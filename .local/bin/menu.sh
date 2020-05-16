#!/bin/sh

# Dimensions
WIDTH=300
LINES=20

# Appearance
FONT="xos4 Terminus 18"

BG="#282828"; FG="#a89984"; HLBG="#d65d0e"; HLFG="#ebdbb2"
BORDERCOLOR="#504945"

BW=4
LINEMARGIN=0
LINEPADDING=4
PADDING=0

rofi -modi drun -show drun -monitor -3 -show-icons -separator-style "none" \
-bw "$BW" \
-color-normal "$BG, $FG, $BG, $HLBG, $HLFG" \
-color-window "$BG, $BORDERCOLOR, $FG" \
-font "$FONT" \
-line-margin "$LINEMARGIN" \
-line-padding "$LINEPADDING" \
-lines "$LINES" \
-padding "$PADDING" \
-width "$WIDTH" \
