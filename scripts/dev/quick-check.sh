#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run scripts/dev/github-ready.sh
run scripts/dev/metadata.sh
log "Quick check passed"
