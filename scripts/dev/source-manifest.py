#!/usr/bin/env python3
"""Generate or verify the cleaned repository source manifest."""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

SOURCE_EXTENSIONS = {
    ".rs", ".c", ".h", ".cc", ".cpp", ".cxx", ".hpp", ".hh", ".hxx",
    ".proto", ".s", ".S", ".asm", ".inc", ".cu", ".cl",
}
EXCLUDED_DIRS = {".git", "target", ".idea", ".vscode", "node_modules", "__pycache__"}
DEFAULT_MANIFEST = Path("docs/source-manifest.json")


def repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def is_source_file(path: Path) -> bool:
    return path.suffix in SOURCE_EXTENSIONS


def iter_source_files(root: Path) -> Iterable[Path]:
    for dirpath, dirnames, filenames in os.walk(root):
        rel_dir = Path(dirpath).relative_to(root)
        dirnames[:] = [d for d in dirnames if d not in EXCLUDED_DIRS]
        if any(part in EXCLUDED_DIRS for part in rel_dir.parts):
            continue
        for name in filenames:
            path = Path(dirpath) / name
            if is_source_file(path):
                yield path


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for chunk in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def generate_manifest(root: Path) -> dict:
    files = []
    for path in sorted(iter_source_files(root), key=lambda p: p.relative_to(root).as_posix()):
        rel = path.relative_to(root).as_posix()
        files.append({
            "path": rel,
            "size": path.stat().st_size,
            "sha256": sha256_file(path),
        })
    return {
        "schema": "agave-professional-source-manifest-v1",
        "repository": "agave-professional",
        "upstream_repository": "https://github.com/anza-xyz/agave",
        "upstream_commit": None,
        "generated_at_utc": datetime.now(timezone.utc).replace(microsecond=0).isoformat(),
        "source_file_count": len(files),
        "source_extensions": sorted(SOURCE_EXTENSIONS, key=lambda ext: (ext.lower(), ext.isupper())),
        "files": files,
    }


def normalized_for_compare(manifest: dict) -> dict:
    return {
        "schema": manifest.get("schema"),
        "repository": manifest.get("repository"),
        "upstream_repository": manifest.get("upstream_repository"),
        "upstream_commit": manifest.get("upstream_commit"),
        "source_file_count": manifest.get("source_file_count"),
        "source_extensions": sorted(manifest.get("source_extensions", []), key=lambda ext: (ext.lower(), ext.isupper())),
        "files": sorted(manifest.get("files", []), key=lambda item: item["path"]),
    }


def write_manifest(root: Path, manifest_path: Path) -> None:
    manifest = generate_manifest(root)
    manifest_path.parent.mkdir(parents=True, exist_ok=True)
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"wrote {manifest_path} ({manifest['source_file_count']} source files)")


def verify_manifest(root: Path, manifest_path: Path) -> int:
    if not manifest_path.exists():
        print(f"error: manifest not found: {manifest_path}")
        return 1
    expected = json.loads(manifest_path.read_text(encoding="utf-8"))
    actual = generate_manifest(root)
    expected_norm = normalized_for_compare(expected)
    actual_norm = normalized_for_compare(actual)
    if expected_norm == actual_norm:
        print(f"source manifest verified ({actual['source_file_count']} source files)")
        return 0

    expected_files = {item["path"]: item for item in expected_norm["files"]}
    actual_files = {item["path"]: item for item in actual_norm["files"]}
    expected_paths = set(expected_files)
    actual_paths = set(actual_files)
    missing = sorted(expected_paths - actual_paths)
    added = sorted(actual_paths - expected_paths)
    changed = sorted(
        p for p in expected_paths & actual_paths
        if expected_files[p]["sha256"] != actual_files[p]["sha256"] or expected_files[p]["size"] != actual_files[p]["size"]
    )

    print("error: source manifest verification failed")
    if missing:
        print(f"missing source files ({len(missing)}):")
        for p in missing[:50]:
            print(f"  - {p}")
    if added:
        print(f"added source files ({len(added)}):")
        for p in added[:50]:
            print(f"  + {p}")
    if changed:
        print(f"changed source files ({len(changed)}):")
        for p in changed[:50]:
            print(f"  * {p}")
    if len(missing) + len(added) + len(changed) > 150:
        print("  ... output truncated")
    return 1


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--write", nargs="?", const=str(DEFAULT_MANIFEST), help="write manifest to path")
    group.add_argument("--verify", nargs="?", const=str(DEFAULT_MANIFEST), help="verify current tree against manifest")
    args = parser.parse_args()

    root = repo_root()
    if args.write:
        write_manifest(root, root / args.write)
        return 0
    if args.verify:
        return verify_manifest(root, root / args.verify)
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
