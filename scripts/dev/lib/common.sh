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

warn() {
  printf 'warning: %s\n' "$*" >&2
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

need_cmd() {
  if ! has_cmd "$1"; then
    printf 'missing required command: %s\n' "$1" >&2
    return 1
  fi
}

python_cmd() {
  if has_cmd python3; then
    printf 'python3'
  elif has_cmd python; then
    printf 'python'
  else
    return 1
  fi
}

cargo_cmd() {
  if [ -x "$ROOT/cargo" ]; then
    printf './cargo'
  elif has_cmd cargo; then
    printf 'cargo'
  else
    return 1
  fi
}

rustup_cmd() {
  if has_cmd rustup; then
    printf 'rustup'
  else
    return 1
  fi
}

run() {
  log "$*"
  "$@"
}

run_cargo() {
  local cargo_bin
  cargo_bin="$(cargo_cmd)" || die "cargo was not found. Install Rust or run scripts/dev/bootstrap.sh for setup guidance."
  run "$cargo_bin" "$@"
}

run_python() {
  local py
  py="$(python_cmd)" || die "python was not found. Install Python 3 and rerun this command."
  run "$py" "$@"
}
