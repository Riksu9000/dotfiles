#!/bin/sh

for battery in /sys/class/power_supply/*
do
	CAPACITY=$(cat "$battery/capacity" 2> /dev/null) || break
	STATUS=$(cat "$battery/status") || break

	case $STATUS in
		Charging) printf "🔌" ;;
	esac

	case $((CAPACITY * 8 / 100)) in
		0) FILL=" " ;;
		1) FILL="▁" ;;
		2) FILL="▂" ;;
		3) FILL="▃" ;;
		4) FILL="▄" ;;
		5) FILL="▅" ;;
		6) FILL="▆" ;;
		7) FILL="▇" ;;
		8) FILL="█" ;;
	esac

	printf "⎥%s⎢%s%%" "$FILL" "$CAPACITY"
done
