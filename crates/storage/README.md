# Storage

Ledger, snapshots, BigTable, storage proto, and geyser plugin components.

## Crates

| Path | Role |
| --- | --- |
| `geyser-plugin-interface/` | Workspace crate or crate group in the `storage` domain. |
| `geyser-plugin-manager/` | Workspace crate or crate group in the `storage` domain. |
| `ledger/` | Workspace crate or crate group in the `storage` domain. |
| `snapshots/` | Workspace crate or crate group in the `storage` domain. |
| `storage-bigtable/` | Workspace crate or crate group in the `storage` domain. |
| `storage-proto/` | Workspace crate or crate group in the `storage` domain. |

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
