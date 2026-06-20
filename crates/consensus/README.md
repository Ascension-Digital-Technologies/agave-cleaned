# Consensus

Consensus, gossip, PoH, vote, turbine, repair, local-cluster, and validator-core logic.

## Crates

| Path | Role |
| --- | --- |
| `core/` | Workspace crate or crate group in the `consensus` domain. |
| `gossip/` | Workspace crate or crate group in the `consensus` domain. |
| `leader-schedule/` | Workspace crate or crate group in the `consensus` domain. |
| `local-cluster/` | Workspace crate or crate group in the `consensus` domain. |
| `poh/` | Workspace crate or crate group in the `consensus` domain. |
| `turbine/` | Workspace crate or crate group in the `consensus` domain. |
| `vote/` | Workspace crate or crate group in the `consensus` domain. |
| `votor/` | Workspace crate or crate group in the `consensus` domain. |
| `votor-messages/` | Workspace crate or crate group in the `consensus` domain. |

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
