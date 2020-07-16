#!/bin/sh

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
DRIVES=$(lsblk -npro "NAME,RM,MOUNTPOINT" | sed '/ [0-9] \//!d;/\/boot$/d;/\/home$/d;/\/$/d;s/ .*$//')

[ -z "$DRIVES" ] && notify-send "No drives to unmount" && exit

DRIVECOUNT=$(echo "$DRIVES" | wc -l)

# Show a menu of unmountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	rofi -dmenu -p "Umount which drive?" -lines "$DRIVECOUNT" | \
	cut -d ' ' -f 1)

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
[ -d "/proc/$PID" ] && notify-send -u critical "Sync in progress. Do not remove drive" -h string:x-canonical-private-synchronous:umount
wait "$PID"

sudo -A umount "$CHOSEN" || error mount

notify-send "Successfully unmounted $LABEL" "$CHOSEN" -h string:x-canonical-private-synchronous:umount

# Remove the mounting directory
if [ -d "$HOME/mounts/$LABEL" ]
then
	rm -r "$HOME/mounts/$LABEL" || error rem
fi

