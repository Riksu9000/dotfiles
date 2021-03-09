#!/bin/sh

case $BLOCK_BUTTON in
	1) mprisctl play-pause ;;
	3) mprisctl next ;;
esac

# playerctl -V option from manual is unknown and returns 0..
[ -z "$(playerctl --version)" ] && echo "🎵Install playerctl" && exit 1

# Sleep because resuming playback might take longer than expected
sleep 0.01s

playerctl metadata -f '{{status}} {{title}}' 2> /dev/null | sed 's/Playing/▶/;s/Paused/⏸/;s/Stopped/⏹/'
