#!/bin/sh

SIGNAL=4

case $BLOCK_BUTTON in
	1)
		printf "♻"
		sh -c "newsboat -x reload; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null &
		exit
		;;
	3) "$TERMINAL" -e sh -c "newsboat; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null & ;;
esac

UNREAD=$(newsboat -x print-unread | cut -d ' ' -f 1)

[ "$UNREAD" -gt 0 ] && printf "%s" "📰 $UNREAD"
