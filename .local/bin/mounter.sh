#!/bin/sh

err() {
	notify-send "There was an error mounting drive $LABEL"
	[ -d "$HOME/mounts/$LABEL" ] && rm -r "$HOME/mounts/$LABEL"
	exit
}

# Look for all mountable drives
DRIVES=$(lsblk -npro "NAME,TYPE,PTTYPE,MOUNTPOINT" | sed '/ \//d;/disk [a-z]/d;s/ .*//')

[ -z "$DRIVES" ] && notify-send "No mountable drives detected" && exit 0

DRIVECOUNT=$(echo "$DRIVES" | wc -l)

# Show a menu of mountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	rofi -dmenu -p "Mount which drive?" -lines "$DRIVECOUNT" | \
	#dmenu -p "Mount which drive?" -l "$DRIVECOUNT" | \
	cut -d ' ' -f 1)

[ -z "$CHOSEN" ] && exit 0

# Get the label for the partition
LABEL=$(lsblk "$CHOSEN" -no "LABEL")

# Get the partition type
TYPE=$(lsblk "$CHOSEN" -no "FSTYPE")

# If there is no label, get UUID
[ -z "$LABEL" ] && LABEL=$(lsblk "$CHOSEN" -no "UUID")

# Make a directory for mounting the drive
mkdir -p "$HOME/mounts/$LABEL"

if [ "$TYPE" = "vfat" ]
then
	sudo -A mount -o uid="$(id -u)" -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
else
	sudo -A mount -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
fi

notify-send "Successfully mounted $LABEL" "$CHOSEN"
