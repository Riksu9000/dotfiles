#!/bin/sh

case $1 in
	up)
		amixer sset Master 5%+
		;;
	down)
		amixer sset Master 5%-
		;;
esac

pkill -SIGPIPE dwmstatus.sh

#VOLUME=$(amixer sget Master | awk '/Front Left:/ {print substr($5,2)}' | sed 's/%.*//')
#notify-send -t 500 "$VOLUME%"

