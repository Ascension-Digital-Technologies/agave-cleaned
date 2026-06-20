#!/usr/bin/env python3
"""Print a compact summary of the cleaned Cargo workspace."""
from __future__ import annotations

import argparse
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FORBIDDEN_ROOT_DIRS = {"apps", "ci", "infra", "examples", "programs", ".buildkite"}
EXPECTED_ROOT_DIRS = {"bin", "crates", "docs", "scripts", "tools"}


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="ignore")


def workspace_members() -> list[str]:
    text = read_text(ROOT / "Cargo.toml")
    match = re.search(r"(?ms)^members\s*=\s*\[(.*?)\]", text)
    if not match:
        return []
    return re.findall(r'"([^"]+)"', match.group(1))


def domain_for(member: str) -> str:
    parts = Path(member).parts
    if not parts:
        return "unknown"
    if parts[0] == "bin":
        return "bin"
    if parts[0] == "tools":
        return "tools"
    if parts[0] == "crates" and len(parts) > 1:
        return f"crates/{parts[1]}"
    return parts[0]


def count_files(root: Path, suffix: str) -> int:
    if not root.exists():
        return 0
    ignored = {".git", "target"}
    total = 0
    for path in root.rglob(f"*{suffix}"):
        if not any(part in ignored for part in path.parts):
            total += 1
    return total


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="fail when expected clean-layout invariants are broken")
    args = parser.parse_args()

    failures: list[str] = []
    members = workspace_members()
    domains = Counter(domain_for(member) for member in members)

    for name in sorted(FORBIDDEN_ROOT_DIRS):
        if (ROOT / name).exists():
            failures.append(f"forbidden root directory exists: {name}")
    for name in sorted(EXPECTED_ROOT_DIRS):
        if not (ROOT / name).is_dir():
            failures.append(f"expected root directory is missing: {name}")

    missing_member_manifests = [member for member in members if not (ROOT / member / "Cargo.toml").exists()]
    for member in missing_member_manifests:
        failures.append(f"workspace member missing Cargo.toml: {member}")

    print("Workspace summary")
    print(f"  members:          {len(members)}")
    print(f"  rust files:       {count_files(ROOT, '.rs')}")
    print(f"  shell scripts:    {count_files(ROOT / 'scripts', '.sh')}")
    print(f"  windows scripts:  {count_files(ROOT / 'scripts', '.cmd')}")
    print("  domains:")
    for domain, count in sorted(domains.items()):
        print(f"    {domain:<24} {count}")

    if failures:
        print("\nWorkspace summary failures:", file=sys.stderr)
        for failure in failures:
            print(f"  - {failure}", file=sys.stderr)
        return 1 if args.check else 0
    return 0


if __name__ == "__main__":
    sys.exit(main())
