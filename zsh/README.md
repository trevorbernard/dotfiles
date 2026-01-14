# Portable Zsh Configuration

Vanilla zsh configuration designed to work across macOS and Linux systems with automatic tool detection and platform-specific adaptations.

## Features

- **Cross-platform**: Works on macOS and Linux
- **Self-installing plugins**: Automatically clones required zsh plugins
- **Tool detection**: Only initializes tools that are available
- **Platform-specific paths**: Handles Homebrew on macOS and user bins on Linux
- **Completion caching**: Fast shell startup with cached completions

## Plugins

Plugins are automatically installed to `~/.zsh/plugins/`:

- **zsh-autosuggestions** - Fish-like autosuggestions
- **zsh-syntax-highlighting** - Command syntax highlighting
- **zsh-completions** - Additional completion definitions

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

3. **Link the configuration**:
   ```bash
   ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
   ```

4. **Start a new shell**:
   ```bash
   exec zsh
   ```

The configuration will automatically clone required plugins on first run.

## Configuration Structure

```
~/dotfiles/zsh/
├── .zshrc          # Main configuration file
└── README.md       # This file

~/.zsh/plugins/     # Auto-installed plugins (not in dotfiles)
├── zsh-autosuggestions/
├── zsh-syntax-highlighting/
└── zsh-completions/
```
