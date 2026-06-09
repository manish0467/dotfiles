#!/usr/bin/env bash
# Shared paths for wallpaper-import / wallpaper-switch (source, do not execute).

OMARCHY_CONFIG="${OMARCHY_CONFIG:-$HOME/.config/omarchy}"
LIBRARY_ROOT="${LIBRARY_ROOT:-$HOME/Wallpapers}"
SHARED_DIR="$LIBRARY_ROOT/_shared"
THUMB_DIR="${THUMB_DIR:-$HOME/.cache/wallpaper-thumbs}"
THEME_BACKGROUNDS_PATH="$OMARCHY_CONFIG/current/theme/backgrounds/"

# Use with: find ... -type f "${WALLPAPER_NAME_EXPR[@]}"
WALLPAPER_NAME_EXPR=(
    '(' -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' ')'
)

theme_name() {
    if [[ -f "$OMARCHY_CONFIG/current/theme.name" ]]; then
        cat "$OMARCHY_CONFIG/current/theme.name"
        return
    fi
    echo "default"
}

theme_library_dir() {
    printf '%s/%s' "$LIBRARY_ROOT" "$(theme_name)"
}

ensure_theme_library() {
    local theme lib
    theme=$(theme_name)
    lib="$LIBRARY_ROOT/$theme"
    mkdir -p "$lib" "$SHARED_DIR"
    sync_omarchy_background_symlink "$theme"
}

sync_omarchy_background_symlink() {
    local theme="$1"
    local lib="$LIBRARY_ROOT/$theme"
    local omarchy_bg="$OMARCHY_CONFIG/backgrounds/$theme"

    mkdir -p "$lib" "$OMARCHY_CONFIG/backgrounds"

    if [[ -L "$omarchy_bg" ]]; then
        local target
        target=$(readlink -f "$omarchy_bg")
        [[ "$target" == "$(readlink -f "$lib")" ]] || ln -sfn "$lib" "$omarchy_bg"
        return
    fi

    if [[ -d "$omarchy_bg" ]]; then
        find "$omarchy_bg" -maxdepth 1 -type f "${WALLPAPER_NAME_EXPR[@]}" \
            -exec mv -n {} "$lib/" \; 2>/dev/null || true
        rmdir "$omarchy_bg" 2>/dev/null || true
    fi

    ln -sfn "$lib" "$omarchy_bg"
}

thumb_for() {
    local realpath
    realpath=$(readlink -f "$1")
    echo "$THUMB_DIR/$(printf '%s' "$realpath" | md5sum | cut -d' ' -f1).png"
}
