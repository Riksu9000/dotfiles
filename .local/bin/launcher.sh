#!/bin/sh

WIDTH=500
LINES=15

#rofi -modi drun -show drun -show-icons -lines "$LINES" -monitor -5 -width "$WIDTH"
dmenu_run -m "$1" -l "$LINES"
