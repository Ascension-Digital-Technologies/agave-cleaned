#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run scripts/dev/layout.sh
run python3 scripts/dev/check-doc-links.py
run python3 scripts/dev/check-script-permissions.py
run python3 scripts/dev/check-generated-clean.py
log "Repository hygiene checks passed"
