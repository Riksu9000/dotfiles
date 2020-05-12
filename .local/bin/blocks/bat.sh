#!/bin/sh

printf "%s%s%s" "🔋""$(cat /sys/class/power_supply/BAT0/capacity)" "%"

