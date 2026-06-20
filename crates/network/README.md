# Network

UDP, QUIC, TPU, streamer, TLS, XDP, io_uring, and network utility code.

## Crates

| Path | Role |
| --- | --- |
| `connection-cache/` | Workspace crate or crate group in the `network` domain. |
| `io-uring/` | Workspace crate or crate group in the `network` domain. |
| `net-utils/` | Workspace crate or crate group in the `network` domain. |
| `quic-client/` | Workspace crate or crate group in the `network` domain. |
| `streamer/` | Workspace crate or crate group in the `network` domain. |
| `tls-utils/` | Workspace crate or crate group in the `network` domain. |
| `tpu-client/` | Workspace crate or crate group in the `network` domain. |
| `tpu-client-next/` | Workspace crate or crate group in the `network` domain. |
| `udp-client/` | Workspace crate or crate group in the `network` domain. |
| `xdp/` | Workspace crate or crate group in the `network` domain. |
| `xdp-ebpf/` | Workspace crate or crate group in the `network` domain. |

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
