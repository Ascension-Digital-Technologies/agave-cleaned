#!/usr/bin/env python3
"""Lightweight local Markdown link checker for repository-relative links."""
from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote, urlparse

ROOT = Path(__file__).resolve().parents[2]
LINK_RE = re.compile(r"(?<!!)]\(([^)]+)\)")
CODE_FENCE_RE = re.compile(r"^\s*```")
SKIP_DIRS = {".git", "target", "node_modules"}

failures: list[str] = []

for md in sorted(ROOT.rglob("*.md")):
    if any(part in SKIP_DIRS for part in md.parts):
        continue
    in_fence = False
    for line_no, line in enumerate(md.read_text(encoding="utf-8", errors="ignore").splitlines(), 1):
        if CODE_FENCE_RE.match(line):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        for match in LINK_RE.finditer(line):
            raw = match.group(1).strip()
            if not raw or raw.startswith(("http://", "https://", "mailto:", "#")):
                continue
            target = raw.split("#", 1)[0]
            if not target:
                continue
            parsed = urlparse(target)
            if parsed.scheme:
                continue
            resolved = (md.parent / unquote(parsed.path)).resolve()
            try:
                resolved.relative_to(ROOT.resolve())
            except ValueError:
                # Link intentionally points outside this source archive.
                continue
            if not resolved.exists():
                failures.append(f"{md.relative_to(ROOT)}:{line_no}: missing link target {raw}")

if failures:
    print("Markdown link check failed:")
    for failure in failures:
        print(f"  - {failure}")
    sys.exit(1)
print("OK: local Markdown links resolve")
