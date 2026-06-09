#!/usr/bin/env bash
WALLDIR="$HOME/.config/omarchy/current/theme/backgrounds"
[ ! -d "$WALLDIR" ] && exit 1

selected=$(
  find "$WALLDIR" -maxdepth 1 -type f \
  | sed "s|$WALLDIR/||" \
  | fzf \
      --prompt="Wallpaper > " \
      --height=80% \
      --layout=reverse \
      --preview="chafa \"$WALLDIR\"/{} --size=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES} --stretch" \
      --preview-window=right:60%:wrap
)

[ -z "$selected" ] && exit 0

swww img "$WALLDIR/$selected" \
  --transition-type grow \
  --transition-duration 0.7
