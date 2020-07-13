#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send "$(cal    | head -n 1)" "$(cal --color=always    | sed 's/\x1b\[7m/<b>/;s/\x1b\[27m/<\/b>/;1d;2s/^/<u>/;2s/$/<\/u>/')" ;;
	3) notify-send "$(cal -3 | head -n 1)" "$(cal --color=always -3 | sed 's/\x1b\[7m/<b>/;s/\x1b\[27m/<\/b>/;1d;2s/^/<u>/;2s/$/<\/u>/;2s/  /<\/u>  <u>/g')" ;;
esac

date '+%A %-e.%-m.%Y %R'

