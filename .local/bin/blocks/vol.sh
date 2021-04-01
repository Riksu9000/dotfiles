#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +3db ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -3db ;;
esac

# set soundcard value below
VOL=$(amixer -c 1 get Master 2> /dev/null | grep -m 1 -o '\[[0-9]*%\]' | tr -dc '[:digit:]')

# Return "on" or "ff"
#STATE=$(amixer cget name='Speaker Left Switch' 0 | grep '  : values=' | tail -c 3)

if [ -z "$VOL" ] || [ "$STATE" = "ff" ]
then
	printf "🔇"
elif [ "$VOL" = "muted" ]
then
	printf "🔇 mute"
elif [ "$VOL" -lt 25 ]
then
	printf "🔈 %s%%" "$VOL"
elif [ "$VOL" -lt 75 ]
then
	printf "🔉 %s%%" "$VOL"
else
	printf "🔊 %s%%" "$VOL"
fi

