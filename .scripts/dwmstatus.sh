#!/bin/sh

# Separator put in between modules
SEP="  "

# Update the status bar
update() {
	# Clear statusbar of old data
	BAR=""

	# Status bar is constructed by executing functions
	song
	vol
	clock

	# Write the string to the bar
	xsetroot -name "$BAR"
}

backlight() {
	BAR=$BAR$SEP$(cat /sys/class/backlight/*/actual_brightness)
}

bat() {
	BAR=$BAR$SEP$(cat /sys/class/power_supply/BAT0/capacity)
}

vol() {
	BAR=$BAR$SEP"VOL "$(amixer sget Master | awk '/Front Left:/ {print substr($5,2)}' | sed 's/%.*//')"%"
}

clock() {
	BAR=$BAR$SEP$(date '+%a %e.%b %H:%M')
}

song() {
	case "$(playerctl status)" in
		"Paused")
			ICON="⏸"
			;;
		"Playing")
			ICON="▶"
			;;
		*)
			ICON=""
			return
			;;
	esac
	BAR=$BAR$SEP$ICON" "$(playerctl metadata -f '{{title}}')
}

# update the status bar when this script is signaled with SIGPIPE
trap update PIPE

# Wait for dwm to start
sleep 1

while true
do
	update
	# Sleep and wait so bar can be updated with SIGPIPE even when sleeping
	sleep 30 &
	wait $!
done

