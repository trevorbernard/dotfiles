#!/usr/bin/env bash

set -e

staged_files=$(git diff --cached --name-only --diff-filter=AM)

if [ -z "$staged_files" ]; then
    echo "No staged files to process"
    exit 0
fi

echo "Processing staged files for trailing whitespace removal..."

for file in $staged_files; do
    if [ -f "$file" ]; then
        if grep -q '[[:space:]]$' "$file"; then
            echo "Removing trailing whitespace from: $file"
            sed -i 's/[[:space:]]*$//' "$file"
            git add "$file"
        fi
    fi
done

echo "Trailing whitespace removal completed for staged files"
