#!/usr/bin/env python3
"""Fail if generated caches that should not be committed are present."""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
problems: list[str] = []
for path in ROOT.rglob("*"):
    rel = path.relative_to(ROOT)
    parts = set(rel.parts)
    if ".git" in parts or "target" in parts:
        continue
    if path.is_dir() and path.name == "__pycache__":
        problems.append(str(rel))
    elif path.is_file() and (path.name == ".DS_Store" or path.suffix == ".pyc"):
        problems.append(str(rel))

if problems:
    print("Generated files should be cleaned before publishing:")
    for item in problems:
        print(f"  - {item}")
    sys.exit(1)
print("OK: no generated cache files found")
