#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run scripts/dev/github-ready.sh
run ./cargo metadata --no-deps
run ./cargo fmt --all --check
run ./cargo clippy --workspace --all-targets --locked
