#!/bin/sh

for battery in /sys/class/power_supply/BAT*
do
	CAPACITY=$(cat "$battery/capacity" 2> /dev/null) || break
	STATUS=$(cat "$battery/status")
	case $STATUS in
		Charging) ICON=🔌 ;;
		*) ICON=🔋 ;;
	esac
	printf "%s" "$ICON$CAPACITY%"
done
