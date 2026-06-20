# Scripts Guide

The scripts folder is now a practical developer toolbox for the cleaned Agave workspace. It keeps local development easy while avoiding the deleted legacy CI, release, and infrastructure trees.

## Recommended flows

| Goal | Unix/macOS/Git Bash | Windows CMD |
| --- | --- | --- |
| Check local setup | [`../scripts/dev/bootstrap.sh`](../scripts/dev/bootstrap.sh) | [`../scripts/dev/bootstrap-windows.cmd`](../scripts/dev/bootstrap-windows.cmd) |
| Print diagnostics | [`../scripts/dev/env.sh`](../scripts/dev/env.sh) | [`../scripts/dev/env-windows.cmd`](../scripts/dev/env-windows.cmd) |
| Fast repo hygiene check | [`../scripts/dev/github-ready.sh`](../scripts/dev/github-ready.sh) | [`../scripts/dev/github-ready-windows.cmd`](../scripts/dev/github-ready-windows.cmd) |
| Quick local gate | [`../scripts/dev/quick-check.sh`](../scripts/dev/quick-check.sh) | [`../scripts/dev/quick-check-windows.cmd`](../scripts/dev/quick-check-windows.cmd) |
| Standard development gate | [`../scripts/dev/check.sh`](../scripts/dev/check.sh) | [`../scripts/dev/check-windows.cmd`](../scripts/dev/check-windows.cmd) |
| Full local gate | [`../scripts/dev/full-check.sh`](../scripts/dev/full-check.sh) | [`../scripts/dev/full-check-windows.cmd`](../scripts/dev/full-check-windows.cmd) |

## Unix scripts

| Script | Purpose |
| --- | --- |
| [`../scripts/dev/bootstrap.sh`](../scripts/dev/bootstrap.sh) | Check required tools and print next steps. |
| [`../scripts/dev/env.sh`](../scripts/dev/env.sh) | Print OS, Git, Rust, Cargo, native tool, and workspace diagnostics. |
| [`../scripts/dev/layout.sh`](../scripts/dev/layout.sh) | Run repository layout, Cargo path, and workspace-summary checks. |
| [`../scripts/dev/github-ready.sh`](../scripts/dev/github-ready.sh) | Run lightweight checks before publishing to GitHub. |
| [`../scripts/dev/metadata.sh`](../scripts/dev/metadata.sh) | Run `cargo metadata --no-deps`. |
| [`../scripts/dev/build.sh`](../scripts/dev/build.sh) | Build the full workspace with locked dependencies. |
| [`../scripts/dev/fmt.sh`](../scripts/dev/fmt.sh) | Run Rust formatting check. |
| [`../scripts/dev/fmt-fix.sh`](../scripts/dev/fmt-fix.sh) | Apply Rust formatting. |
| [`../scripts/dev/clippy.sh`](../scripts/dev/clippy.sh) | Run workspace clippy. |
| [`../scripts/dev/test.sh`](../scripts/dev/test.sh) | Run nextest, or `cargo test` if nextest is unavailable. |
| [`../scripts/dev/bench.sh`](../scripts/dev/bench.sh) | Run the nightly benchmark command. |
| [`../scripts/dev/quick-check.sh`](../scripts/dev/quick-check.sh) | Run hygiene checks plus Cargo metadata. |
| [`../scripts/dev/check.sh`](../scripts/dev/check.sh) | Run hygiene, metadata, fmt, and clippy. |
| [`../scripts/dev/full-check.sh`](../scripts/dev/full-check.sh) | Run hygiene, metadata, fmt, clippy, and tests. |
| [`../scripts/dev/clean-generated.sh`](../scripts/dev/clean-generated.sh) | Remove generated local caches. |

## Windows wrappers

All Windows wrappers pause before exit unless they are called by another wrapper. Cargo-taking wrappers also prepare the MSYS2/MinGW environment before running Cargo so vendored OpenSSL resolves MSYS2 Perl instead of native Windows Perl, and so OpenSSL Makefiles receive forward-slash MinGW compiler paths.

