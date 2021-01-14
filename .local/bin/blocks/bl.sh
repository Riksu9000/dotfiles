#!/bin/sh

for bl in /sys/class/backlight/*
do
	BRIGHTNESS=$(cat "$bl/brightness" 2> /dev/null) || break
	MAX=$(cat "$bl/max_brightness")

	PERC=$((BRIGHTNESS * 100 / MAX))

	printf "BL %s%%" "$PERC"
done
