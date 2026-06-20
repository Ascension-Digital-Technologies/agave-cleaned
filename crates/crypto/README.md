# Crypto

Hashing, signatures, Merkle structures, precompiles, random sources, and proof helpers.

## Crates

| Path | Role |
| --- | --- |
| `bloom/` | Workspace crate or crate group in the `crypto` domain. |
| `bls-cert-verify/` | Workspace crate or crate group in the `crypto` domain. |
| `bls-sigverify/` | Workspace crate or crate group in the `crypto` domain. |
| `lattice-hash/` | Workspace crate or crate group in the `crypto` domain. |
| `merkle-tree/` | Workspace crate or crate group in the `crypto` domain. |
| `precompiles/` | Workspace crate or crate group in the `crypto` domain. |
| `random/` | Workspace crate or crate group in the `crypto` domain. |

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
