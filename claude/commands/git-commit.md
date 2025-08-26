Creates a git commit from staged files, or stages all files if none are staged.

Follow these steps:

1. Check if there are staged files using `git diff --cached --quiet`
2. If no files are staged, add all files in the current directory using `git add -A`
3. Never attribute claude or any LLM  in the git commit message
4. Follow the git commit practices from `~/.claude/CLAUDE.md`
5. Create a git commit with an appropriate commit message following conventional commit format


