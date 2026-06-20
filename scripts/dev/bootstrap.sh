#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

log "Checking developer tools"
missing=0
for cmd in bash git rustup cargo; do
  if ! need_cmd "$cmd"; then
    missing=1
  fi
done
if ! python_cmd >/dev/null 2>&1; then
  echo "missing required command: python3 or python" >&2
  missing=1
fi

optional_missing=0
for cmd in cmake clang protoc; do
  if ! has_cmd "$cmd"; then
    warn "optional build tool not found: $cmd"
    optional_missing=1
  fi
done

if has_cmd rustup; then
  run rustup show
fi

if [ "$missing" -ne 0 ]; then
  cat <<'TXT'

Install the missing required tools, then rerun this script.

Required baseline:
  - Git
  - Python 3
  - Rustup + Cargo
  - Bash or Git Bash on Windows

Useful Agave build tools:
  - clang / llvm
  - cmake
  - protoc
  - pkg-config
TXT
  exit 1
fi

cat <<'TXT'

Bootstrap check complete.

Recommended next commands:
  scripts/dev/env.sh
  scripts/dev/quick-check.sh
  scripts/dev/build.sh
TXT

if [ "$optional_missing" -ne 0 ]; then
  warn "some optional native build tools are missing; full workspace builds may fail until installed."
fi
