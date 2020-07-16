#!/bin/sh

SIGNAL=20

refresh() {
	printf "♻"
	sh -c "sudo -A pacman -Sy; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null &
	exit
}

# TODO: This is probably a bad practice. Find a better solution
liveupdate() {
	"$TERMINAL" -e sh -c "sudo pacman -Sy
	PACKAGES=\$(pacman -Qu | sed '/\[ignored\]/d;/^linux/d;/^nvidia/d;/^btrfs-progs/d;/.*-dkms/d;/\n/d;s/\ .*//')
	[ -n \"\$PACKAGES\" ] && sudo pacman -Su \$PACKAGES
	pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null &
}

case $BLOCK_BUTTON in
	1) refresh ;;
	2) "$TERMINAL" -e sh -c "sudo pacman -Syu; pkill -RTMIN+$SIGNAL dwmblocks" > /dev/null & ;;
	3) liveupdate ;;
esac

UPDATABLE=$(pacman -Qu | grep -v '\[ignored\]')
if [ -n "$UPDATABLE" ]
then
	LIVECOUNT=$(echo "$UPDATABLE" | grep -vc 'linux\|nvidia\|btrfs-progs\|-dkms')
	FULLCOUNT=$(echo "$UPDATABLE" | wc -l)
	printf "%s" "📦$FULLCOUNT"
	[ "$FULLCOUNT" -gt "$LIVECOUNT" ] && printf "%s" " Restart required"
fi

