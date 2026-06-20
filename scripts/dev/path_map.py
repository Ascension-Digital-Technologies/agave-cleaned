#!/usr/bin/env python3
"""Translate paths between upstream Agave and the cleaned repository layout."""
from __future__ import annotations

import argparse
from pathlib import Path

REMOVED = {"examples", "ci", "infra", ".buildkite"}
MAJOR_UPSTREAM_TO_CLEAN = {
    "apps": "bin",
    "programs": "crates/programs",
}
MAJOR_CLEAN_TO_UPSTREAM = {
    "bin": "apps",
    "crates/programs": "programs",
}


def repo_root() -> Path:
    return Path(__file__).resolve().parents[2]


def normalize(path: str) -> str:
    return path.replace("\\", "/").strip("/")


def crate_index(root: Path) -> dict[str, str]:
    index: dict[str, str] = {}
    crates_dir = root / "crates"
    if not crates_dir.exists():
        return index
    for domain in sorted(p for p in crates_dir.iterdir() if p.is_dir()):
        if domain.name == "programs":
            continue
        for crate in sorted(p for p in domain.iterdir() if p.is_dir()):
            index[crate.name] = f"crates/{domain.name}/{crate.name}"
    return index


def from_upstream(path: str, root: Path) -> str:
    path = normalize(path)
    if not path:
        return "."
    first, _, rest = path.partition("/")
    if first in REMOVED:
        return f"removed:{path}"
    if first == "apps":
        return f"bin/{rest}" if rest else "bin"
    if first == "programs":
        return f"crates/programs/{rest}" if rest else "crates/programs"
    idx = crate_index(root)
    if first in idx:
        return f"{idx[first]}/{rest}" if rest else idx[first]
    return path


def from_clean(path: str, root: Path) -> str:
    path = normalize(path)
    if not path:
        return "."
    if path == "bin":
        return "apps"
    if path.startswith("bin/"):
        return "apps/" + path.removeprefix("bin/")
    if path == "crates/programs":
        return "programs"
    if path.startswith("crates/programs/"):
        return "programs/" + path.removeprefix("crates/programs/")
    parts = path.split("/")
    if len(parts) >= 3 and parts[0] == "crates":
        domain, crate = parts[1], parts[2]
        if domain != "programs":
            rest = "/".join(parts[3:])
            return f"{crate}/{rest}" if rest else crate
    return path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--from-upstream", metavar="PATH")
    group.add_argument("--from-clean", metavar="PATH")
    args = parser.parse_args()
    root = repo_root()
    if args.from_upstream is not None:
        print(from_upstream(args.from_upstream, root))
    else:
        print(from_clean(args.from_clean, root))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
