# Scripts Guide

The script surface is intentionally small. This cleaned package removes legacy CI, release, and infrastructure scripts so the remaining commands are easy to understand.

## Recommended entry points

| Script | Purpose |
| --- | --- |
| [`../scripts/dev/bootstrap.sh`](../scripts/dev/bootstrap.sh) | Check for common local tools and print next steps. |
| [`../scripts/dev/layout.sh`](../scripts/dev/layout.sh) | Run repository layout and workspace path checks. |
| [`../scripts/dev/github-ready.sh`](../scripts/dev/github-ready.sh) | Run lightweight checks before publishing to GitHub. |
| [`../scripts/dev/fmt.sh`](../scripts/dev/fmt.sh) | Run Rust formatting check. |
| [`../scripts/dev/clippy.sh`](../scripts/dev/clippy.sh) | Run workspace clippy. |
| [`../scripts/dev/test.sh`](../scripts/dev/test.sh) | Run nextest with the workspace test profile. |
| [`../scripts/dev/clean-generated.sh`](../scripts/dev/clean-generated.sh) | Remove local generated caches. |
| [`../scripts/dev/check.sh`](../scripts/dev/check.sh) | Run the standard developer check group. |

Windows wrappers:

| Script | Purpose |
| --- | --- |
| [`../scripts/dev/bootstrap-windows.cmd`](../scripts/dev/bootstrap-windows.cmd) | Windows bootstrap helper. |
| [`../scripts/dev/layout-windows.cmd`](../scripts/dev/layout-windows.cmd) | Windows layout/path checks. |
| [`../scripts/dev/check-windows.cmd`](../scripts/dev/check-windows.cmd) | Windows standard developer check group. |

## Script conventions

1. Keep developer-facing wrappers under `scripts/dev/`.
2. Keep shared shell helpers under `scripts/dev/lib/`.
3. Avoid one-off root scripts.
4. Avoid hard-coding old root-level crate paths; use the cleaned paths from [`MIGRATION_MAP.md`](MIGRATION_MAP.md).
5. Prefer short scripts that delegate to Cargo or Make targets instead of duplicating logic.
6. Run `make github-ready` before publishing documentation or layout changes.
