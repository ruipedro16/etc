#!/usr/bin/env bash

set -e

stderr() {
  echo >&2 "${@}"
}

if ! repo_root=$(git rev-parse --show-toplevel 2>/dev/null); then
    stderrq "Not inside a git repository"
    exit 0
fi

if ! command -v shfmt >/dev/null 2>&1; then
    stderr "shfmt is not installed; skipping formatting yaml files"
    exit 0
fi

STAGED_BASH_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E '\.sh$' || true)

if [ -z "$STAGED_BASH_FILES" ]; then
    echo "No staged bash files to format"
    exit 0
fi

echo "Formatting staged bash files with shfmt..."
for file in $STAGED_BASH_FILES; do
    if [ -f "$file" ]; then
        shfmt -w "$file"
        git add "$file"
    fi
done

echo "Bash files formatted."
