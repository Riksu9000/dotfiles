#!/bin/sh

printf "%s%s" "BL " "$(cat /sys/class/backlight/*/brightness)"
