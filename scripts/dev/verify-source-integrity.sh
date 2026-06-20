#!/usr/bin/env bash
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/lib/common.sh"
run_python scripts/dev/source-manifest.py --verify docs/source-manifest.json
