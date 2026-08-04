# Portable Zsh Configuration

Vanilla zsh configuration designed to work across macOS and Linux systems with automatic tool detection and platform-specific adaptations.

## Features

- **Cross-platform**: Works on macOS and Linux
- **Tool detection**: Only initializes tools that are available, so the config degrades gracefully on a bare machine
- **Platform-specific paths**: Homebrew and the nix daemon on macOS, user bins on both
- **Completion caching**: `compinit` only rebuilds the dump when it is more than 24 hours old
- **No plugin manager**: nothing is cloned or compiled at shell startup

## Plugins

Autosuggestions and syntax highlighting are provided by the system, not by this
file — `programs.zsh.autosuggestions` and `programs.zsh.syntaxHighlighting` in
nixos (Linux) or nix-darwin (macOS). `.zshrc` only configures them:

- `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE` to match the Catppuccin Macchiato palette
- `ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE` to stop suggesting on long lines
- `ZSH_AUTOSUGGEST_CLEAR_WIDGETS` so history search and the fzf widget clear the suggestion

If you are on a machine without nix, install the two plugins however that
system prefers and source them; nothing else in this file depends on them.

## What's configured

- **History**: 10k entries in `~/.zsh_history`, shared between sessions, duplicates and space-prefixed commands ignored
- **Options**: `AUTO_CD`, `CORRECT`, `NO_BEEP`, `EXTENDED_GLOB`
- **Sudo widget**: `Esc Esc` prefixes the current line with `sudo`, replacing the oh-my-zsh sudo plugin
- **Completion**: menu selection, case-insensitive matching, `LS_COLORS`-aware listings
- **Aliases**: `ls`/`ll`/`lt` (eza when present), `gst`, `gdc`, `e`
- **Environment**: `EDITOR=emacs`, `COLORTERM=truecolor`, Wayland backend hints on Linux

Tools are initialized only when installed: direnv, zoxide, fzf, starship, atuin.
zoxide also aliases `cd` to `z`, except under Claude Code, where the
non-standard `cd` confuses the agent.

## Setup

### Prerequisites

Install these tools (the config works without them but functionality will be limited):

#### macOS (via Homebrew)
```bash
brew install eza fzf starship zoxide direnv atuin
```

#### Linux (NixOS)
Already handled by your system configuration.

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git curl zsh fzf

# Install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install eza

# Install other tools
curl -sS https://starship.rs/install.sh | sh
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
curl -sS https://webi.sh/direnv | sh
bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
```

### Installation

1. **Clone dotfiles** (if not already done):
   ```bash
   git clone <your-dotfiles-repo> ~/dotfiles
   ```

2. **Set zsh as default shell**:
   ```bash
   chsh -s $(which zsh)
   ```

3. **Link the configuration** with GNU Stow, as with every other package in this
   repo:
   ```bash
   cd ~/dotfiles
   stow -t $HOME zsh
   ```

4. **Start a new shell**:
   ```bash
   exec zsh
   ```

## Configuration Structure

```
~/dotfiles/zsh/
├── .zshrc          # Main configuration file (stowed to ~/.zshrc)
└── README.md       # This file
```
