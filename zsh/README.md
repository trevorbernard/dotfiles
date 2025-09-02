# Portable Zsh Configuration

This zsh configuration is designed to work across macOS and Linux systems with automatic tool detection and platform-specific adaptations.

## Features

- **Cross-platform**: Works on macOS and Linux
- **Self-installing**: Automatically installs Oh My Zsh and required plugins
- **Tool detection**: Only initializes tools that are available
- **Platform-specific paths**: Handles Homebrew on macOS and user bins on Linux

## Setup

### Prerequisites

Install these tools on your system (the config will work without them but functionality will be limited):

#### macOS (via Homebrew)
```bash
brew install eza fzf starship zoxide direnv atuin
```

#### Linux (NixOS)
Already handled by your system configuration.

#### Linux (Ubuntu/Debian)
```bash
# Basic tools
sudo apt update
sudo apt install git curl zsh

# Install eza
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install eza

# Install other tools
sudo apt install fzf
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

4. **Start a new shell or reload**:
   ```bash
   exec zsh
   ```

The configuration will automatically:
- Install Oh My Zsh if not present
- Clone required zsh plugins
- Configure based on your OS
- Only enable tools that are available

## What's Different from System Config

This user-level configuration replaces the need for system-level zsh setup:

### Before (NixOS system config)
- oh-my-zsh installed system-wide
- Plugins managed through NixOS
- All tools assumed to be available

### After (User config)
- oh-my-zsh installed in user directory
- Plugins auto-installed via git
- Tools conditionally loaded if available
- Works the same across macOS and Linux

## Configuration Structure

```
~/dotfiles/zsh/
├── .zshrc          # Main configuration file
└── README.md       # This file
```

The configuration includes:
- OS detection and platform-specific settings
- Automatic Oh My Zsh and plugin installation
- Conditional tool initialization
- Cross-platform aliases
- Environment variable setup