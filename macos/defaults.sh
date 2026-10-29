#!/usr/bin/env bash
# App preferences that live in macOS defaults rather than a config file.
# Not a stow package; run it directly. Quit the app first or it may
# overwrite the value on exit.
set -euo pipefail

# Rex: Settings > Terminal > Option key = Send Alt (both). Rex's init.lua
# only handles keybinds, so this can't live there.
defaults write com.superlogical.rex Workspace.terminalOptionKeyBehavior -string actsAsAlt
