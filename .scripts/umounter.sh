#!/bin/sh

FONT="xos4 Terminus:pixelsize=18"
BLACK="#282828"; GRAY="#928374"; WHITE="#ebdbb2"; SEL="#d65d0e"

systemd-umount $(lsblk -npro "NAME,LABEL,SIZE,TYPE,RM,MOUNTPOINT" | \
	sed '/part 1 \//!d; s/part 1//' | \
	dmenu -i -l 5 -fn "$FONT" -nb "$BLACK" -nf "$GRAY" -sb "$SEL" -sf "$WHITE" -p "Unmount which drive?" | \
	awk '{print $1}')
