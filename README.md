# My Dotfiles

Personal configuration files for my Linux setup.

Managed using **GNU Stow** for clean and reversible symlink deployment.

---

## Structure

Each program has its own directory.

Each directory mirrors the `$HOME` structure so it can be managed with GNU Stow.

Example:

```
qutebrowser/
└── .config/
    └── qutebrowser/
```

This ensures files are symlinked correctly into:

```
~/.config/qutebrowser
```

---

## Requirements

- git
- stow

Install Stow (Arch Linux):

```
sudo pacman -S stow
```

---

## Installation

Clone the repository:

```
git clone https://github.com/Alenbosh/dotfiles.git
cd dotfiles
```

Stow a program:

```
stow qutebrowser
```

This will create symlinks inside your home directory.

---

## Removing a Program

To remove symlinks:

```
stow -D qutebrowser
```

---

## Notes

- Machine-specific or auto-generated files (cache, session data, etc.) are excluded.
- Configurations are intended to be portable across systems.
