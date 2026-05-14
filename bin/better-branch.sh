#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NO_COLOR='\033[0m'

width1=5
width2=6
width3=30
width4=20
width5=40

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

row_format="${GREEN}%-${width1}s ${RED}%-${width2}s ${BLUE}%-${width3}s ${YELLOW}%-${width4}s ${NO_COLOR}%-${width5}s\n"

printf "$row_format" "Ahead" "Behind" "Branch" "Last Commit" " "
printf "$row_format" "-----" "------" "------------------------------" "-------------------" " "

format_string="%(objectname:short)@%(refname:short)@%(committerdate:relative)"
IFS=$'\n'

for branchdata in $(git for-each-ref --sort=-authordate --format="$format_string" --no-merged="$main_branch" refs/heads/); do
    sha=$(echo "$branchdata" | cut -d '@' -f1)
    branch=$(echo "$branchdata" | cut -d '@' -f2)
    time=$(echo "$branchdata" | cut -d '@' -f3)
    if [ "$branch" != "$main_branch" ]; then
        description=$(git config branch."$branch".description || true)
        ahead_behind=$(count_commits "$sha" "$main_branch")
        ahead=$(echo "$ahead_behind" | cut -f2)
        behind=$(echo "$ahead_behind" | cut -f1)
        printf "$row_format" "$ahead" "$behind" "$branch" "$time" "$description"
    fi
done
