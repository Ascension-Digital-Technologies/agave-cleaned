# Scripts

This repository intentionally keeps the script surface small. Source code lives in `bin/`, `crates/`, and `tools/`; this folder is only for developer maintenance helpers.

## Primary entry points

| Script | Purpose |
| --- | --- |
| `scripts/dev/bootstrap.sh` | Check that the expected local developer tools are available. |
| `scripts/dev/layout.sh` | Validate the top-level layout and Cargo path dependencies. |
| `scripts/dev/github-ready.sh` | Run lightweight pre-publish repository hygiene checks. |
| `scripts/dev/fmt.sh` | Run Rust formatting checks. |
| `scripts/dev/clippy.sh` | Run clippy for the full workspace. |
| `scripts/dev/test.sh` | Run the workspace test profile through nextest. |
| `scripts/dev/check.sh` | Run the normal local development gate. |
| `scripts/dev/clean-generated.sh` | Remove generated local caches before publishing. |

Windows wrappers are kept beside the Unix scripts:

| Script | Purpose |
| --- | --- |
| `scripts/dev/bootstrap-windows.cmd` | Check basic Windows tooling. |
| `scripts/dev/layout-windows.cmd` | Run layout checks on Windows. |
| `scripts/dev/check-windows.cmd` | Run the lightweight Windows pre-publish gate. |

## Policy

- No legacy CI/release scripts are kept in this cleaned package.
- No infrastructure provisioning scripts are kept in this cleaned package.
- New scripts should be small wrappers with clear output and should live under `scripts/dev/`.
- Prefer `make <target>` for common tasks and direct script execution for debugging.
