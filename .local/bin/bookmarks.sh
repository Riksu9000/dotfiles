#!/bin/sh
# Bookmark file format:
# First word is an abbreviation of the site
# Second word/column is the url
# yt https://www.youtube.com

BOOKMARKSFILE="$HOME/.local/share/bookmarks"

URL=$(dmenu -p Bookmarks -l 15 < "$BOOKMARKSFILE" | cut -d " " -f 2)
[ -n "$URL" ] && $BROWSER "$URL"
