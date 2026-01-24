#!/bin/sh
# MPV playlist from selected files
mpv --playlist=<(printf "%s\n" "$@")
