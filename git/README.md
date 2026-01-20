# Git Configuration

Modern git configuration with sensible defaults, useful aliases, and machine-specific settings support.

## Features

- **Sensible defaults**: Auto-prune on fetch, rebase on pull, verbose commits
- **Machine-specific config**: Email configured per-machine via include
- **Modern diff**: Histogram algorithm with rename detection
- **Branch management**: Branches sorted by most recent commit

## Aliases

| Alias | Command    | Description          |
|-------|------------|----------------------|
| `co`  | `checkout` | Switch branches      |
| `br`  | `branch`   | List/manage branches |
| `ci`  | `commit`   | Create a commit      |
| `st`  | `status`   | Show working tree    |
| `bb`  | `better-branch.sh` | Enhanced branch view |

## Configuration Highlights

- **fetch.prune**: Automatically remove stale remote-tracking branches
- **fetch.pruneTags**: Clean up tags deleted from remote
- **pull.rebase**: Rebase instead of merge on pull
- **push.autoSetupRemote**: Automatically set upstream on first push
- **diff.algorithm**: Uses histogram for better diffs
- **branch.sort**: Shows most recently used branches first

## Setup

### Installation

```bash
cd ~/dotfiles
stow -t $HOME git
```

### Machine-specific email

The configuration uses git's include directive to load `~/.gitconfig.local` for machine-specific settings like your email address. This keeps the shared config portable across work and personal machines.

After stowing:

```bash
cp ~/.gitconfig.local.example ~/.gitconfig.local
```

Edit `~/.gitconfig.local` and set your email:

```ini
[user]
    email = your-email@example.com
```

## Configuration Structure

```
~/dotfiles/git/
├── .gitconfig              # Main configuration (stowed to ~/.gitconfig)
├── .gitconfig.local.example  # Template for machine-specific settings
└── README.md               # This file

~/.gitconfig.local          # Machine-specific settings (not in dotfiles)
```
