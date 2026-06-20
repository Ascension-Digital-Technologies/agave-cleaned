#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
if [ "$#" -ne 1 ]; then
  die "usage: scripts/dev/upstream-path.sh <cleaned-path>"
fi
run_python scripts/dev/path-map.py --from-clean "$1"
