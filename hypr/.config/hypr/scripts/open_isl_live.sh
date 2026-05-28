#!/bin/bash

BASE_URL="https://www.fancode.com/football/tour/indian-super-league-2026-19377161/matches"

# Fetch page
PAGE=$(curl -sL "$BASE_URL")

# Extract live match link (more robust)
LIVE_LINK=$(echo "$PAGE" | grep -oP 'href="\K/football/tour/indian-super-league-[^"]*live-match-info' | head -n 1)

if [ -n "$LIVE_LINK" ]; then
    FULL_LINK="https://www.fancode.com$LIVE_LINK"
    notify-send "⚽ ISL" "Opening LIVE match"
    chromium --start-fullscreen "$FULL_LINK"
else
    notify-send "⚽ ISL" "No live match, opening schedule"
    chromium "$BASE_URL"
fi
