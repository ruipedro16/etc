#!/usr/bin/env bash

set -e

stderr() {
	echo >&2 "${@}"
}

if ! repo_root=$(git rev-parse --show-toplevel 2>/dev/null); then
	stderrq "Not inside a git repository"
	exit 0
fi
