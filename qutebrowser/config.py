# =========================
# qutebrowser config.py
# Wayland-safe / Hyprland-safe
# =========================

# Required qutebrowser globals (lint-safe)
c = c  # noqa: F821
config = config  # noqa: F821

# -------------------------
# Editor (FIXES gvim error)
# -------------------------
c.editor.command = ["ghostty", "-e", "/usr/bin/nvim", "{}"]
c.url.start_pages ="https://www.google.com"
c.url.default_page ="https://www.google.com"
# -------------------------
# Safe Xresources loader
# -------------------------
import subprocess

def read_xresources(prefix):
    props = {}
    try:
        x = subprocess.run(
            ["xrdb", "-query"],
            capture_output=True,
            text=True
        )
        if not x.stdout:
            return {}
        for line in x.stdout.split("\n"):
            if line.startswith(prefix):
                prop, _, value = line.partition(":\t")
                props[prop] = value
    except Exception:
        return {}
    return props

xresources = read_xresources("*")

def xr(key, fallback):
    return xresources.get(key, fallback)

# -------------------------
# Core behavior
# -------------------------
config.load_autoconfig(False)
c.auto_save.session = True

# -------------------------
# Colors (safe fallbacks)
# -------------------------
c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"
c.colors.statusbar.command.fg = xr("*.foreground", "#ffffff")
c.colors.statusbar.normal.fg = xr("*color14", "#ffffff")
c.colors.statusbar.passthrough.fg = xr("*color14", "#ffffff")
c.colors.statusbar.url.fg = xr("*color13", "#ffffff")
c.colors.statusbar.url.success.https.fg = xr("*color13", "#ffffff")
c.colors.statusbar.url.hover.fg = xr("*color12", "#ffffff")

c.colors.tabs.even.bg = "#00000000"
c.colors.tabs.odd.bg = "#00000000"
c.colors.tabs.bar.bg = "#00000000"

c.colors.tabs.even.fg = xr("*.color0", "#ffffff")
c.colors.tabs.odd.fg = xr("*.color0", "#ffffff")
c.colors.tabs.selected.even.bg = xr("*.foreground", "#ffffff")
c.colors.tabs.selected.odd.bg = xr("*.foreground", "#ffffff")
c.colors.tabs.selected.even.fg = xr("*.background", "#000000")
c.colors.tabs.selected.odd.fg = xr("*.background", "#000000")

c.colors.hints.bg = xr("*.background", "#000000")
c.colors.hints.fg = xr("*.foreground", "#ffffff")

c.colors.completion.match.fg = xr("*color6", "#00ffff")
c.colors.completion.item.selected.match.fg = xr("*color6", "#00ffff")
c.colors.completion.odd.bg = xr("*.background", "#000000")
c.colors.completion.even.bg = xr("*.background", "#000000")
c.colors.completion.fg = xr("*.foreground", "#ffffff")
c.colors.completion.category.bg = xr("*.background", "#000000")
c.colors.completion.category.fg = xr("*.foreground", "#ffffff")
c.colors.completion.item.selected.bg = xr("*.background", "#000000")
c.colors.completion.item.selected.fg = xr("*.foreground", "#ffffff")

c.colors.messages.info.bg = xr("*.background", "#000000")
c.colors.messages.info.fg = xr("*.foreground", "#ffffff")
c.colors.messages.error.bg = xr("*.background", "#000000")
c.colors.messages.error.fg = xr("*.foreground", "#ffffff")

c.colors.downloads.bar.bg = xr("*.background", "#000000")
c.colors.downloads.start.bg = xr("*color10", "#00ff00")
c.colors.downloads.start.fg = xr("*.foreground", "#ffffff")
c.colors.downloads.stop.bg = xr("*color8", "#ff0000")
c.colors.downloads.stop.fg = xr("*.foreground", "#ffffff")

c.colors.tooltip.bg = xr("*.background", "#000000")
c.colors.webpage.bg = xr("*.background", "#000000")
c.hints.border = xr("*.foreground", "#ffffff")

# -------------------------
# Tabs
# -------------------------
c.tabs.show = "multiple"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 9, "right": 9}
c.tabs.indicator.width = 0
c.tabs.width = "7%"
c.tabs.title.format = "{audio}{current_title}"

# -------------------------
# Fonts
# -------------------------
c.fonts.default_family = []
c.fonts.default_size = "13pt"
c.fonts.web.size.default = 20
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.sans_serif = "monospace"
c.fonts.web.family.serif = "monospace"
c.fonts.web.family.standard = "monospace"

# -------------------------
# Search engines
# -------------------------
c.url.searchengines = {
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?q={}",
    "!gh": "https://github.com/search?q={}",
    "!yt": "https://www.youtube.com/results?search_query={}",
    'DEFAULT':  'https://google.com/search?hl=en&q={}',
    '!a':       'https://www.amazon.com/s?k={}',
    '!d':       'https://duckduckgo.com/?ia=web&q={}',
}

# -------------------------
# Completion
# -------------------------
c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

# -------------------------
# Keybindings
# -------------------------
config.bind("=", "cmd-set-text -s :open")
config.bind("h", "history")
config.bind("cs", "cmd-set-text -s :config-source")
config.bind("tH", "config-cycle tabs.show multiple never")
config.bind("sH", "config-cycle statusbar.show always never")
config.bind("T", "hint links tab")
config.bind("pP", "open -- {primary}")
config.bind("pp", "open -- {clipboard}")
config.bind("pt", "open -t -- {clipboard}")
config.bind("qm", "macro-record")
config.bind("gJ", "tab-move +")
config.bind("gK", "tab-move -")
config.bind("gm", "tab-move")
config.bind(",v", "spawn mpv {url}")
config.bind(",V", "hint links spawn mpv {hint-url}")
config.bind(",M", "hint links spawn mpv {hint-url}")
config.bind("t", "open -t")
config.bind("O", "open -t")
config.bind("ot", "open -t")
# -------------------------
# Dark mode
# -------------------------
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

# -------------------------
# Privacy
# -------------------------
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)

# -------------------------
# Adblocking / Greasemonkey
# -------------------------
c.content.blocking.enabled = True

