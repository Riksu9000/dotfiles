#!/bin/sh

err() {
	EXIT=$?
	notify-send "$1"
	exit $EXIT
}

# Look for all mountable drives
# TODO: Separate external and internal HDDs somehow?
DRIVES=$(lsblk -npro "NAME,MOUNTPOINT" | sed '/ \//!d;/\/boot$/d;/\/home$/d;/\/$/d;s/ .*$//')

[ -z "$DRIVES" ] && notify-send "No drives to unmount" && exit

DRIVECOUNT=$(echo "$DRIVES" | wc -l)

# Show a menu of unmountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	dmenu -p "Umount which drive?" -l "$DRIVECOUNT" | \
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
sleep 1 && [ -d "/proc/$PID" ] && notify-send -u critical "Sync in progress. Do not remove drive" -h string:x-canonical-private-synchronous:umount &
wait "$PID"

doas umount "$CHOSEN" || err "There was an error unmounting drive $LABEL"

notify-send "Successfully unmounted $LABEL" "$CHOSEN" -h string:x-canonical-private-synchronous:umount

# Remove the mounting directory
[ -d "$HOME/mounts/$LABEL" ] && ( rm -r "$HOME/mounts/$LABEL" || err "Couldn\'t remove the mounting directory. Remove $HOME/mounts/$LABEL manually." )

