#!/bin/sh

DISPLAY_THRESHOLD=50

MEM=$(($(free | awk 'NR == 2 {print $3" * 100 / "$2}')))

[ "$MEM" -gt "$DISPLAY_THRESHOLD" ] && printf "mem: %s%%" "$MEM"
