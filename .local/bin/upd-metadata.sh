#!/bin/sh

# Update metadata of music files
# Your files must be arranged like:
# [Artistname]/[Album]/[Tracknumber].[Tracktitle]
# or
# [Artistname]/[Album]/[Tracktitle]

ALBUM=$(basename "$(pwd)")
ARTIST=$(basename "$(dirname "$(pwd)")")

for file
do
	NUMBER=$(echo "$file" | grep -o '^[0-9]*')
	TITLE=$(echo "${file%.*}" | sed 's/^[0-9]*\.//')
	[ -n "$ALBUM"  ] && id3v2 -A "$ALBUM"  "$file"
	[ -n "$ARTIST" ] && id3v2 -a "$ARTIST" "$file"
	[ -n "$NUMBER" ] && id3v2 -T "$NUMBER" "$file"
	[ -n "$TITLE"  ] && id3v2 -t "$TITLE"  "$file"
done

