#!/usr/bin/env bash
# Rofi picker: ~/Wallpapers/<theme>/ + _shared + current theme pack.

set -euo pipefail

# shellcheck source=wallpaper-lib.sh
source "${BASH_SOURCE%/*}/wallpaper-lib.sh"

CURRENT_BACKGROUND_LINK="$OMARCHY_CONFIG/current/background"
THUMB_SIZE="128x80"
ROFI_THEME="$HOME/.config/rofi/themes/wallpaper-picker.rasi"

mkdir -p "$THUMB_DIR"

ensure_theme_library
THEME_LIB=$(theme_library_dir)
THEME_NAME=$(theme_name)

generate_thumbs() {
    while IFS= read -r -d '' img; do
        local thumb
        thumb=$(thumb_for "$img")
        if [[ ! -f "$thumb" ]]; then
            mkdir -p "$THUMB_DIR"
            convert "$img" -thumbnail "${THUMB_SIZE}^" \
                -gravity center -extent "$THUMB_SIZE" "$thumb" 2>/dev/null || true
        fi
    done < <(list_backgrounds)
}

list_backgrounds() {
    find -L "$THEME_LIB" "$SHARED_DIR" "$THEME_BACKGROUNDS_PATH" -maxdepth 1 -type f \
        "${WALLPAPER_NAME_EXPR[@]}" -print0 2>/dev/null
}

short_name() {
    local base="$1"
    if ((${#base} > 16)); then
        printf '%s…' "${base:0:15}"
    else
        printf '%s' "$base"
    fi
}

label_for() {
    local img="$1"
    local base short
    base=$(basename "$img")
    short=$(short_name "$base")
    case "$img" in
        "$THEME_LIB"/*)
            printf '● %s' "$short"
            ;;
        "$SHARED_DIR"/*)
            printf '★ %s' "$short"
            ;;
        "$THEME_BACKGROUNDS_PATH"*)
            printf '◇ %s' "$short"
            ;;
        *)
            printf '○ %s' "$short"
            ;;
    esac
}

lookup_from_manifest() {
    local choice="$1"
    local manifest="$2"
    awk -F'|' -v choice="$choice" '$1 == choice { print $2; exit }' "$manifest"
}

apply_wallpaper() {
    local img="$1"
    if [[ ! -f "$img" ]]; then
        notify-send "Wallpaper Error" "File not found: $img" -u critical
        exit 1
    fi

    ln -nsf "$img" "$CURRENT_BACKGROUND_LINK"

    pkill -x swaybg 2>/dev/null || true
    setsid uwsm-app -- swaybg -i "$CURRENT_BACKGROUND_LINK" -m fill >/dev/null 2>&1 &

    notify-send "Wallpaper" \
        "Set to <b>$(basename "$img")</b> (<b>$THEME_NAME</b>)" -t 2500
}

pick_wallpaper() {
    local manifest choice
    manifest=$(mktemp)
    trap 'rm -f "$manifest"' RETURN

    generate_thumbs

    choice=$(
        while IFS= read -r -d '' img; do
            local label thumb
            label=$(label_for "$img")
            thumb=$(thumb_for "$img")
            printf '%s|%s\n' "$label" "$img" >>"$manifest"
            printf '%s\0icon\x1f%s\n' "$label" "$thumb"
        done < <(list_backgrounds | sort -z) \
        | rofi -dmenu \
               -p "$THEME_NAME" \
               -i \
               -show-icons \
               -location 0 \
               -width 58 \
               -lines 4 \
               -columns 1 \
               -fixed-num-lines \
               -kb-move-char-back "Alt+Left,Control+b" \
               -kb-move-char-forward "Alt+Right,Control+f" \
               -kb-page-next "Right" \
               -kb-page-prev "Left" \
               -theme-str 'listview { lines: 4; columns: 1; fixed-height: true; scrollbar: true; cycle: true; }' \
               -theme "$ROFI_THEME"
    )

    [[ -z "$choice" ]] && exit 0
    lookup_from_manifest "$choice" "$manifest"
}

if [[ "${1:-}" = "--restore" ]]; then
    if [[ -L "$CURRENT_BACKGROUND_LINK" ]] && [[ -f "$CURRENT_BACKGROUND_LINK" ]]; then
        apply_wallpaper "$(readlink -f "$CURRENT_BACKGROUND_LINK")"
    else
        notify-send "Wallpaper" "No saved wallpaper to restore." -t 2500
    fi
    exit 0
fi

if [[ -n "${1:-}" ]]; then
    apply_wallpaper "$1"
    exit 0
fi

SELECTED=$(pick_wallpaper)
[[ -n "$SELECTED" ]] && apply_wallpaper "$SELECTED"
