#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run ./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml
