#!/bin/sh

case $BLOCK_BUTTON in
	1) pactl set-sink-mute   @DEFAULT_SINK@ toggle ;;
	4) pactl set-sink-volume @DEFAULT_SINK@ +3db ;;
	5) pactl set-sink-volume @DEFAULT_SINK@ -3db ;;
esac

# set soundcard value below
VOL=$(amixer -c 1 get Master 2> /dev/null | sed '/%/!d;s/.*off.*/muted/;s/%\].*$//;s/^.*\[//')
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

