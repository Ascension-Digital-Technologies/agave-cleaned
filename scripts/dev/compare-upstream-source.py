#!/usr/bin/env python3
"""Compare cleaned source files with a local upstream Agave checkout."""
from __future__ import annotations

import argparse
import hashlib
import os
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))
from path_map import from_clean  # type: ignore

SOURCE_EXTENSIONS = {
    ".rs", ".c", ".h", ".cc", ".cpp", ".cxx", ".hpp", ".hh", ".hxx",
    ".proto", ".s", ".S", ".asm", ".inc", ".cu", ".cl",
}
EXCLUDED_DIRS = {".git", "target", ".idea", ".vscode", "node_modules", "__pycache__"}


def repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def iter_source_files(root: Path):
    for dirpath, dirnames, filenames in os.walk(root):
        rel_dir = Path(dirpath).relative_to(root)
        dirnames[:] = [d for d in dirnames if d not in EXCLUDED_DIRS]
        if any(part in EXCLUDED_DIRS for part in rel_dir.parts):
            continue
        for name in filenames:
            path = Path(dirpath) / name
            if path.suffix in SOURCE_EXTENSIONS:
                yield path


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("upstream", help="path to a local anza-xyz/agave checkout")
    parser.add_argument("--limit", type=int, default=80, help="maximum differences to print")
    args = parser.parse_args()

    root = repo_root()
    upstream = Path(args.upstream).resolve()
    if not upstream.exists():
        print(f"error: upstream checkout not found: {upstream}")
        return 2

    checked = 0
    missing = []
    changed = []
    skipped = []

    for clean_file in sorted(iter_source_files(root), key=lambda p: p.relative_to(root).as_posix()):
        clean_rel = clean_file.relative_to(root).as_posix()
        upstream_rel = from_clean(clean_rel, root)
        if upstream_rel.startswith("removed:"):
            skipped.append(clean_rel)
            continue
        upstream_file = upstream / upstream_rel
        if not upstream_file.exists():
            missing.append((clean_rel, upstream_rel))
            continue
        checked += 1
        if clean_file.stat().st_size != upstream_file.stat().st_size or sha256_file(clean_file) != sha256_file(upstream_file):
            changed.append((clean_rel, upstream_rel))

    if not missing and not changed:
        print(f"upstream comparison passed ({checked} source files checked)")
        if skipped:
            print(f"skipped {len(skipped)} cleaned files mapped to removed paths")
        return 0

    print("upstream comparison found differences")
    print(f"checked: {checked}")
    print(f"missing upstream files: {len(missing)}")
    print(f"changed files: {len(changed)}")
    for clean_rel, upstream_rel in missing[:args.limit]:
        print(f"  missing upstream: {clean_rel} -> {upstream_rel}")
    for clean_rel, upstream_rel in changed[:args.limit]:
        print(f"  changed: {clean_rel} -> {upstream_rel}")
    if len(missing) + len(changed) > args.limit * 2:
        print("  ... output truncated")
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
