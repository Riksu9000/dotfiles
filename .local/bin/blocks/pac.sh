#!/bin/sh

SIGNAL=20

refresh() {
	printf "♻"
	sh -c "doas pacman -Sy; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null &
	exit
}

case $BLOCK_BUTTON in
	1) refresh ;;
	3) "$TERMINAL" -e sh -c "doas pacman -Syu; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null & ;;
esac

UPDATABLE=$(pacman -Qu | grep -v '\[ignored\]')
if [ -n "$UPDATABLE" ]
then
	LIVECOUNT=$(echo "$UPDATABLE" | grep -vc 'linux\|nvidia\|btrfs-progs\|-dkms')
	FULLCOUNT=$(echo "$UPDATABLE" | wc -l)
	printf "%s" "📦$FULLCOUNT"
	[ "$FULLCOUNT" -gt "$LIVECOUNT" ] && printf "%s" " Restart required"
fi

