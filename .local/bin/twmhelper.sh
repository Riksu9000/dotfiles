#!/bin/sh

vol() {
	VOL=$(amixer sget Master | awk '/Front Left:/ {print $5 $6}' | sed -e 's/\]\[off\]/ \[muted\]/; s/\]\[on\]//; s/^\[//')
	notify-send -t 1000 "Volume: $VOL" -h string:x-canonical-private-synchronous:volumechange
}

case $1 in
	volup)
		pactl set-sink-volume @DEFAULT_SINK@ +5%
		#amixer sset Master 5%+
		vol
		;;
	voldown)
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		#amixer sset Master 5%-
		vol
		;;
	volmute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		#amixer sset Master toggle
		vol
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
		xclip -selection clipboard -t image/png -i "$HOME/$FILENAME"
		notify-send "Screenshot saved to file $FILENAME"
esac

