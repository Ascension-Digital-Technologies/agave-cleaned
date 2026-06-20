# Programs

On-chain/native program crates, SBF program fixtures, program-specific tests, and reusable program binary support now live here under the main `crates/` tree.

This folder replaces the former top-level `programs/` directory so the repository has a smaller root and a more idiomatic Rust workspace shape.

## Contents

| Path | Notes |
| --- | --- |
| `bpf-loader-tests/` | BPF loader test crate. |
| `bpf_loader/` | BPF loader program crate. |
| `compute-budget/` | Compute budget program crate. |
| `compute-budget-bench/` | Compute budget benchmarks. |
| `ed25519-tests/` | Ed25519 program tests. |
| `program-binaries/` | Prebuilt SPL/Core BPF program binary support. |
| `sbf/` | SBF program fixtures and tests. |
| `system/` | System program crate. |
| `vote/` | Vote program crate. |
| `zk-elgamal-proof/` | ZK ElGamal proof program crate. |
| `zk-elgamal-proof-tests/` | ZK ElGamal proof tests. |
| `zk-token-proof/` | ZK token proof program crate. |

## Rules

- Keep source behavior changes separate from repository cleanup.
- Keep program crates isolated from binary entry-point code.
- Update [`../../docs/MIGRATION_MAP.md`](../../docs/MIGRATION_MAP.md) when moving paths.
- Run `make layout` after structural changes.

## Useful commands

```bash
make layout
make metadata
make github-ready
```
