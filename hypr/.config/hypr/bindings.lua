-- Personal keybindings migrated from bindings.conf for Omarchy Quattro.
-- bindings.conf is retained as the original reference; Quattro loads this file.
--
-- Omarchy defaults are loaded before this file. Every key that replaces a
-- default binding is explicitly unbound first.

-- Application bindings
hl.unbind("SUPER + ALT + RETURN") -- Omarchy Tmux
o.bind("SUPER + ALT + RETURN", "Tmux", [[uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)" tmux new]])
hl.unbind("SUPER + RETURN") -- Omarchy Terminal
o.bind("SUPER + RETURN", "Terminal", [[uwsm-app -- xdg-terminal-exec --dir="$(omarchy-cmd-terminal-cwd)"]])
hl.unbind("SUPER + SHIFT + RETURN") -- Omarchy Browser
o.bind("SUPER + SHIFT + RETURN", "Browser", "omarchy-launch-browser")
hl.unbind("SUPER + SHIFT + F") -- Omarchy File manager
o.bind("SUPER + SHIFT + F", "File manager", "uwsm-app -- nautilus --new-window")
hl.unbind("SUPER + ALT + SHIFT + F") -- Omarchy File manager (cwd)
o.bind(
	"SUPER + ALT + SHIFT + F",
	"File manager (cwd)",
	[[uwsm-app -- nautilus --new-window "$(omarchy-cmd-terminal-cwd)"]]
)
hl.unbind("SUPER + SHIFT + B") -- Omarchy Browser
o.bind("SUPER + SHIFT + B", "Browser", "omarchy-launch-browser")
hl.unbind("SUPER + SHIFT + C") -- Omarchy Calendar
o.bind("SUPER + SHIFT + C", "VS Code", [[omarchy-launch-or-focus "^code$" "uwsm-app -- code"]])
hl.unbind("SUPER + SHIFT + ALT + B") -- Omarchy Browser (private)
o.bind("SUPER + SHIFT + ALT + B", "Browser (private)", "omarchy-launch-browser --private")
hl.unbind("SUPER + SHIFT + M") -- Omarchy Music
o.bind("SUPER + SHIFT + M", "Sporetify", "omarchy shell -q sporetify toggleApp")
o.bind("SUPER + SHIFT + T", "Activity", "omarchy-launch-tui btop")
hl.unbind("SUPER + SHIFT + N") -- Omarchy Editor
o.bind("SUPER + SHIFT + N", "Notion", [[omarchy-launch-or-focus "^Notion$" "uwsm-app -- notion-app"]])
o.bind("SUPER + SHIFT + D", "Look up selection in dictionary", "omarchy-dictionary-lookup")
-- Scripts and terminal-related bindings
o.bind("SUPER + SHIFT + I", "ISL", "/home/alen/.config/hypr/scripts/open_isl_live.sh")
hl.unbind("SUPER + SHIFT + E") -- Omarchy Email
o.bind("SUPER + SHIFT + E", "Entertainment", [[uwsm-app -- bash -lc "$HOME/.local/bin/play-video"]])
o.bind("SUPER + SHIFT + L", "dmenunotes", "/home/alen/.local/bin/dmenunotes")
o.bind("SUPER + SHIFT + R", "Radio Atlas", "omarchy-shell shell toggle akshar.radio-atlas '{}'")
o.bind("SUPER + SHIFT + ALT + R", "rmpc", "omarchy-launch-tui rmpc")
o.bind("SUPER + SHIFT + Z", "Yazi File Manager", "uwsm-app -- xdg-terminal-exec -- yazi")
o.bind("SUPER + SHIFT + V", "Neovim", "uwsm-app -- xdg-terminal-exec -- nvim")
hl.unbind("SUPER + SHIFT + W") -- Omarchy Omawrite
hl.unbind("SUPER + SHIFT + S") -- Omarchy Google Maps
o.bind("SUPER + SHIFT + S", "Sound", "/home/alen/.local/bin/audio-toggle")
hl.unbind("SUPER + TAB")
o.bind("SUPER + TAB", "Workspace overview", "omarchy-shell shell toggle se.mindfulstack.omascape")
-- Launchers
o.bind("ALT + SPACE", "Find files & folders", "omarchy-find")
o.bind("SUPER + ALT + T", "Theme picker (rofi)", "uwsm-app -- /home/alen/.local/bin/rofi-theme-picker")
o.bind("SUPER + F10", "Wallpaper picker (rofi)", "uwsm-app -- /home/alen/.local/bin/wallpaper-switch.sh")
o.bind("SUPER + SHIFT + F10", "Import wallpaper", "uwsm-app -- /home/alen/.local/bin/wallpaper-import.sh")
-- Replaces the stale Waybar switcher target with the modular Quickshell bar picker.
-- o.bind("SUPER + SHIFT + Q", "Quickshell Bar Switcher", "uwsm-app -- /home/alen/.local/bin/quickshell-bar-switcher")

-- Music and sports
hl.unbind("SUPER + SHIFT + ALT + A") -- Omarchy Grok
o.bind("SUPER + SHIFT + ALT + A", "Athletics", "/home/alen/baseball_game.sh")
hl.unbind("SUPER + SHIFT + A") -- Omarchy ChatGPT
o.bind("SUPER + SHIFT + A", "Rmusic", "/home/alen/.local/bin/mpd-search-play")
hl.unbind("SUPER + SHIFT + P") -- Omarchy Google Photos
o.bind("SUPER + SHIFT + P", "MPD Play/Pause", "mpc toggle")
o.bind("SUPER + SHIFT + H", "MPD Next", "/home/alen/.local/bin/mpd-track-skip.sh")
hl.unbind("SUPER + SHIFT + G") -- Omarchy Signal
o.bind("SUPER + SHIFT + G", "MPD Previous", "mpc prev")
hl.unbind("SUPER + SHIFT + X") -- Omarchy X
o.bind("SUPER + SHIFT + X", "MPD Stop", "mpc clear")
hl.unbind("SUPER + SHIFT + D") -- Omarchy Docker
o.bind("SUPER + SHIFT + Q", "Add to Queue", "/home/alen/.local/bin/mpd-queue-add")
o.bind("SUPER + SHIFT + ALT + Z", "Zed", "uwsm-app -- gtk-launch dev.zed.Zed")
hl.unbind("SUPER + SHIFT + ALT + M") -- Omarchy Music TUI
o.bind("SUPER + SHIFT + ALT + M", "MLB Live", "sports mlb")
o.bind("SUPER + SHIFT + ALT + S", "MLB Popup", "sports popup")
o.bind("SUPER + SHIFT + ALT + L", "Sports Menu", "sports")
o.bind("SUPER + SHIFT + ALT + T", "Sports Dashboard", "sports dashboard")

-- System
hl.unbind("SUPER + ESCAPE") -- Omarchy System menu
o.bind("SUPER + ESCAPE", "System menu", "omarchy-menu toggle system")
-- omalt-tab
local omalt_tab = os.getenv("HOME") .. "/.config/omarchy/plugins/io.github.codesmith28.omalt-tab/hypr/bindings.lua"
local f = io.open(omalt_tab, "r")
if f then
	f:close()
	dofile(omalt_tab)
end
o.bind("ALT + z", "Spotlight", "omarchy-shell shell toggle io.github.maajix.spotlight '{}'")

-- >>> keystroke voice: hold the palette hotkey to dictate (written by Keystroke Settings › Voice)
o.bind("SUPER + SPACE", nil, "omarchy-shell shell call omarchy.menu voiceHold '{}'", { long_press = true })
o.bind("SUPER + SPACE", nil, "omarchy-shell shell call omarchy.menu voiceRelease '{}'", { release = true })
-- <<< keystroke voice

-- realme Buds Control
o.bind("SUPER + ALT + A", "Cycle Earbuds ANC", "omarchy-shell realme-buds.control cycleAnc")
o.bind("SUPER + ALT + G", "Toggle Earbuds Game Mode", "omarchy-shell realme-buds.control toggleGameMode")


-- flea --default: begin. Written by `flea --default`; `flea --default off` removes the block whole.
hl.unbind("SUPER + SHIFT + F")
o.bind("SUPER + SHIFT + F", "File manager", { launch = 'flea --gui' })
hl.unbind("SUPER + ALT + SHIFT + F")
o.bind("SUPER + ALT + SHIFT + F", "File manager (cwd)", { launch = 'flea --gui "$(omarchy-cmd-terminal-cwd)"' })
-- flea --default: end.

-- flea --picker: begin. Written by `flea --picker`; `flea --picker off` removes the block whole.
o.window("com.thisisgm.flea.picker", { tag = "+floating-window" })
-- flea --picker: end.
