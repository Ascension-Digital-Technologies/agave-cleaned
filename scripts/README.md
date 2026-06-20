# Scripts

This folder is the developer toolbox for the cleaned Agave workspace. It keeps the repo easy to work with locally without bringing back the removed legacy CI, release, or infrastructure trees.

## Recommended flows

| Goal | Unix/macOS/Git Bash | Windows CMD |
| --- | --- | --- |
| See available commands | `make help` | `scripts\dev\env-windows.cmd` |
| Check tools and setup | `scripts/dev/bootstrap.sh` | `scripts\dev\bootstrap-windows.cmd` |
| Print environment report | `scripts/dev/env.sh` | `scripts\dev\env-windows.cmd` |
| Fast no-build repo check | `scripts/dev/github-ready.sh` | `scripts\dev\github-ready-windows.cmd` |
| Quick local gate | `scripts/dev/quick-check.sh` | `scripts\dev\quick-check-windows.cmd` |
| Standard development gate | `scripts/dev/check.sh` | `scripts\dev\check-windows.cmd` |
| Full local gate including tests | `scripts/dev/full-check.sh` | `scripts\dev\full-check-windows.cmd` |

## Unix scripts

| Script | Purpose |
| --- | --- |
| `scripts/dev/bootstrap.sh` | Check required tools and print practical next steps. |
| `scripts/dev/env.sh` | Print OS, Git, Rust, Cargo, native tool, and workspace diagnostics. |
| `scripts/dev/layout.sh` | Validate the cleaned top-level layout, Cargo paths, and workspace summary. |
| `scripts/dev/github-ready.sh` | Run lightweight pre-publish hygiene checks. Does not compile. |
| `scripts/dev/metadata.sh` | Run `cargo metadata --no-deps`. |
| `scripts/dev/build.sh` | Run `cargo build --workspace --locked`. Accepts extra Cargo args. |
| `scripts/dev/fmt.sh` | Check Rust formatting. |
| `scripts/dev/fmt-fix.sh` | Apply Rust formatting. |
| `scripts/dev/clippy.sh` | Run clippy for the full workspace. |
| `scripts/dev/test.sh` | Run nextest when available, otherwise fall back to `cargo test`. |
| `scripts/dev/bench.sh` | Run the upstream-style nightly benchmark command. |
| `scripts/dev/quick-check.sh` | Run hygiene checks plus `cargo metadata`. |
| `scripts/dev/check.sh` | Run hygiene, metadata, fmt, and clippy. |
| `scripts/dev/full-check.sh` | Run hygiene, metadata, fmt, clippy, and tests. |
| `scripts/dev/clean-generated.sh` | Remove generated local caches before publishing. |

## Windows wrappers

Windows wrappers pause before exit so double-click or terminal runs do not immediately close.

| Script | Purpose |
| --- | --- |
| `scripts/dev/bootstrap-windows.cmd` | Windows tool check and next-step guidance. |
| `scripts/dev/env-windows.cmd` | Windows environment and workspace diagnostics. |
| `scripts/dev/layout-windows.cmd` | Windows layout/path checks. |
| `scripts/dev/github-ready-windows.cmd` | Windows lightweight pre-publish gate. |
| `scripts/dev/metadata-windows.cmd` | Windows Cargo metadata check. |
| `scripts/dev/build-windows.cmd` | Windows workspace build. |
| `scripts/dev/fmt-windows.cmd` | Windows formatting check. |
| `scripts/dev/fmt-fix-windows.cmd` | Windows formatting fix. |
| `scripts/dev/clippy-windows.cmd` | Windows clippy check. |
| `scripts/dev/test-windows.cmd` | Windows nextest or cargo-test run. |
| `scripts/dev/bench-windows.cmd` | Windows nightly benchmark command. |
| `scripts/dev/quick-check-windows.cmd` | Windows quick local gate. |
| `scripts/dev/check-windows.cmd` | Windows standard development gate. |
| `scripts/dev/full-check-windows.cmd` | Windows full local gate. |

## Utility scripts

| Script | Purpose |
| --- | --- |
| `scripts/audit-repo-layout.py` | Enforce the cleaned root layout. |
| `scripts/check-workspace-paths.py` | Validate all local Cargo path dependencies. |
| `scripts/workspace-summary.py` | Print workspace member/file/domain counts. |
| `scripts/repo-map.py` | Print a compact root map. |

## Script conventions

- Developer-facing wrappers live under `scripts/dev/`.
- Shared shell helpers live under `scripts/dev/lib/`.
- Python utilities live directly under `scripts/` or under `scripts/dev/` when they are only used by developer gates.
- Avoid one-off root scripts.
- Avoid hard-coding old root-level crate paths; use the cleaned paths from `docs/MIGRATION_MAP.md`.
- Prefer short scripts that delegate to Cargo or Make targets instead of duplicating logic.
