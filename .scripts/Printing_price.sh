#!/bin/sh

# Constants
filament_price=24.9	# Filament price in euros/kg
filament_density=1.241	# PLA Density in g/cm³
base_cost=5	# Minimum cost of print
alv=1.24	# ALV price multiplier

# Script start
calc() { awk "BEGIN{print $*}"; }	# Floating point calculator

info=$(slic3r-prusa3d --no-gui --info "$1" | grep size)	# Strip size of object from file

# Separate sizes to variables
size_x=$(echo "$info" | awk '/size_x/ {print $3}' | sed 's/\..*//')
size_y=$(echo "$info" | awk '/size_y/ {print $3}' | sed 's/\..*//')
size_z=$(echo "$info" | awk '/size_z/ {print $3}' | sed 's/\..*//')

# Required amount of filament in cm3
filament=$(slic3r-prusa3d --no-gui --load ~/.Slic3rPE/filament/My\ PLA.ini \
--load ~/.Slic3rPE/print/Anet\ A8.ini \
--load ~/.Slic3rPE/printer/Anet\ A8.ini \
--output ~/.temp.gcode \
"$1" | awk '/Filament required:/ {print substr($4,2)}' | sed 's/cm3)//')

volume=$(calc $size_x*$size_y*$size_z | sed 's/\..*//')	# mm³

echo "Dimensions: "$size_x"mm * "$size_y"mm * "$size_z"mm"

if [ $volume -lt 2000 ]; then
	echo "Print is too small!"
	exit
fi

print_weight=$(calc $filament_density*$filament)

material_price=$(calc $print_weight*$filament_price/1000)

final_price=$(calc $(calc $base_cost+$material_price)*$alv)

echo $final_price
