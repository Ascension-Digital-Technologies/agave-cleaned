# Crates

Reusable Rust libraries grouped by technical domain. New reusable code should live under the most specific domain folder.

## Contents

| Path | Notes |
| --- | --- |
| `accounts/` | See directory contents and local README if present. |
| `client/` | See directory contents and local README if present. |
| `consensus/` | See directory contents and local README if present. |
| `crypto/` | See directory contents and local README if present. |
| `network/` | See directory contents and local README if present. |
| `crates/programs/` | See directory contents and local README if present. |
| `rpc/` | See directory contents and local README if present. |
| `runtime/` | See directory contents and local README if present. |
| `scheduler/` | See directory contents and local README if present. |
| `storage/` | See directory contents and local README if present. |
| `svm/` | See directory contents and local README if present. |
| `utils/` | See directory contents and local README if present. |

## Rules

- Keep source behavior changes separate from repository cleanup.
- Prefer clear ownership: code should live in the most specific domain that describes it.
- Update [`../docs/MIGRATION_MAP.md`](../docs/MIGRATION_MAP.md) when moving paths.
- Run `make layout` after structural changes.

## Useful commands

```bash
make layout
make metadata
make github-ready
```
