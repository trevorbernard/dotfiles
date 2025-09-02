# Portable zsh configuration for macOS and Linux
# OS detection
case "$OSTYPE" in
  darwin*) OS="macos" ;;
  linux*) OS="linux" ;;
  *) OS="unknown" ;;
esac

# Set PATH for different OSes
if [[ "$OS" == "macos" ]]; then
  # Homebrew paths for macOS
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH"
  # Add Homebrew's site-functions to fpath for completions
  if [[ -d "/opt/homebrew/share/zsh/site-functions" ]]; then
    fpath=("/opt/homebrew/share/zsh/site-functions" $fpath)
  fi
elif [[ "$OS" == "linux" ]]; then
  # User bin directory
  export PATH="$HOME/bin:$PATH"
fi

# Oh My Zsh setup
export ZSH="$HOME/.oh-my-zsh"

# Install Oh My Zsh if not present
if [[ ! -d "$ZSH" ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Theme
ZSH_THEME=""  # We use starship instead

# Plugins
plugins=(
  direnv
  fzf
  git
  sudo
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Install and configure zsh plugins
ZSH_CUSTOM="$ZSH/custom"

# zsh-autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Load plugins
source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null

# Autosuggestions configuration
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5b6078"
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
    history-search-forward
    history-search-backward
    history-beginning-search-forward
    history-beginning-search-backward
    fzf-history-widget
)

# Aliases (OS-specific)
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --color=always'
  alias ll='ls -lag'
  alias lt='ls --tree'
else
  alias ls='ls --color=auto'
  alias ll='ls -lag'
fi

alias gst='git status'
alias gdc='git diff --cached'
alias e='emacs'

# Only alias cd to z if zoxide is available
if command -v zoxide >/dev/null 2>&1; then
  alias cd='z'
fi

# Environment variables
export EDITOR="emacs"
export COLORTERM="truecolor"
export TERM="xterm-direct"

# Tool initialization (only if tools are available)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
  eval "$(fzf --zsh)"
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

# Enable completions
autoload -Uz compinit
compinit

# OS-specific configurations
case "$OS" in
  macos)
    # macOS specific settings
    ;;
  linux)
    # Linux specific settings
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
      # Wayland specific
      export QT_QPA_PLATFORM="wayland"
      export GDK_BACKEND="wayland"
    fi
    ;;
esac
