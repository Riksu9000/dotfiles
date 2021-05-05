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

	#SONG=$(mpc current)
	#[ -n "$SONG" ] && STR="$STR | $SONG"

	STR="$STR | $(~/.local/bin/blocks/vol.sh)"
	#STR="$STR | $(~/.local/bin/blocks/bat.sh)"
	STR="$STR | $(LANG=fi_FI.UTF-8 date '+%a %-d %b')"

	#xsetroot -name "$STR"
	echo "$STR"

	sleep 30 &
	wait $!
done
