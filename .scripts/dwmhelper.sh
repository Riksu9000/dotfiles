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
	screenshot)
		FILENAME=$(scrot '%F_%H%M%S.png' -e 'echo $f')
		xclip -selection clipboard -t image/png -i $HOME/$FILENAME
		notify-send "Screenshot saved to file $FILENAME"
esac

# Refresh statusbar
pkill -SIGPIPE dwmstatus.sh

