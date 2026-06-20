#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"

log "Checking developer tools"
missing=0
for cmd in bash python3 git rustup cargo; do
  if ! need_cmd "$cmd"; then
    missing=1
  fi
done

if command -v rustup >/dev/null 2>&1; then
  run rustup show
fi

if [ "$missing" -ne 0 ]; then
  echo "Install missing tools, then rerun this script."
  exit 1
fi

cat <<'TXT'

Bootstrap check complete.

Recommended next commands:
  scripts/dev/layout.sh
  scripts/dev/github-ready.sh
  make metadata
TXT
