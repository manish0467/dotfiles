#!/bin/sh

FILE="$1"

ffmpeg -i "$FILE" -vf "fps=2,scale=160:-1" -loop 0 -loglevel quiet -f gif - \
  | chafa -f sixel -s "${YAZI_WIDTH}x${YAZI_HEIGHT}"
