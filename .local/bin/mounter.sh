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
#CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE" | \
CHOSEN=$(lsblk $DRIVES -npro "NAME,LABEL,SIZE,TYPE" | \
	sed '/crypt$/d' | \
	dmenu -p "Mount which drive?" -l "$DRIVECOUNT" | \
	cut -d ' ' -f 1)

[ -z "$CHOSEN" ] && exit 0

# Get the label for the partition
LABEL=$(lsblk "$CHOSEN" -no "LABEL")
[ -z "$LABEL" ] && LABEL=$(lsblk "$CHOSEN" -no "UUID")
[ -z "$LABEL" ] && LABEL=$(shuf -i 1-100000 -n 1)

# Make a directory for mounting the drive
mkdir -p "$HOME/mounts/$LABEL" || err

TYPE=$(lsblk "$CHOSEN" -no "FSTYPE")
if [ "$TYPE" = vfat ] || [ "$TYPE" = ntfs ] || [ "$TYPE" = exfat ]
then
	doas mount -o uid="$(id -u)" -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
elif [ "$TYPE" = crypto_LUKS ]
then
	askpass "Password:" | su -c "askpass \"Enter passphrase for $CHOSEN:\" | cryptsetup open $CHOSEN $LABEL" || err
	doas mount -w "/dev/mapper/$LABEL" "$HOME/mounts/$LABEL" || err
else
	doas mount -w "$CHOSEN" "$HOME/mounts/$LABEL" || err
fi

notify-send "Successfully mounted $LABEL" "$CHOSEN"
