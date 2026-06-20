#!/usr/bin/env python3
"""Check executable bit on shell scripts used directly by developers."""
from __future__ import annotations

import os
import stat
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
failures: list[str] = []
for path in sorted((ROOT / "scripts" / "dev").rglob("*.sh")):
    mode = path.stat().st_mode
    if not (mode & stat.S_IXUSR):
        failures.append(str(path.relative_to(ROOT)))

if failures:
    print("Shell scripts missing user executable bit:")
    for item in failures:
        print(f"  - {item}")
    sys.exit(1)
print("OK: developer shell scripts are executable")
