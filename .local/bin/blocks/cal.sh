#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send "$(cal -w)" ;;
	3) notify-send "$(cal -w3)" ;;
esac

date '+%a %e.%b %H:%M'

