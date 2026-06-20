#!/usr/bin/env python3
"""Print a compact top-level repository map."""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SKIP = {"target", ".git"}

for path in sorted(ROOT.iterdir(), key=lambda p: (p.name.startswith("."), p.name.lower())):
    if path.name in SKIP:
        continue
    if path.is_dir():
        files = sum(1 for item in path.rglob("*") if item.is_file() and not any(part in SKIP for part in item.parts))
        dirs = sum(1 for item in path.rglob("*") if item.is_dir() and not any(part in SKIP for part in item.parts))
        print(f"{path.name}/ ({dirs} dirs, {files} files)")
    else:
        print(path.name)
