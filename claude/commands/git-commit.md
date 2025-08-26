Creates a git commit from staged files, or stages all files if none are staged.

Follow these steps:

1. Check if there are staged files using `git diff --cached --quiet`
2. If no files are staged, add all files in the current directory using `git add -A`
3. Follow the git commit practices from `~/.claude/CLAUDE.md`
4. Create a git commit with an appropriate commit message following conventional commit format

Remember and this is critical, don't attribute Claude or any AI tool as an author in the git commit message.
