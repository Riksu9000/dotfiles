#!/bin/sh

cd "$(dirname "$0")" || exit 1

for file in * .*
do
	[ "$file" = "." ] && continue
	[ "$file" = ".." ] && continue
	[ "$file" = ".git" ] && continue
	[ "$file" = "README.md" ] && continue
	[ "$file" = "$(basename "$0")" ] && continue
	cp -rv "$file" "$HOME/"
done
