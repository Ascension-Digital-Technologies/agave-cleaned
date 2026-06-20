#!/usr/bin/env python3
"""Print a compact top-level repository map."""
from pathlib import Path
root = Path(__file__).resolve().parents[1]
for path in sorted(root.iterdir(), key=lambda p: (p.name.startswith('.'), p.name.lower())):
    if path.name in {'target', '.git'}:
        continue
    if path.is_dir():
        count = sum(1 for _ in path.rglob('*'))
        print(f'{path.name}/ ({count} entries)')
    else:
        print(path.name)
