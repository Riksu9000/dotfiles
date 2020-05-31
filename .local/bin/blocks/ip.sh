#!/bin/sh

# NOTICE: tr makes use of the ip command leaving a whitespace at the end of each
# line when using -4 argument!
ip -brief -4 addr | sed '/UP/!d;s/ *UP */:/' | tr -d '\n'

