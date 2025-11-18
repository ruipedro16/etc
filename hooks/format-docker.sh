#!/usr/bin/env bash

set -e

stderr() {
  echo >&2 "${@}"
}

if ! command -v nix-shell >/dev/null 2>&1; then
    stderr "nix-shell is not installed; skipping formatting docker files"
    exit 0
fi
