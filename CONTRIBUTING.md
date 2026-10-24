# Contributing

This is a personal dotfiles repo, but suggestions, fixes, and improvements are
welcome — especially portability fixes and script improvements.

## How to contribute

1. Fork the repo and create a branch:
   ```bash
   git checkout -b fix/description-of-change
   ```
2. Make your changes (see the rules below).
3. Test that nothing breaks:
   ```bash
   stow -n -v -t ~ <package>   # dry run: should report no conflicts
   ```
4. Open a pull request against `main` describing what changed and why.

## Rules

- **One package per program**, mirroring `$HOME` (`pkg/.config/<app>/...`).
- **Never commit secrets.** API keys and tokens belong in untracked local
  files (see `~/.zshrc.local` in the README), never in package files or
  history.
- **No backup files.** `*.bak`, `*.bak.*`, `*.backup` are gitignored — git
  history is the backup. Don't work around the ignore.
- **No runtime state** (caches, databases, logs, generated files). If a
  program writes state into its config dir, exclude it with a
  `.stow-local-ignore` in that package (see `waybar/` for the pattern).
- **Stow safety:** always `stow -t ~ <pkg>` from the repo root. Never stow
  into `~/.config` directly.
- Keep commits small and described in the imperative ("Add X", "Fix Y").

## Reporting problems

Open an issue with: what you expected, what happened, and the output of
`stow -n -v -t ~ <package>` if it's symlink-related.
