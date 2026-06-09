#!/usr/bin/env bash
# One-time / occasional setup: theme folders under ~/Wallpapers + Omarchy symlinks.

set -euo pipefail

source "${BASH_SOURCE%/*}/wallpaper-lib.sh"

mkdir -p "$LIBRARY_ROOT" "$SHARED_DIR" "$OMARCHY_CONFIG/backgrounds"

# Folders for every custom theme you have installed
if [[ -d "$OMARCHY_CONFIG/themes" ]]; then
    for theme_path in "$OMARCHY_CONFIG/themes"/*; do
        [[ -d "$theme_path" ]] || continue
        theme=$(basename "$theme_path")
        mkdir -p "$LIBRARY_ROOT/$theme"
        sync_omarchy_background_symlink "$theme"
    done
fi

# Legacy stock background dirs (catppuccin, nord, …)
for theme_path in "$OMARCHY_CONFIG/backgrounds"/*; do
    [[ -e "$theme_path" ]] || continue
    theme=$(basename "$theme_path")
    [[ "$theme" == "_shared" ]] && continue
    mkdir -p "$LIBRARY_ROOT/$theme"
    sync_omarchy_background_symlink "$theme"
done

# Move loose images from library root → current theme folder
current=$(theme_name)
current_lib="$LIBRARY_ROOT/$current"
mkdir -p "$current_lib"

while IFS= read -r -d '' img; do
    mv -n -- "$img" "$current_lib/" 2>/dev/null || true
done < <(find "$LIBRARY_ROOT" -maxdepth 1 -type f "${WALLPAPER_NAME_EXPR[@]}" -print0 2>/dev/null)

sync_omarchy_background_symlink "$current"

echo "Wallpaper library ready under $LIBRARY_ROOT"
echo "  Current theme: $current → $current_lib"
echo "  Shared:        $SHARED_DIR"
echo "  Omarchy links: $OMARCHY_CONFIG/backgrounds/<theme> → ~/Wallpapers/<theme>"
