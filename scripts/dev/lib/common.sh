#!/usr/bin/env bash
set -euo pipefail

repo_root() {
  local source_dir
  source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  cd "$source_dir/../../.." && pwd
}

ROOT="$(repo_root)"
cd "$ROOT"

log() {
  printf '\n==> %s\n' "$*"
}

need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'missing required command: %s\n' "$1" >&2
    return 1
  fi
}

run() {
  log "$*"
  "$@"
}
