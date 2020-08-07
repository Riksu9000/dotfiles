#!/bin/sh

WIDTH=500
LINES=15

MONITOR=${1:-"-5"}

rofi -modi drun,run -show drun -show-icons -lines "$LINES" -monitor "$MONITOR" -width "$WIDTH"
#dmenu_run -l "$LINES"
