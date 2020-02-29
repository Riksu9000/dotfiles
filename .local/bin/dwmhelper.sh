#!/bin/sh

case $1 in
	volup)
		pactl set-sink-volume @DEFAULT_SINK@ +5%
		#amixer sset Master 5%+
		;;
	voldown)
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		#amixer sset Master 5%-
		;;
	volmute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		#amixer sset Master toggle
		;;
	blup)
		light -A 4
		;;
	bldown)
		light -U 4
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

