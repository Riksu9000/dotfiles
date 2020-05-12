#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +5% ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -5% ;;
esac

# Requires pulseaudio-alsa
VOL=$(amixer sget Master | awk '/Front Left:/ {print $5 $6}' | sed -e 's/.*off.*/muted/; s/\]\[on\]//; s/^\[//; s/%//; s/%//')

if [ "$VOL" = "muted" ]
then
	echo "🔇 mute"
elif [ "$VOL" -lt 25 ]
then
	printf "%s" "🔈 $VOL%"
elif [ "$VOL" -lt 75 ]
then
	printf "%s" "🔉 $VOL%"
else
	printf "%s" "🔊 $VOL%"
fi

