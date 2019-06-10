#!/bin/sh

case $1 in
	volup)
		amixer sset Master 5%+
		;;
	voldown)
		amixer sset Master 5%-
		;;
	blup)
		light -A 10
		;;
	bldown)
		light -U 10
		;;
	playnext)
		playerctl next
		;;
	playprev)
		playerctl prev
		;;
	playpause)
		playerctl play-pause
		;;
esac

# Refresh statusbar
pkill -SIGPIPE dwmstatus.sh

