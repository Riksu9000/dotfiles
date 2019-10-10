#!/bin/sh

FONT="xos4 Terminus:pixelsize=18"
BLACK=#282828; GRAY=#928374; WHITE=#ebdbb2; SEL=#d65d0e

# Look for all mountable drives
DRIVES=$(lsblk -npro "NAME,TYPE,PTTYPE,RM,MOUNTPOINT" | sed '/ 1 $/!d; /disk [a-z]/d' | awk '{print $1}')

[ -z $DRIVES ] && notify-send "No mountable drives detected" && exit 0

# Show a menu of mountable drives and put the full path to the variable $CHOSEN
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
	dmenu -i -l 5 -fn "$FONT" -nb $BLACK -nf $GRAY -sb $SEL -sf $WHITE -p "Mount which drive?" | \
	awk '{print $1}')

[ -z $CHOSEN ] && exit 0

# Get the label for the partition
LABEL=$(lsblk $CHOSEN -npro "LABEL")

# If there is no label, get UUID
[ -z $LABEL ] && LABEL=$(lsblk $CHOSEN -npro "UUID")

# Make a directory for mounting the drive
mkdir -p $HOME/mounts/$LABEL

sudo -A mount -w $CHOSEN $HOME/mounts/$LABEL && notify-send "Successfully mounted $LABEL" || notify-send "There was an error mounting drive $LABEL"
sudo -A chown "$USER" $HOME/mounts/$LABEL
