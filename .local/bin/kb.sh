#!/bin/sh

SPEED=${1:-30}

# Clear previous options
setxkbmap -option

setxkbmap -layout us,fi
#setxkbmap -option grp:alt_caps_toggle
#setxkbmap -option caps:swapescape
setxkbmap -option grp:shifts_toggle
#xmodmap -e 'keycode 124 = F11'
xset r rate 200 "$SPEED"
