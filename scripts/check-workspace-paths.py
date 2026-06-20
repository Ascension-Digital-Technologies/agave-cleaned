#!/usr/bin/env python3
"""Validate local Cargo path dependencies after repository moves."""
from __future__ import annotations
import os, re, sys
from pathlib import Path

root = Path(__file__).resolve().parents[1]
missing = []
for manifest in root.rglob('Cargo.toml'):
    text = manifest.read_text(errors='ignore')
    base = manifest.parent
    for m in re.finditer(r'(?<![-\w])path\s*=\s*"([^"]+)"', text):
        rel = m.group(1)
        if '://' in rel:
            continue
        target = (base / rel).resolve()
        if not target.exists():
            missing.append((manifest.relative_to(root), rel))
if missing:
    print('Missing Cargo path targets:')
    for manifest, rel in missing:
        print(f'  {manifest}: {rel}')
    sys.exit(1)
print('OK: all Cargo path dependencies resolve.')
