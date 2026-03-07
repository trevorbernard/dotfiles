Creates a git commit from staged files, or stages changed files if none are staged.

Follow these steps:

1. Check if there are staged files using `git diff --cached --quiet`
2. If no files are staged, review `git status` and stage relevant changed files by name (avoid `git add -A` which can accidentally include sensitive files or unrelated changes)
3. Follow the git commit practices from `~/.claude/CLAUDE.md`
4. Create a git commit with an appropriate commit message following conventional commit format

Never attribute Claude or any AI tool as an author in the git commit message.
