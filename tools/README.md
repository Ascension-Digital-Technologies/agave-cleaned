# Tools

Developer tools, release/install helpers, benchmark crates, and utility binaries.

## Contents

| Path | Notes |
| --- | --- |
| `benchmarks/` | See directory contents and local README if present. |
| `dev-bins/` | See directory contents and local README if present. |
| `install/` | See directory contents and local README if present. |
| `ledger-tool/` | See directory contents and local README if present. |
| `rbpf-cli/` | See directory contents and local README if present. |

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
