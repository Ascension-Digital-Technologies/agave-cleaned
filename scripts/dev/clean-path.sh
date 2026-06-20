#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
if [ "$#" -ne 1 ]; then
  die "usage: scripts/dev/clean-path.sh <upstream-path>"
fi
run_python scripts/dev/path-map.py --from-upstream "$1"
