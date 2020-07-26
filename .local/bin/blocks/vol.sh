#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac

# Requires pulseaudio-alsa
VOL=$(amixer sget Master 2> /dev/null | sed '/Front Left:/!d;s/.*off.*/muted/;s/%\]\ \[on\]//;s/^.*\[//')
[ -z "$VOL" ] && printf "🔇" && exit 1

if [ "$VOL" = "muted" ]
then
	printf "🔇 mute"
elif [ "$VOL" -lt 25 ]
then
	printf "%s" "🔈 $VOL%"
elif [ "$VOL" -lt 75 ]
then
	printf "%s" "🔉 $VOL%"
else
	printf "%s" "🔊 $VOL%"
fi

