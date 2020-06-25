#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send "Calendar" "$(cal --color=always | sed 's/\x1b\[7m/<b>/;s/\x1b\[27m/<\/b>/')" ;;
	3) notify-send "Calendar" "$(cal -3 --color=always | sed 's/\x1b\[7m/<b>/;s/\x1b\[27m/<\/b>/')" ;;
esac

date '+%-e.%-m.%Y %H.%M'
#date '+%F %R'

