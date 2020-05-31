#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac

# Requires pulseaudio-alsa
VOL=$(amixer sget Master | sed '/Front Left:/!d;s/.*off.*/muted/;s/\]\ \[on\]//;s/^.*\[//')

if [ "$VOL" = "muted" ]
then
	echo "🔇 mute"
elif [ "$VOL" -lt 25 ]
then
	printf "%s" "🔈 $VOL"
elif [ "$VOL" -lt 75 ]
then
	printf "%s" "🔉 $VOL"
else
	printf "%s" "🔊 $VOL"
fi

