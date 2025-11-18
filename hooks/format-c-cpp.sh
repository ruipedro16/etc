#!/usr/bin/env bash

set -e

stderr() {
	echo >&2 "${@}"
}

if ! repo_root=$(git rev-parse --show-toplevel 2>/dev/null); then
	stderr "Not inside a git repository"
	exit 0
fi

# download only if missing in repo root
if [ ! -f "$repo_root/.clang-format" ]; then
	wget -q https://raw.githubusercontent.com/ruipedro16/CG/refs/heads/main/.clang-format -O "$repo_root/.clang-format"
else
	echo ".clang-format already exists in repo root; skipping" >&2
fi
