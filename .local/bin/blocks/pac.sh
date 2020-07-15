#!/bin/sh

# TODO: Is there a simple way to update output in between running commands?

refresh() {
	notify-send -h string:x-canonical-private-synchronous:updatecheck "Checking for updates"
	sudo -A pacman -Sy > /dev/null
	notify-send -t 1 -h string:x-canonical-private-synchronous:updatecheck " "
}

# TODO: This is probably a bad practice. Find a better solution
liveupdate() {
	refresh
	PACKAGES=$(pacman -Qu | sed '/\[ignored\]/d;/^linux/d;/^nvidia/d;/^btrfs-progs/d;/.*-dkms/d;/\n/d;s/\ .*//')
	[ -n "$PACKAGES" ] && setsid "$TERMINAL" -e sudo pacman -S --noconfirm $PACKAGES
}

case $BLOCK_BUTTON in
	1) refresh ;;
	2) setsid "$TERMINAL" -e sudo pacman -Syu ;;
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

