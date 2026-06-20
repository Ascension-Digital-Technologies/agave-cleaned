#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run scripts/dev/layout.sh
run_python scripts/dev/check-doc-links.py
run_python scripts/dev/check-script-permissions.py
run_python scripts/dev/check-generated-clean.py
log "Repository hygiene checks passed"
