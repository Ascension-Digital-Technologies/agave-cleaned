# Scheduler

Scheduler bindings, scheduler utilities, unified scheduler logic, and scheduler pools.

## Crates

| Path | Role |
| --- | --- |
| `scheduler-bindings/` | Workspace crate or crate group in the `scheduler` domain. |
| `scheduling-utils/` | Workspace crate or crate group in the `scheduler` domain. |
| `unified-scheduler-logic/` | Workspace crate or crate group in the `scheduler` domain. |
| `unified-scheduler-pool/` | Workspace crate or crate group in the `scheduler` domain. |

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
