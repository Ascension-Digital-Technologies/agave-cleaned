#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
if run_cargo nextest --version >/dev/null 2>&1; then
  run_cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml "$@"
else
  warn "cargo-nextest is not installed; falling back to cargo test."
  run_cargo test --workspace --locked "$@"
fi
