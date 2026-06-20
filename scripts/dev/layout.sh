#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run python3 scripts/audit-repo-layout.py
run python3 scripts/check-workspace-paths.py