| Script | Purpose |
| --- | --- |
| [`../scripts/dev/bootstrap-windows.cmd`](../scripts/dev/bootstrap-windows.cmd) | Windows bootstrap helper. |
| [`../scripts/dev/diagnose-windows-build.cmd`](../scripts/dev/diagnose-windows-build.cmd) | Diagnose Windows Rust, Perl, MSYS2, MinGW, and bindgen setup. |
| [`../scripts/dev/enter-windows-cargo-env.cmd`](../scripts/dev/enter-windows-cargo-env.cmd) | Open a prepared Cargo/MSYS2 command shell. |
| [`../scripts/dev/env-windows.cmd`](../scripts/dev/env-windows.cmd) | Windows environment report. |
| [`../scripts/dev/layout-windows.cmd`](../scripts/dev/layout-windows.cmd) | Windows layout/path checks. |
| [`../scripts/dev/github-ready-windows.cmd`](../scripts/dev/github-ready-windows.cmd) | Windows lightweight GitHub-readiness gate. |
| [`../scripts/dev/metadata-windows.cmd`](../scripts/dev/metadata-windows.cmd) | Windows Cargo metadata check. |
| [`../scripts/build.bat`](../scripts/build.bat) | Windows workspace build. |
| [`../scripts/dev/repair-windows-openssl.cmd`](../scripts/dev/repair-windows-openssl.cmd) | Clear stale `openssl-sys` build state and rebuild. |
| [`../scripts/dev/fmt-windows.cmd`](../scripts/dev/fmt-windows.cmd) | Windows formatting check. |
| [`../scripts/dev/fmt-fix-windows.cmd`](../scripts/dev/fmt-fix-windows.cmd) | Windows formatting fix. |
| [`../scripts/dev/clippy-windows.cmd`](../scripts/dev/clippy-windows.cmd) | Windows clippy run. |
| [`../scripts/dev/test-windows.cmd`](../scripts/dev/test-windows.cmd) | Windows nextest or cargo-test run. |
| [`../scripts/dev/bench-windows.cmd`](../scripts/dev/bench-windows.cmd) | Windows nightly benchmark command. |
| [`../scripts/dev/quick-check-windows.cmd`](../scripts/dev/quick-check-windows.cmd) | Windows quick local gate. |
| [`../scripts/dev/check-windows.cmd`](../scripts/dev/check-windows.cmd) | Windows standard development gate. |
| [`../scripts/dev/full-check-windows.cmd`](../scripts/dev/full-check-windows.cmd) | Windows full local gate. |

## Utility scripts

| Script | Purpose |
| --- | --- |
| [`../scripts/audit-repo-layout.py`](../scripts/audit-repo-layout.py) | Enforce the cleaned root layout. |
| [`../scripts/check-workspace-paths.py`](../scripts/check-workspace-paths.py) | Validate local Cargo path dependencies. |
| [`../scripts/workspace-summary.py`](../scripts/workspace-summary.py) | Print workspace member/file/domain counts. |
| [`../scripts/repo-map.py`](../scripts/repo-map.py) | Print a compact top-level repository map. |

## Script conventions

1. Keep developer-facing wrappers under `scripts/dev/`.
2. Keep shared shell helpers under `scripts/dev/lib/`.
3. Keep reusable Python utilities under `scripts/`.
4. Avoid one-off root scripts.
5. Avoid hard-coding old root-level crate paths; use the cleaned paths from [`MIGRATION_MAP.md`](MIGRATION_MAP.md).
6. Prefer short scripts that delegate to Cargo or Make targets instead of duplicating logic.
7. Run `make github-ready` before publishing documentation or layout changes.


## Provenance and integrity helpers

| Command | Purpose |
| --- | --- |
| `make source-manifest` | Regenerate `docs/source-manifest.json`. |
| `make verify-source-integrity` | Verify current source files against the committed manifest. |
| `make verify-upstream UPSTREAM=/path/to/agave` | Compare cleaned source files against a local upstream checkout. |
| `make clean-path P=programs/sbf` | Translate an upstream path into the cleaned layout. |
| `make upstream-path P=crates/programs/sbf` | Translate a cleaned path into the upstream layout. |

Windows wrappers are available as `scripts\dev\source-manifest-windows.cmd` and `scripts\dev\verify-source-integrity-windows.cmd`.
