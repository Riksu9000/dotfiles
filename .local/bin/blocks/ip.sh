#!/bin/sh

ip -brief a | grep UP | awk '{print $1 ":" $3}' | tr '\n' ' '

