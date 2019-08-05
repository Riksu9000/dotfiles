#!/bin/sh

FONT="xos4 Terminus:pixelsize=18"
BLACK=#282828; GRAY=#928374; WHITE=#ebdbb2; SEL=#d65d0e

# Look for all mountable drives
DRIVES=$(lsblk -npro "NAME,RM,MOUNTPOINT" | sed '/ 1 \//!d' | awk '{print $1}')

[ -z $DRIVES ] && notify-send "No drives to unmount" && exit

# Show a menu of unmountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	dmenu -i -l 5 -fn "$FONT" -nb $BLACK -nf $GRAY -sb $SEL -sf $WHITE -p "Umount which drive?" | \
	awk '{print $1}')

# Get the label for the partition
LABEL=$(lsblk $CHOSEN -npro "LABEL")

# If there is no label, get UUID
[ -z $LABEL ] && LABEL=$(lsblk $CHOSEN -npro "UUID")

sudo -A umount $CHOSEN || error mount

# Remove the mounting directory
rm -r $HOME/mounts/$LABEL || error rem

notify-send "Successfully unmounted $LABEL" && exit 0

error() {
	case $1 in
		"mount")
			notify-send "There was an error unmounting drive $LABEL"
			exit 1
			;;
		"rem")
			notify-send "Couldn\'t remove the mounting directory. Remove $HOME/mounts/$LABEL manually."
			exit 1
			;;
		*)
			notify-send "An unknown error occurred"
			exit 1
			;;
	esac
}
