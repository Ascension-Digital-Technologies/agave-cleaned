# SVM

SVM execution crates, syscalls, callbacks, timings, logs, and type overrides.

## Crates

| Path | Role |
| --- | --- |
| `svm/` | Workspace crate or crate group in the `svm` domain. |
| `svm-callback/` | Workspace crate or crate group in the `svm` domain. |
| `svm-feature-set/` | Workspace crate or crate group in the `svm` domain. |
| `svm-log-collector/` | Workspace crate or crate group in the `svm` domain. |
| `svm-measure/` | Workspace crate or crate group in the `svm` domain. |
| `svm-timings/` | Workspace crate or crate group in the `svm` domain. |
| `svm-type-overrides/` | Workspace crate or crate group in the `svm` domain. |
| `syscalls/` | Workspace crate or crate group in the `svm` domain. |

## Ownership guidance

- Keep this domain focused; do not add unrelated cross-cutting logic here.
- Prefer explicit domain dependencies over app-level dependencies.
- Avoid introducing cycles between domains.
- If a crate is moved into or out of this folder, update [`../../docs/MIGRATION_MAP.md`](../../docs/MIGRATION_MAP.md).

## Local checks

```bash
make layout
make metadata
```
