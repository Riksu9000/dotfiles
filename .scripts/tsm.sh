#!/bin/sh

# Touch-screen-menu

FONT="xos4 Terminus 22"
#BG="#282828"; FG="#928374"; HLFG="#ebdbb2"; HLBG="#d65d0e"
#BG="#000000"; FG="#bbbbbb"; HLBG="#005577"; HLFG="#eeeeee"
BG="#ffffff"; FG="#000000"; HLBG="#5c5cff"; HLFG="#000000"

rofi -font "$FONT" \
	-color-normal $BG,$FG,$BG,$HLBG,$HLFG \
	-color-window $BG,$HLBG \
	-show drun \
	-lines 30 \
	-bw 4 \
	-width 30 \
	-location 3 \
	-yoffset 20 \
	-show-icons &
