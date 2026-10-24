# AGENTS.md

Instructions for AI agents (and humans in a hurry) working in this repository.

## What this repo is

Personal dotfiles for Arch Linux + Omarchy (Hyprland), deployed with GNU Stow.
Every top-level directory is a stow package that mirrors `$HOME` and is
symlinked from the user's home into this repo (e.g. `~/.config/hypr ->
~/dotfiles/hypr/.config/hypr`). Edits to files here are live edits to the
running system once stowed.

## Non-negotiable rules

1. **No secrets, ever.** Keys/tokens live in untracked `~/.zshrc.local`
   (mode 600), sourced by `zsh/.zshrc`. If you find a secret in a package
   file, stop and relocate it before committing. Never assume a private repo
   — this repo is public.
2. **Never `stow -t ~/.config`.** Stow only from the repo root with
   `stow -t ~ <pkg>`. Wrong-target stows create stray symlinks like
   `~/.config/.config`.
3. **Dry-run before restowing:** `stow -n -v -t ~ <pkg>` must report no
   conflicts before a real `stow`/`stow -R`.
4. **No backup files.** `*.bak*` / `*.backup` are gitignored on purpose; git
   history is the backup. Don't create `.bak` copies of tracked files.
5. **Don't delete `.git` or rewrite remotes** without explicit user
   instruction.

## Package quirks

- `hypr/` — Omarchy 4: the `.lua` files are the live Hyprland config; legacy
  `.conf` files were removed except `hyprsunset.conf`, `xdph.conf`,
  `hypridle.conf`, which are read by their own daemons. After changing
  anything in `hypr/`, validate with `hyprctl reload && hyprctl configerrors`.
- `omarchy/` — only selected files (shell.json, spotlight, menus, lock/boot
  designs) are packaged. `themes/`, `plugins/`, `backgrounds/`, `hooks/` are
  intentionally NOT in the repo (huge and/or auto-generated).
- `waybar/` — shows the `.stow-local-ignore` pattern for excluding runtime
  state.
- Theme switches and Omarchy GUI settings write through symlinks and dirty
  the worktree; that's expected churn, commit it normally.

## Git conventions

- Branch: `main`. Identity: `manish0467 <reshmimanish1977@gmail.com>` (set in
  `git/.config/git/config`).
- Commit style: short imperative subject lines ("Add X", "Fix Y", "Drop Z").
- Push target: `origin` = https://github.com/manish0467/dotfiles.git (public).
