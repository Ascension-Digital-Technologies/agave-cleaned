#!/usr/bin/env python3
"""Repository layout audit for the cleaned Agave workspace."""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ALLOWED_ROOT_DIRS = {
    ".cargo", ".config", ".github", "bin", "crates", "docs",
    "scripts", "tools",
}
ALLOWED_ROOT_FILES = {
    ".editorconfig", ".gitattributes", ".gitignore", "CHANGELOG.md",
    "CONTRIBUTING.md", "Cargo.lock", "Cargo.toml", "LICENSE", "Makefile",
    "README.md", "RELEASE.md", "SECURITY.md", "cargo", "cargo-build-sbf",
    "cargo-test-sbf", "clippy.toml", "rust-toolchain.toml", "rustfmt.toml",
}
SKIP_DIRS = {".git", "target"}
FORBIDDEN_ROOT_DIRS = {"apps", "ci", "infra", "examples", "programs", ".buildkite"}

def parse_workspace_members(cargo_toml: str) -> list[str]:
    m = re.search(r"(?ms)^members\s*=\s*\[(.*?)\]", cargo_toml)
    if not m:
        return []
    return re.findall(r'"([^"]+)"', m.group(1))

def parse_path_dependencies(text: str) -> list[str]:
    return re.findall(r'(?<![A-Za-z0-9_-])path\s*=\s*"([^"]+)"', text)

def main() -> int:
    failures: list[str] = []
    warnings: list[str] = []

    for forbidden in sorted(FORBIDDEN_ROOT_DIRS):
        if (ROOT / forbidden).exists():
            failures.append(f"forbidden root directory remains: {forbidden}")

    for p in ROOT.iterdir():
        if p.name.startswith(".git"):
            continue
        if p.is_dir() and p.name not in ALLOWED_ROOT_DIRS:
            failures.append(f"unexpected root directory: {p.name}")
        if p.is_file() and p.name not in ALLOWED_ROOT_FILES:
            warnings.append(f"unexpected root file: {p.name}")

    cargo_text = (ROOT / "Cargo.toml").read_text(errors="ignore")
    for member in parse_workspace_members(cargo_text):
        if member.startswith(("apps/", "ci/", "infra/", "examples/", "programs/")):
            failures.append(f"workspace member uses removed layout: {member}")
        if not (ROOT / member / "Cargo.toml").exists():
            failures.append(f"workspace member is missing Cargo.toml: {member}")
        if len(Path(member).parts) == 1:
            failures.append(f"workspace member still lives at root: {member}")

    for cargo_file in ROOT.rglob("Cargo.toml"):
        if any(part in SKIP_DIRS for part in cargo_file.parts):
            continue
        base = cargo_file.parent
        for dep in parse_path_dependencies(cargo_file.read_text(errors="ignore")):
            if dep.endswith(".rs"):
                continue
            if dep.startswith(("apps/", "ci/", "infra/", "examples/", "programs/")):
                failures.append(f"removed-layout Cargo path in {cargo_file.relative_to(ROOT)}: {dep}")
            if not (base / dep / "Cargo.toml").resolve().exists():
                failures.append(f"broken Cargo path dependency in {cargo_file.relative_to(ROOT)}: {dep}")

    operational_roots = [ROOT / "scripts", ROOT / ".cargo", ROOT / ".github"]
    for root in operational_roots:
        if not root.exists():
            continue
        for path in root.rglob("*"):
            if not path.is_file() or path.name == "audit-repo-layout.py":
                continue
            if any(part in SKIP_DIRS for part in path.parts):
                continue
            text = path.read_text(errors="ignore")
            if "apps/" in text:
                warnings.append(f"legacy apps/ reference: {path.relative_to(ROOT)}")
            if "ci/" in text and path.name not in {"nextest.toml"}:
                warnings.append(f"legacy ci/ reference: {path.relative_to(ROOT)}")
            if "infra/" in text:
                warnings.append(f"legacy infra/ reference: {path.relative_to(ROOT)}")
            if "examples/" in text:
                warnings.append(f"legacy examples/ reference: {path.relative_to(ROOT)}")
            if "programs/" in text and "crates/programs/" not in text:
                warnings.append(f"legacy root programs/ reference: {path.relative_to(ROOT)}")

    report = {"failures": failures, "warnings": warnings}
    print(json.dumps(report, indent=2))
    return 1 if failures else 0

if __name__ == "__main__":
    sys.exit(main())
