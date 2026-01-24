#!/bin/sh

# Try to get URL from clipboard
if command -v wl-paste >/dev/null 2>&1; then
    URL="$(wl-paste --no-newline 2>/dev/null)"
fi

# Validate URL
if echo "$URL" | grep -Eq '^https?://'; then
    mpv "$URL"
    exit 0
fi

echo "No valid URL found in clipboard."
exit 1
