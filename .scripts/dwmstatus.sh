#!/bin/sh

# Update the status bar
update() {
	xsetroot -name "$(amixer sget Master | awk '/Front Left:/ {print substr($5,2)}' | sed 's/%.*//')%\
  $(date '+%a %e.%b %H:%M')"
}

# update the status bar when this script is signaled with SIGPIPE
trap update PIPE

# Loop to update the status bar every 30 seconds while also accepting signals
while true
do
	update
	sleep 30 &
	wait $!
done

