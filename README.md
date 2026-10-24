# manish0467's dotfiles

Personal configuration for an **Arch Linux** desktop running [Omarchy](https://omarchy.org/) (Hyprland), managed with **GNU Stow** for clean, reversible symlinks.

## What's here

| Package | What it is | Installs to |
|---|---|---|
| `zsh` | Zsh config (secrets stay in `~/.zshrc.local`) | `~/.zshrc` |
| `starship` | Starship prompt | `~/.config/starship.toml` |
| `omarchy` | Omarchy desktop shell — bar (`shell.json`), menus, spotlight, lock & boot screen designs | `~/.config/omarchy/` (selected files) |
| `hypr` | Hyprland on Omarchy 4 — Lua configs, shaders, scripts | `~/.config/hypr` |
| `bin` | Custom scripts (launchers, media control, wallpapers…) | `~/.local/bin/` |
| `nvim` | Neovim | `~/.config/nvim` |
| `qutebrowser` | Qutebrowser incl. bookmarks and greasemonkey scripts | `~/.config/qutebrowser` |
| `waybar` | Waybar config and variants | `~/.config/waybar`, `~/.local/share/waybar` |
| `yazi` | Yazi file manager + Catppuccin flavor | `~/.config/yazi` |
| `rofi` / `tofi` | Launchers used by the `bin` scripts | `~/.config/rofi`, `~/.config/tofi` |
| `ghostty` / `alacritty` | Terminal configs | `~/.config/ghostty`, `~/.config/alacritty` |
| `tmux` | Tmux | `~/.config/tmux` |
| `mpv` / `mpd` / `btop` | Media players and system monitor | `~/.config/{mpv,mpd,btop}` |
| `git` | Git identity and aliases | `~/.config/git/config` |

Each package directory mirrors `$HOME`:

```
qutebrowser/
└── .config/
    └── qutebrowser/
```

## Requirements

- git
- GNU Stow (`sudo pacman -S stow` on Arch)
- The programs themselves (most are in the standard Arch/Omarchy repos)

## Installation

```bash
git clone https://github.com/manish0467/dotfiles.git ~/dotfiles
cd ~/dotfiles

# stow only what you need…
stow -t ~ zsh starship

# …or everything at once
stow -t ~ bin hypr nvim qutebrowser waybar yazi zsh starship omarchy \
          ghostty alacritty rofi tofi mpv tmux mpd git btop
```

To remove a package's symlinks:

```bash
stow -D -t ~ <package>
```

> [!IMPORTANT]
> Always stow from the repo root targeting `~` (`stow -t ~ <pkg>`). Never `stow -t ~/.config` — that creates misplaced symlinks like `~/.config/.config`.

## Notes

- **Secrets are never committed.** `zsh/.zshrc` sources `~/.zshrc.local` (untracked, `chmod 600`) for API keys.
- **Omarchy 4 uses Lua configs.** In `hypr/`, the `.lua` files are live; the remaining `.conf` files (`hyprsunset`, `xdph`, `hypridle`) are read by their own daemons.
- **Theme switches and GUI settings dirty the repo** — Omarchy writes through the symlinks (e.g. `shell.json`, terminal colors). Commit the churn when it suits you; `*.bak*` files are gitignored.
- A few files contain machine-specific paths (e.g. `mpd/mpd.conf`) — adjust after cloning on other machines.
- Preview changes safely with a dry run: `stow -n -v -t ~ <package>`.

## License

[MIT](LICENSE) — do what you like, attribution appreciated.
