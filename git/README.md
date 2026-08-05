# Git Configuration

Modern git configuration with sensible defaults, useful aliases, and machine-specific settings support.

## Features

- **Sensible defaults**: Auto-prune on fetch, rebase on pull, verbose commits
- **Machine-specific config**: Email configured per-machine via include
- **Modern diff**: Histogram algorithm with rename detection
- **Branch management**: Branches sorted by most recent commit
- **Global ignores**: Editor and tool droppings ignored once, not per-project

## Aliases

| Alias | Command    | Description          |
|-------|------------|----------------------|
| `co`  | `checkout` | Switch branches      |
| `br`  | `branch`   | List/manage branches |
| `ci`  | `commit`   | Create a commit      |
| `st`  | `status`   | Show working tree    |
| `bb`  | `better-branch` | Enhanced branch view |

`bb` shells out to `better-branch`, which lives in this repo's `bin` package
rather than in git itself. Without `bin` stowed onto `PATH` it fails with:

```
fatal: while expanding alias 'bb': 'better-branch': No such file or directory
```

## Configuration Reference

**Identity**

- **user.name**: Set here, since it is the same everywhere
- **include.path**: Pulls in `~/.gitconfig.local` for the email, which is not the same everywhere

**Commits**

- **commit.verbose**: Show the diff in the commit message editor
- **commit.gpgsign**: Signing off, explicitly
- **init.defaultBranch**: `main` for new repositories

**Fetching and pushing**

- **fetch.prune**: Automatically remove stale remote-tracking branches
- **fetch.pruneTags**: Clean up tags deleted from remote
- **fetch.all**: Fetch every remote, not just `origin`
- **push.autoSetupRemote**: Automatically set upstream on first push
- **pull.rebase**: Rebase instead of merge on pull

**Diffs**

- **diff.algorithm**: Uses histogram for better diffs
- **diff.renames**: Detect renames rather than showing add plus delete
- **diff.colorMoved**: Colour moved lines differently from added and removed ones
- **diff.mnemonicPrefix**: Use `i/` and `w/` for index and working tree instead of `a/` and `b/`

**Listing**

- **branch.sort**: Branches ordered by their last commit, newest first
- **tag.sort**: Tags ordered by version number rather than as text, so `v10` follows `v9`
- **column.ui**: Lay listings out in columns when writing to a terminal

**Ignores**

- **core.excludesFile**: Points at `~/.gitignore`, stowed from this package

Git silently ignores configuration keys it does not recognise, so the newer
options here are simply inert on an older git rather than an error.

## Setup

### Installation

```bash
cd ~/dotfiles
stow -t $HOME git
```

This stows four files, two of which are live configuration:

- `~/.gitconfig` — the main config
- `~/.gitignore` — the global ignore list, referenced by `core.excludesFile`
- `~/.gitconfig.local.example` — a template you copy, not something git reads

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

A missing include is not an error — git skips it quietly — so forgetting this
step surfaces later, at the first commit:

```
Author identity unknown

*** Please tell me who you are.
```

### Global ignores

`~/.gitignore` covers editor and tooling droppings that would otherwise have to
be repeated in every project: Claude Code local files, Emacs `.dir-locals.el`,
and Eclipse's `.classpath`, `.project` and `.settings`.

Keep it to files that are never worth committing *anywhere*. Anything specific
to one project belongs in that project's own `.gitignore`, where collaborators
can see it.

## Configuration Structure

```
~/dotfiles/git/
├── .gitconfig                # Main configuration (stowed to ~/.gitconfig)
├── .gitignore                # Global ignore list (stowed to ~/.gitignore)
├── .gitconfig.local.example  # Template for machine-specific settings
└── README.md                 # This file

~/.gitconfig.local            # Machine-specific settings (not in dotfiles)
```
