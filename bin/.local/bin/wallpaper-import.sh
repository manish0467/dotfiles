#!/usr/bin/env bash
# Copy new images into ~/Wallpapers/<current-theme>/ (and sync Omarchy symlink).
# Usage:
#   wallpaper-import.sh              → import from ~/Downloads
#   wallpaper-import.sh /some/folder → import from a folder
#   wallpaper-import.sh file.jpg     → import a single file

set -euo pipefail

# shellcheck source=wallpaper-lib.sh
source "${BASH_SOURCE%/*}/wallpaper-lib.sh"

THUMB_SIZE="128x80"
SOURCE="${1:-$HOME/Downloads}"

ensure_theme_library
LIBRARY=$(theme_library_dir)
THEME_NAME=$(theme_name)

generate_thumb() {
    local src="$1"
    local thumb
    thumb=$(thumb_for "$src")
    mkdir -p "$THUMB_DIR"
    convert "$src" -thumbnail "${THUMB_SIZE}^" \
        -gravity center -extent "$THUMB_SIZE" "$thumb" 2>/dev/null || true
}

import_file() {
    local src="$1"
    local name dest
    name=$(basename "$src")
    dest="$LIBRARY/$name"

    if [[ -f "$dest" ]]; then
        notify-send "Wallpaper Import" \
            "Already in <b>$THEME_NAME</b>, skipping: <b>$name</b>" -t 2000
        return 1
    fi

    cp -- "$src" "$dest"
    generate_thumb "$dest"
    echo "Imported: $name"
    return 0
}

if [[ -f "$SOURCE" ]]; then
    ext="${SOURCE##*.}"
    case "${ext,,}" in
        jpg|jpeg|png|webp)
            if import_file "$SOURCE"; then
                notify-send "Wallpaper Import" \
                    "Added <b>$(basename "$SOURCE")</b> → <b>~/Wallpapers/$THEME_NAME</b>" -t 2500
            fi
            ;;
        *)
            notify-send "Wallpaper Import" "Unsupported file type: $ext" -u critical
            exit 1
            ;;
    esac
    exit 0
fi

if [[ ! -d "$SOURCE" ]]; then
    notify-send "Wallpaper Import" "Folder not found: $SOURCE" -u critical
    exit 1
fi

IMPORTED=0
SKIPPED=0

while IFS= read -r -d '' img; do
    if import_file "$img"; then
        IMPORTED=$((IMPORTED + 1))
    else
        SKIPPED=$((SKIPPED + 1))
    fi
done < <(find "$SOURCE" -maxdepth 1 -type f "${WALLPAPER_NAME_EXPR[@]}" -print0)

TOTAL=$(find -L "$LIBRARY" -maxdepth 1 -type f "${WALLPAPER_NAME_EXPR[@]}" | wc -l)

notify-send "Wallpaper Import" \
    "Theme <b>$THEME_NAME</b>: added <b>$IMPORTED</b>, skipped <b>$SKIPPED</b>.<br><b>$TOTAL</b> in ~/Wallpapers/$THEME_NAME" -t 3500
