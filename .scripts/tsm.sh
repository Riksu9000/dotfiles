#!/bin/sh

# Touch-screen-menu

FONT="xos4 Terminus 22"
BLACK="#000000"; GREY="#bbbbbb"; WHITE="#eeeeee"; SEL="#005577"


rofi -font "$FONT" \
	-color-normal $BLACK,$GREY,$BLACK,$SEL,$WHITE \
	-color-window $BLACK,$SEL \
	-show drun \
	-lines 30 \
	-bw 4 \
	-width 30 \
	-location 3 \
	-yoffset 20 \
	-show-icons &
