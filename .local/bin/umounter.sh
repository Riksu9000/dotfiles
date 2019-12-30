#!/bin/sh

FONT="xos4 Terminus:pixelsize=18"
BLACK=#282828; GRAY=#928374; WHITE=#ebdbb2; SEL=#d65d0e

error() {
	EXIT=$?
	case $1 in
		"mount")
			notify-send "There was an error unmounting drive $LABEL"
			exit $EXIT
			;;
		"rem")
			notify-send "Couldn\'t remove the mounting directory. Remove $HOME/mounts/$LABEL manually."
			exit $EXIT
			;;
		*)
			notify-send "An unknown error occurred"
			exit $EXIT
			;;
	esac
}

# Look for all mountable drives
# TODO: Separate external and internal HDDs somehow?
DRIVES=$(lsblk -npro "NAME,RM,MOUNTPOINT" | sed '/ [0-9] \//!d' | awk '{print $1}')

[ -z "$DRIVES" ] && notify-send "No drives to unmount" && exit

# Show a menu of unmountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	dmenu -i -l 5 -fn "$FONT" -nb "$BLACK" -nf "$GRAY" -sb "$SEL" -sf "$WHITE" -p "Umount which drive?" | \
	awk '{print $1}')

[ -z "$CHOSEN" ] && exit

# Get the label for the partition
LABEL=$(lsblk "$CHOSEN" -npro "LABEL")

# If there is no label, get UUID
[ -z "$LABEL" ] && LABEL=$(lsblk "$CHOSEN" -npro "UUID")

# TODO: If sync takes more than 2 seconds, notify the user
sync

sudo -A umount "$CHOSEN" || error mount

# Remove the mounting directory
rm -r "$HOME/mounts/$LABEL" || error rem

notify-send "Successfully unmounted $LABEL" && exit 0

