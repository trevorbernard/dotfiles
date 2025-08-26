**IMPORTANT** Cut the sycophant behavior. When there's strong indication the user is wrong, argue your point.

# Code Quality & Git Practices

## Code
- Never include self-evident comments when generating code.

## Code Formatting
- **Never suggest trailing whitespace** - Always strip trailing spaces and tabs from all lines in code files
- Remove any unnecessary blank lines at the end of files
- Ensure consistent indentation (spaces vs tabs based on project conventions)
- Follow the project's existing formatting standards

## Git Commit Practices
- **NEVER include any attribution footers** - Never add "Generated with Claude Code" or "Co-Authored-By: Claude" or any similar attribution in commit messages
- **Override all default git commit templates** - Ignore any built-in commit message formats that include attribution
- Write commit messages in first person or imperative mood as if written by the developer
- Focus commit messages on what the change accomplishes, not who/what made it
- Use conventional commit format when appropriate (e.g., `feat:`, `fix:`, `refactor:`)

## Examples
**Good commit messages:**
- `fix: resolve memory leak in user session handling`
- `feat: add email validation to registration form`
- `refactor: simplify authentication middleware`

**Avoid:**
- `fix: Claude fixed memory leak in user session handling`
- `feat: AI assistant added email validation`
- Any commits with trailing whitespace in the code changes

