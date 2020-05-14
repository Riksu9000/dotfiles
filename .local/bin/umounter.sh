#!/bin/sh

FONT="xos4 Terminus:pixelsize=18"
BG="#282828"; FG="#a89984"; SBG="#d65d0e"; SFG="#ebdbb2"

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
	dmenu -i -l 5 -fn "$FONT" -nb "$BG" -nf "$FG" -sb "$SBG" -sf "$SFG" -p "Umount which drive?" | \
	awk '{print $1}')

[ -z "$CHOSEN" ] && exit

# Get the label for the partition
LABEL=$(lsblk "$CHOSEN" -npro "LABEL")

# If there is no label, get UUID
[ -z "$LABEL" ] && LABEL=$(lsblk "$CHOSEN" -npro "UUID")

# This seems to work but is it correct?
sync &
PID=$!
# Check if sync is still running after a second has passed
sleep 1
[ -d "/proc/$PID" ] && notify-send -u critical "Sync in progress. Do not remove drive"
wait "$PID"

sudo -A umount "$CHOSEN" || error mount

notify-send "Successfully unmounted $LABEL"

# Remove the mounting directory
rm -r "$HOME/mounts/$LABEL" || error rem

