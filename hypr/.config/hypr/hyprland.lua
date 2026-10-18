-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")
require("hypr.envs")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Load settings written by OmaSettings (omasettings:managed).
require("hypr.omasettings")

-- >>> altscape >>>
-- Window switcher keybind, managed by Altscape (change it in its settings).
do
local altscape_manifest = io.open("/home/alen/.config/omarchy/plugins/io.github.qempexe.altscape/manifest.json", "r")
if altscape_manifest then
  altscape_manifest:close()
  hl.unbind("ALT + TAB")
  hl.unbind("ALT + SHIFT + TAB")
  o.bind("ALT + TAB", "Altscape: next window", "omarchy-shell shell summon io.github.qempexe.altscape next")
  o.bind("ALT + SHIFT + TAB", "Altscape: previous window", "omarchy-shell shell summon io.github.qempexe.altscape prev")
  -- Letting go of the modifier picks the selected window.
  o.bind("ALT + ALT_L", "Altscape: switch on release", "omarchy-shell shell summon io.github.qempexe.altscape release", { release = true })
  o.bind("ALT + ALT_R", "Altscape: switch on release", "omarchy-shell shell summon io.github.qempexe.altscape release", { release = true })
  -- Opens the settings (again to close).
  o.bind("SUPER + ALT + SHIFT + S", "Altscape settings", "omarchy-shell io.github.qempexe.altscape settings")
end
end
-- <<< altscape <<<
