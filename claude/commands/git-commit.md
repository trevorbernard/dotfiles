# Git Commit

Creates a git commit from staged files, or stages all files if none are staged.

## Instructions for Claude

When the user asks to commit changes:
1. Check if there are staged files using `git diff --cached --quiet`
2. If no files are staged, add all files in the current directory using `git add -A`
3. Create a git commit with an appropriate commit message following conventional commit format
4. Follow the git commit practices from CLAUDE.md
5. Never attribute Claude in the git commit message
