# ============================================================
#                     ALEN'S HYBRID ZSHRC
#          Fast · Modern · Omarchy-Friendly · Clean
# ============================================================

# ------------------------------------------------------------
# Interactive shell only
# ------------------------------------------------------------

[[ $- != *i* ]] && return

# ------------------------------------------------------------
# PATHS (deduplicated)
# ------------------------------------------------------------

typeset -U PATH

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$HOME/.cargo/bin:$PATH"
export PATH="$HOME/development/flutter/bin:$PATH"
export PATH="$HOME/.spicetify:$PATH"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"

# ------------------------------------------------------------
# ENVIRONMENT
# ------------------------------------------------------------

export EDITOR="nvim"
export VISUAL="nvim"

export STARSHIP_CONFIG="$HOME/.config/starship.toml"

export ANDROID_HOME="$HOME/Android/Sdk"
export BUN_INSTALL="$HOME/.bun"

# Secrets (API keys etc.) live in ~/.zshrc.local, which is not versioned.
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ------------------------------------------------------------
# HISTORY
# ------------------------------------------------------------

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ------------------------------------------------------------
# SHELL OPTIONS
# ------------------------------------------------------------

setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt no_nomatch

# ------------------------------------------------------------
# COMPLETION
# ------------------------------------------------------------

autoload -Uz compinit
compinit -C

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'
zstyle ':completion:*' group-name ''

# ------------------------------------------------------------
# PLUGINS
# ------------------------------------------------------------

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestion style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6078"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# ------------------------------------------------------------
# TOOL INITIALIZATION
# ------------------------------------------------------------

# zoxide
eval "$(zoxide init zsh)"

# starship
eval "$(starship init zsh)"

# Rust
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ------------------------------------------------------------
# ALIASES — SYSTEM
# ------------------------------------------------------------

alias c='clear'
alias reload='exec zsh'
alias pack='pacman -Qe | column -t > packages-readable.txt'
alias df='df -h'
alias free='free -h'
alias ports='ss -tulnp'
alias y='yazi'
alias myip='curl -s ifconfig.me'

# ------------------------------------------------------------
# ALIASES — NAVIGATION
# ------------------------------------------------------------

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ------------------------------------------------------------
# ALIASES — DEVELOPMENT
# ------------------------------------------------------------

alias cpp='g++ -std=c++17 -O2 -Wall'
alias gg='lazygit'
alias react='npm create vite@latest'

alias javaclean='rm -f *.class'

alias vim='nvim'

# ------------------------------------------------------------
# ALIASES — GIT
# ------------------------------------------------------------

alias gs='git status -sb'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -15'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'

alias gitadog='git log --all --decorate --oneline --graph'

# ------------------------------------------------------------
# ALIASES — FILES
# ------------------------------------------------------------

if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --group-directories-first --git'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza -T --icons --group-directories-first -L 3'
else
  alias ll='ls -lAh --color=auto'
  alias la='ls -A --color=auto'
fi

if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
fi

# ------------------------------------------------------------
# ALIASES — OMARCHY / PERSONAL
# ------------------------------------------------------------

alias sad='cd ~/.config/waybar && ./switch.sh > /dev/null 2>&1 && cd ~'
alias lock='omarchy-shell lock explore';
alias bore='~/.local/bin/switch-wallpaper.sh'

alias omarchy-colors='~/.config/omarchy/hooks/theme-set'
alias waybar-variant='~/.config/waybar/switch.sh'



# PDFs

alias openpdf='xdg-open >/dev/null 2>&1'
alias lock-explore='omarchy-shell lock explore'
alias rou='cd ~/Downloads && openpdf Rout.pdf && cd ~'
alias loss='cd ~/Downloads && openpdf 5th.pdf && cd ~'
alias pyq='cd ~/Downloads/college && openpdf 3rdSEM.pdf && cd ~'

# ------------------------------------------------------------
# MEDIA
# ------------------------------------------------------------

alias mpvyt='yt-dlp -o - | mpv -'

# Launch moviebox-tui inside a persistent tmux session with stderr diverted to
# a file. Closing the terminal only detaches; the app's pty survives. And since
# stderr is a regular file rather than a pty, a write can never fail with EIO
# and trip the app's "failed printing to stderr" panic on exit/shutdown.
mb() {
  local bin="$HOME/.local/bin/moviebox-tui"
  local errlog="$HOME/.local/share/moviebox-tui/stderr.log"

  mkdir -p "${errlog:h}"
  tmux new-session -A -s moviebox "$bin 2>>$errlog"
}

# ------------------------------------------------------------
# FUNCTIONS — FILE MANAGEMENT
# ------------------------------------------------------------

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted." ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ------------------------------------------------------------
# FZF CONFIG
# ------------------------------------------------------------

export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border=rounded
  --info=inline
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"

# FZF keybindings + completion

[ -f /usr/share/fzf/key-bindings.zsh ] && \
  source /usr/share/fzf/key-bindings.zsh

[ -f /usr/share/fzf/completion.zsh ] && \
  source /usr/share/fzf/completion.zsh
# ------------------------------------------------------------
# FZF FUNCTIONS
# ------------------------------------------------------------

# Open files in nvim

ff() {
  local file

  file=$(
    fzf --preview 'bat --color=always --line-range :200 {}'
  ) && nvim "$file"
}

# Open media in mpv

den() {
  local file

  file=$(fzf -m)

  [[ -n "$file" ]] && mpv "$file"
}

# Multi-file nvim opener

denji() {
  local files

  files=$(fzf -m --preview="bat --color=always {}")

  [[ -n "$files" ]] && nvim ${(f)files}
}

# Fuzzy directory cd

cdf() {
  local dir

  dir=$(
    fd --type d | \
    fzf --preview 'eza -T --icons --color=always -L 2 {}'
  ) && cd "$dir"
}

# Fuzzy history

fh() {
  local cmd

  cmd=$(fc -rln 1 | fzf --no-sort --exact)

  [[ -n "$cmd" ]] && eval "$cmd"
}

# Fuzzy process kill

fkill() {
  local pid

  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  [[ -n "$pid" ]] && echo "$pid" | xargs kill
}

# zoxide + yazi

yy() {
  local dir

  dir=$(zoxide query -i) || return

  yazi "$dir"
}

# ------------------------------------------------------------
# STARTUP GREETING
# ------------------------------------------------------------

[[ $SHLVL -eq 1 ]] && print -P \
"%F{110}Welcome%f %F{179}Alen%f  %F{103}· $(date +'%a %b %d, %I:%M %p')%f"


# Added by Antigravity CLI installer
export PATH="/home/alen/.local/bin:$PATH"
export CLAUDE_CODE_MAX_CONTEXT_TOKENS=262144

# OpenClaw Completion
[ -f '/home/alen/.openclaw/completions/openclaw.zsh' ] && source '/home/alen/.openclaw/completions/openclaw.zsh'

# opencode
export PATH=/home/alen/.opencode/bin:$PATH
export PATH="$(npm config get prefix)/bin:$PATH"
