# Documentation Hub

This directory contains repository-level documentation for the cleaned Agave workspace.

## Start here

| Document | Purpose |
| --- | --- |
| [`REPO_STRUCTURE.md`](REPO_STRUCTURE.md) | Explains the cleaned top-level layout. |
| [`WORKSPACE_GUIDE.md`](WORKSPACE_GUIDE.md) | Shows where new crates, binary crates, tools, examples, and docs belong. |
| [`MIGRATION_MAP.md`](MIGRATION_MAP.md) | Maps original Agave paths to their cleaned locations. |
| [`DEPENDENCY_BOUNDARIES.md`](DEPENDENCY_BOUNDARIES.md) | Defines intended dependency direction between domains. |
| [`BUILDING.md`](BUILDING.md) | Build, metadata, formatting, clippy, and test guidance. |
| [`SCRIPTS.md`](SCRIPTS.md) | Script catalog and recommended command flows. |
| [`GITHUB_READY.md`](GITHUB_READY.md) | Checklist before pushing this cleaned repo to GitHub. |
| [`NO_CODE_CHANGES.md`](NO_CODE_CHANGES.md) | Explains the no-source-logic-change boundary for this cleanup. |
| [`MAINTAINERS.md`](MAINTAINERS.md) | Maintenance rules for keeping the cleaned layout professional. |
| [`RELEASE_CHECKLIST.md`](RELEASE_CHECKLIST.md) | Practical release/publish checklist for this cleaned package. |
| [`WINDOWS_BUILD.md`](WINDOWS_BUILD.md) | Windows native-build notes retained from the cleanup. |
| [`WINDOWS_CARGO.md`](WINDOWS_CARGO.md) | Windows Cargo fetch/troubleshooting flow. |

## Notes

The top-level `ci/` and `infra/` folders are intentionally not part of this cleaned package. Add automation or provisioning back only when the new repository has a clear policy for owning and testing it.
