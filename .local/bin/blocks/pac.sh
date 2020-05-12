#!/bin/sh

SIGNAL=10

# TODO: Is there a simple way to update output in between running commands?

refresh() {
	sudo -A pacman -Sy > /dev/null
}

liveupdate() {
	refresh
	PACKAGES=$(pacman -Qu | sed '/\[ignored\]/d;/linux/d;/nvidia/d;/\n/d;s/ .*//')
	[ -n "$PACKAGES" ] && setsid "$TERMINAL" -e sudo pacman -S --noconfirm $PACKAGES
}

case $BLOCK_BUTTON in
	1) refresh ;;
	2) setsid "$TERMINAL" -e sudo pacman -Syu ;;
	3) liveupdate ;;
esac

UPDATABLE=$(pacman -Qu | sed '/\[ignored\]/d;s/ .*//')
if [ -n "$UPDATABLE" ]
then
	LIVECOUNT=$(echo "$UPDATABLE" | sed '/\[ignored\]/d;/linux/d;/nvidia/d;/\n/d' | wc -l)
	FULLCOUNT=$(echo "$UPDATABLE" | wc -l)
fi

if [ -n "$FULLCOUNT" ] && [ "$FULLCOUNT" -gt 0 ]
then
	printf "%s" "📦$LIVECOUNT"
	[ "$FULLCOUNT" -gt "$LIVECOUNT" ] && printf "%s" "/$FULLCOUNT Restart required"
else
	echo
fi

