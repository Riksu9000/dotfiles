#!/bin/sh

WIDTH=500
LINES=15

[ -n "$1" ] && MONITOR=$1 || MONITOR="-5"

rofi -modi drun -show drun -show-icons -lines "$LINES" -monitor "$MONITOR" -width "$WIDTH"
#dmenu_run -l "$LINES"
