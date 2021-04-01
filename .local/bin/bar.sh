#!/bin/sh

close() {
	xsetroot -name ""
	exit
}

trap close int

while :
do
	STR=
	STR+=$(~/.local/bin/blocks/vol.sh)
	STR+=" | $(~/.local/bin/blocks/bat.sh)"
	STR+=" | $(date '+%a %-d %b')"
	xsetroot -name "$STR"
	sleep 30
done
