#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run scripts/dev/clean-generated.sh
run scripts/dev/github-ready.sh
run scripts/dev/metadata.sh
run scripts/dev/fmt.sh
run scripts/dev/clippy.sh
run scripts/dev/test.sh
log "Full local gate passed"
