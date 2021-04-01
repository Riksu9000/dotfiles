#!/bin/sh

close() {
	xsetroot -name ""
	exit
}

trap close TERM INT
trap : USR1 # Use this to refresh

while :
do
	STR=
	STR="$STR$(~/.local/bin/blocks/vol.sh Speaker)"
	STR="$STR | 🎧$(~/.local/bin/blocks/vol.sh Headphone)"
	STR="$STR | $(~/.local/bin/blocks/bat.sh)"
	STR="$STR | $(date '+%a %-d %b')"
	xsetroot -name "$STR"
	sleep 30 &
	wait $!
done
