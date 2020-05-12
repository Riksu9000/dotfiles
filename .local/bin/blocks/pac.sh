#!/bin/sh

refresh() {
	sudo pacman -Sy > /dev/null
	pkill -RTMIN+4 dwmblocks
}

download() {
	[ -n "$UPDATABLE" ] && setsid "$TERMINAL" -e sudo pacman -Suw
	pkill -RTMIN+4 dwmblocks
}

liveupdate() {
	PACKAGES=$(printf "%s" "$UPDATABLE" | sed '/linux/d;/nvidia/d;/\n/d')
	[ -n "$PACKAGES" ] && setsid "$TERMINAL" -e sudo pacman -S --noconfirm $PACKAGES
	pkill -RTMIN+4 dwmblocks
}

UPDATABLE=$(pacman -Qu | sed '/\[ignored\]/d;s/ .*//')
if [ -n "$UPDATABLE" ]
then
	LIVECOUNT=$(echo "$UPDATABLE" | sed '/\[ignored\]/d;/linux/d;/nvidia/d;/\n/d' | wc -l)
	FULLCOUNT=$(echo "$UPDATABLE" | wc -l)
fi

case $BLOCK_BUTTON in
	1) printf "%s" "♻"
	   refresh & ;;
	#1) printf "%s" "♻" && sudo -A pacman -Sy > /dev/null && pkill -RTMIN+4 dwmblocks & ;;
	2) setsid "$TERMINAL" -e sudo pacman -Syu ;;
	3) liveupdate ;;
esac

if [ -n "$FULLCOUNT" ] && [ "$FULLCOUNT" -gt 0 ]
then
	printf "%s" "📦$LIVECOUNT"
	[ "$FULLCOUNT" -gt "$LIVECOUNT" ] && printf "%s" "/$FULLCOUNT Restart required"
else
	echo
fi

