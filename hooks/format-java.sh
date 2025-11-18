#!/usr/bin/env bash

set -e

stderr() {
	echo >&2 "${@}"
}

if ! repo_root=$(git rev-parse --show-toplevel 2>/dev/null); then
	stderr "Not inside a git repository"
	exit 0
fi
