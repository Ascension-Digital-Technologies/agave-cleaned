#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

version_line() {
  local label="$1"
  shift
  if "$@" >/tmp/agave_script_version.$$ 2>/tmp/agave_script_version_err.$$; then
    local first
    first="$(head -n 1 /tmp/agave_script_version.$$)"
    printf '  %-18s %s\n' "$label" "${first:-available}"
  else
    printf '  %-18s missing\n' "$label"
  fi
  rm -f /tmp/agave_script_version.$$ /tmp/agave_script_version_err.$$
}

log "Repository"
printf '  %-18s %s\n' "root" "$ROOT"
if has_cmd git && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  printf '  %-18s %s\n' "git branch" "$(git branch --show-current 2>/dev/null || true)"
  if git diff --quiet --ignore-submodules -- 2>/dev/null && git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
    printf '  %-18s clean\n' "git status"
  else
    printf '  %-18s changed files present\n' "git status"
  fi
else
  printf '  %-18s not a git checkout\n' "git status"
fi

log "Platform"
printf '  %-18s %s\n' "system" "$(uname -s 2>/dev/null || echo unknown)"
printf '  %-18s %s\n' "machine" "$(uname -m 2>/dev/null || echo unknown)"
printf '  %-18s %s\n' "shell" "${SHELL:-unknown}"

log "Tools"
version_line "bash" bash --version
version_line "git" git --version
if py="$(python_cmd 2>/dev/null)"; then
  version_line "python" "$py" --version
else
  printf '  %-18s missing\n' "python"
fi
if cargo="$(cargo_cmd 2>/dev/null)"; then
  version_line "cargo" "$cargo" --version
else
  printf '  %-18s missing\n' "cargo"
fi
version_line "rustup" rustup --version
version_line "rustc" rustc --version
version_line "rustfmt" rustfmt --version
version_line "clippy" cargo clippy --version
version_line "nextest" cargo nextest --version
version_line "cmake" cmake --version
version_line "clang" clang --version
version_line "protoc" protoc --version

if has_cmd rustup; then
  log "Rust toolchain"
  rustup show active-toolchain 2>/dev/null || true
  rustup target list --installed 2>/dev/null || true
fi

log "Workspace summary"
run_python scripts/workspace-summary.py
