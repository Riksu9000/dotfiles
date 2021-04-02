#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +3db ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -3db ;;
esac

OUTPUT=${@:-Master}

# set soundcard value below
VOL=$(amixer -c 0 get "$OUTPUT" 2> /dev/null | grep -m 1 -o '\[[0-9]*%\]' | tr -dc '[:digit:]')

# For Samsung Chromebook 2 on Arch Linux ARM
STATE=$(amixer -c 0 get "$@ Left" | grep -o '\[[a-z]*\]' | tr -dc '[:alpha:]')

if [ -z "$VOL" ] || [ "$STATE" = "off" ]
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

