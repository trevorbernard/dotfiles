#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

count_commits() {
    local branch="$1"
    local base_branch="$2"
    git rev-list --left-right --count "$base_branch"..."$branch"
}

# Determine the main branch: prefer origin's default, fall back to main/master.
main_branch=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's@^origin/@@')
if [ -z "$main_branch" ]; then
    for candidate in main master; do
        if git show-ref --verify --quiet "refs/heads/$candidate"; then
            main_branch="$candidate"
            break
        fi
    done
fi
if [ -z "$main_branch" ]; then
    echo "Could not determine main branch (no origin/HEAD, no local main or master)" >&2
    exit 1
fi

format_string="%(objectname:short)@%(refname:short)@%(committerdate:relative)"
IFS=$'\n'

# Collect rows first so we can size columns to their widest contents.
headers=("Ahead" "Behind" "Branch" "Last Commit")
widths=(${#headers[0]} ${#headers[1]} ${#headers[2]} ${#headers[3]} 0)
rows=()

for branchdata in $(git for-each-ref --sort=-authordate --format="$format_string" --no-merged="$main_branch" refs/heads/); do
    sha=$(echo "$branchdata" | cut -d '@' -f1)
    branch=$(echo "$branchdata" | cut -d '@' -f2)
    time=$(echo "$branchdata" | cut -d '@' -f3)
    [ "$branch" = "$main_branch" ] && continue

    description=$(git config branch."$branch".description || true)
    ahead_behind=$(count_commits "$sha" "$main_branch")
    ahead=$(echo "$ahead_behind" | cut -f2)
    behind=$(echo "$ahead_behind" | cut -f1)

    rows+=("$ahead@$behind@$branch@$time@$description")

    [ "${#ahead}" -gt "${widths[0]}" ] && widths[0]=${#ahead}
    [ "${#behind}" -gt "${widths[1]}" ] && widths[1]=${#behind}
    [ "${#branch}" -gt "${widths[2]}" ] && widths[2]=${#branch}
    [ "${#time}" -gt "${widths[3]}" ] && widths[3]=${#time}
    [ "${#description}" -gt "${widths[4]}" ] && widths[4]=${#description}
done

# Only render the description column when at least one branch has a description.
if [ "${widths[4]}" -gt 0 ]; then
    headers+=("Description")
    desc_fmt=" ${NO_COLOR}%-${widths[4]}s"
else
    desc_fmt=""
fi

row_format="${GREEN}%-${widths[0]}s ${RED}%-${widths[1]}s ${BLUE}%-${widths[2]}s ${YELLOW}%-${widths[3]}s${desc_fmt}${NO_COLOR}\n"

make_divider() { printf '%*s' "$1" '' | tr ' ' '-'; }

printf "$row_format" "${headers[@]}"
dividers=(
    "$(make_divider "${widths[0]}")"
    "$(make_divider "${widths[1]}")"
    "$(make_divider "${widths[2]}")"
    "$(make_divider "${widths[3]}")"
)
[ "${widths[4]}" -gt 0 ] && dividers+=("$(make_divider "${widths[4]}")")
printf "$row_format" "${dividers[@]}"

for row in "${rows[@]}"; do
    ahead=$(echo "$row" | cut -d '@' -f1)
    behind=$(echo "$row" | cut -d '@' -f2)
    branch=$(echo "$row" | cut -d '@' -f3)
    time=$(echo "$row" | cut -d '@' -f4)
    if [ "${widths[4]}" -gt 0 ]; then
        description=$(echo "$row" | cut -d '@' -f5-)
        printf "$row_format" "$ahead" "$behind" "$branch" "$time" "$description"
    else
        printf "$row_format" "$ahead" "$behind" "$branch" "$time"
    fi
done
