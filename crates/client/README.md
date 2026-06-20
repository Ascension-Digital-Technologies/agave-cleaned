# Client

Client APIs, wallet integrations, test client helpers, token-facing utilities, and remote-wallet support.

## Crates

| Path | Role |
| --- | --- |
| `client/` | Workspace crate or crate group in the `client` domain. |
| `client-test/` | Workspace crate or crate group in the `client` domain. |
| `remote-wallet/` | Workspace crate or crate group in the `client` domain. |
| `tokens/` | Workspace crate or crate group in the `client` domain. |

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
