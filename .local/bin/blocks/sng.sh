#!/bin/sh

case $BLOCK_BUTTON in
	1) playerctl play-pause ;;
	3) playerctl next ;;
	4) playerctl volume 0.05+ ;;
	5) playerctl volume 0.05- ;;
esac

[ -z $(command -v playerctl) ] && echo "🎵Install playerctl" && exit 1

case "$(playerctl status 2> /dev/null)" in
	"Paused")  printf "%s" "⏸ " && playerctl metadata -f '{{title}}' ;;
	"Playing") printf "%s" "▶ " && playerctl metadata -f '{{title}}' ;;
	*) echo ;;
esac

