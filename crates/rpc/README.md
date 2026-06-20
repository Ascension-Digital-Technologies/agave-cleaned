# RPC

RPC server, RPC clients, pubsub, nonce utilities, test helpers, and send transaction services.

## Crates

| Path | Role |
| --- | --- |
| `pubsub-client/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc-client/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc-client-api/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc-client-nonce-utils/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc-client-types/` | Workspace crate or crate group in the `rpc` domain. |
| `rpc-test/` | Workspace crate or crate group in the `rpc` domain. |
| `send-transaction-service/` | Workspace crate or crate group in the `rpc` domain. |

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
