#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
if [ "$#" -ne 1 ]; then
  die "usage: scripts/dev/verify-upstream.sh /path/to/upstream/agave"
fi
run_python scripts/dev/compare-upstream-source.py "$1"
