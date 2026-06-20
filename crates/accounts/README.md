# Accounts

Account decoding, account database, banks interfaces, reserved keys, and stake-account support.

## Crates

| Path | Role |
| --- | --- |
| `account-decoder/` | Workspace crate or crate group in the `accounts` domain. |
| `account-decoder-client-types/` | Workspace crate or crate group in the `accounts` domain. |
| `accounts-db/` | Workspace crate or crate group in the `accounts` domain. |
| `banking-stage-ingress-types/` | Workspace crate or crate group in the `accounts` domain. |
| `banks-client/` | Workspace crate or crate group in the `accounts` domain. |
| `banks-interface/` | Workspace crate or crate group in the `accounts` domain. |
| `banks-server/` | Workspace crate or crate group in the `accounts` domain. |
| `reserved-account-keys/` | Workspace crate or crate group in the `accounts` domain. |
| `stake-accounts/` | Workspace crate or crate group in the `accounts` domain. |

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
