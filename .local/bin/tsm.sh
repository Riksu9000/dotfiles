#!/bin/sh

# Touch-screen-menu

FONT="xos4 Terminus 22"
BG="#282828"; FG="#928374"; HLFG="#ebdbb2"; HLBG="#d65d0e"
#BG="#000000"; FG="#bbbbbb"; HLBG="#005577"; HLFG="#eeeeee"
#BG="#ccffffff"; FG="#000000"; HLBG="#5c5cff"; HLFG="#000000"

rofi -font "$FONT" \
	-color-normal 0,$FG,0,$HLBG,$HLFG \
	-color-window $BG,$HLBG \
	-separator-style none \
	-scrollbar-width 30 \
	-location 3 \
	-padding 20 \
	-yoffset 20 \
	-show-icons \
	-show drun \
	-lines 30 \
	-width 30 \
	-bw 4

