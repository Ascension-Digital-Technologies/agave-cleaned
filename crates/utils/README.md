# Utilities

Shared low-level helpers. Keep this folder disciplined; prefer a real domain when one exists.

## Crates

| Path | Role |
| --- | --- |
| `bucket-map/` | Workspace crate or crate group in the `utils` domain. |
| `clap-utils/` | Workspace crate or crate group in the `utils` domain. |
| `clap-v3-utils/` | Workspace crate or crate group in the `utils` domain. |
| `cli-config/` | Workspace crate or crate group in the `utils` domain. |
| `cli-output/` | Workspace crate or crate group in the `utils` domain. |
| `cpu-utils/` | Workspace crate or crate group in the `utils` domain. |
| `download-utils/` | Workspace crate or crate group in the `utils` domain. |
| `fs/` | Workspace crate or crate group in the `utils` domain. |
| `logger/` | Workspace crate or crate group in the `utils` domain. |
| `math-utils/` | Workspace crate or crate group in the `utils` domain. |
| `measure/` | Workspace crate or crate group in the `utils` domain. |
| `metrics/` | Workspace crate or crate group in the `utils` domain. |
| `notifier/` | Workspace crate or crate group in the `utils` domain. |
| `perf/` | Workspace crate or crate group in the `utils` domain. |
| `rayon-threadlimit/` | Workspace crate or crate group in the `utils` domain. |

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
