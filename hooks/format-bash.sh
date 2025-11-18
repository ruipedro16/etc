#!/usr/bin/env bash

set -e

source "hooks/utils.sh"

stderr() {
	echo >&2 "${@}"
}

if ! repo_root=$(git rev-parse --show-toplevel 2>/dev/null); then
	stderr "Not inside a git repository"
	exit 0
fi

if ! command -v shfmt >/dev/null 2>&1; then
	stderr "shfmt is not installed; skipping formatting bash files"
	exit 0
fi

STAGED_BASH_FILES=()
while IFS= read -r file; do
	if [[ ! -f "$file" ]] || [[ ! -r "$file" ]]; then
		continue
	fi

	is_bash=false
	# check by extension
	if [[ "$file" == *.sh ]]; then
		is_bash=true
	else
		detected_lang=$(detect_language_from_shebang "$file")
		if [[ "$detected_lang" == "bash" ]] || [[ "$detected_lang" == "sh" ]]; then
			is_bash=true
		fi
	fi

	if [[ "$is_bash" == true ]]; then
		STAGED_BASH_FILES+=("$file")
	fi
done < <(git diff --cached --name-only --diff-filter=ACM)

if [ ${#STAGED_BASH_FILES[@]} -eq 0 ]; then
	echo "No staged bash files to format"
	exit 0
else
	echo "Found ${#STAGED_BASH_FILES[@]} staged bash file(s) to format"
fi

echo "Formatting staged bash files with shfmt..."
for file in "${STAGED_BASH_FILES[@]}"; do
	if [ -f "$file" ]; then
		echo "- Formatting $file"
		shfmt -w "$file"
		git add "$file"
	fi
done

echo "Bash files formatted."
