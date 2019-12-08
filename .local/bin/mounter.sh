#!/bin/bash

FONT="xos4 Terminus:pixelsize=18"
BLACK=#282828; GRAY=#928374; WHITE=#ebdbb2; SEL=#d65d0e


err() {
	notify-send "There was an error mounting drive $LABEL"
	[ -d "$HOME/mounts/$LABEL" ] && rm -r "$HOME/mounts/$LABEL"
	exit
}

# Look for all mountable drives
DRIVES=$(lsblk -npro "NAME,TYPE,PTTYPE,RM,MOUNTPOINT" | sed '/ [0-9] $/!d; /disk [a-z]/d' | awk '{print $1}')

[ -z "$DRIVES" ] && notify-send "No mountable drives detected" && exit 0

# Show a menu of mountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk "$DRIVES" -npro "NAME,LABEL,SIZE" | \
	dmenu -i -l 5 -fn "$FONT" -nb "$BLACK" -nf "$GRAY" -sb "$SEL" -sf "$WHITE" -p "Mount which drive?" | \
	awk '{print $1}')

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
	# In POSIX sh, UID is undefined
	sudo -A mount -o uid="$UID" -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
else
	sudo -A mount -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
	sudo -A chown "$USER" "$HOME/mounts/$LABEL"
fi

notify-send "Successfully mounted $LABEL"
