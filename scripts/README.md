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
| `scripts/dev/generate-source-manifest.sh` | Regenerate `docs/source-manifest.json`. |
| `scripts/dev/verify-source-integrity.sh` | Verify source files against the committed manifest. |
| `scripts/dev/verify-upstream.sh` | Compare cleaned source files with a local upstream checkout. |
| `scripts/dev/clean-path.sh` | Translate an upstream path into the cleaned layout. |
| `scripts/dev/upstream-path.sh` | Translate a cleaned path into the upstream layout. |

## Windows wrappers

Windows wrappers pause before exit so double-click or terminal runs do not immediately close. Cargo-taking wrappers also prepare the MSYS2/MinGW environment before running Cargo so vendored OpenSSL resolves MSYS2 Perl instead of native Windows Perl, and so OpenSSL Makefiles receive forward-slash MinGW compiler paths.

| Script | Purpose |
| --- | --- |
| `scripts/dev/bootstrap-windows.cmd` | Windows tool check and next-step guidance. |
| `scripts/dev/diagnose-windows-build.cmd` | Diagnose Windows Rust, Perl, MSYS2, MinGW, and bindgen setup. |
| `scripts/dev/enter-windows-cargo-env.cmd` | Open a prepared Cargo/MSYS2 command shell. |
| `scripts/dev/env-windows.cmd` | Windows environment and workspace diagnostics. |
| `scripts/dev/layout-windows.cmd` | Windows layout/path checks. |
| `scripts/dev/github-ready-windows.cmd` | Windows lightweight pre-publish gate. |
| `scripts/dev/metadata-windows.cmd` | Windows Cargo metadata check. |
| `scripts/build.bat` | Windows workspace build. |
| `scripts/dev/repair-windows-openssl.cmd` | Clear stale `openssl-sys` build state and rebuild. |
| `scripts/dev/fmt-windows.cmd` | Windows formatting check. |
| `scripts/dev/fmt-fix-windows.cmd` | Windows formatting fix. |
| `scripts/dev/clippy-windows.cmd` | Windows clippy check. |
| `scripts/dev/test-windows.cmd` | Windows nextest or cargo-test run. |
| `scripts/dev/bench-windows.cmd` | Windows nightly benchmark command. |
| `scripts/dev/quick-check-windows.cmd` | Windows quick local gate. |
| `scripts/dev/check-windows.cmd` | Windows standard development gate. |
| `scripts/dev/full-check-windows.cmd` | Windows full local gate. |
| `scripts/dev/source-manifest-windows.cmd` | Windows source manifest generation. |
| `scripts/dev/verify-source-integrity-windows.cmd` | Windows source-integrity verification. |

## Utility scripts

| Script | Purpose |
| --- | --- |
| `scripts/audit-repo-layout.py` | Enforce the cleaned root layout. |
| `scripts/check-workspace-paths.py` | Validate all local Cargo path dependencies. |
| `scripts/workspace-summary.py` | Print workspace member/file/domain counts. |
| `scripts/repo-map.py` | Print a compact root map. |
| `scripts/dev/source-manifest.py` | Generate and verify the committed source manifest. |
| `scripts/dev/path-map.py` | Translate paths between upstream and cleaned layouts. |
| `scripts/dev/compare-upstream-source.py` | Compare cleaned source files against a local upstream checkout. |

## Script conventions

- Developer-facing wrappers live under `scripts/dev/`.
- Shared shell helpers live under `scripts/dev/lib/`.
- Python utilities live directly under `scripts/` or under `scripts/dev/` when they are only used by developer gates.
- Avoid one-off root scripts.
- Avoid hard-coding old root-level crate paths; use the cleaned paths from `docs/MIGRATION_MAP.md`.
- Prefer short scripts that delegate to Cargo or Make targets instead of duplicating logic.


## Windows GNU build entrypoint

Use the top-level scripts entrypoint, not a root batch file:

```cmd
scripts\build.bat
```

The build script runs `scripts\setup-windows.ps1`, generates `.cargo\env-windows.ps1` and `.cargo\env-windows.bat`, then builds the workspace. The generated environment uses bare GNU tool names like `gcc`, `g++`, `ar`, `ranlib`, and `mingw32-make` instead of absolute `C:\...` compiler paths so vendored OpenSSL does not get broken by MSYS shell path conversion.
