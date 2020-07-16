#!/bin/sh

case $BLOCK_BUTTON in
	1) playerctl play-pause ;;
	3) playerctl next ;;
	4) playerctl volume 0.05+ ;;
	5) playerctl volume 0.05- ;;
esac

[ -z $(command -v playerctl) ] && echo "🎵Install playerctl" && exit 1

# Sleep because resuming playback might take longer than expected
sleep 0.01s

playerctl metadata -f '{{status}} {{title}}' | sed 's/Playing/▶/;s/Paused/⏸/;s/Stopped/⏹/'
