#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run_python scripts/audit-repo-layout.py
run_python scripts/check-workspace-paths.py
run_python scripts/workspace-summary.py --check
