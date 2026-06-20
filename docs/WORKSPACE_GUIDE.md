# Workspace Guide

This repo is normalized into a domain-oriented Rust workspace. The goal is to keep the root small, make ownership obvious, and prevent new crates from being dropped into the top level.

## Root policy

Only repository-level files belong at the root: workspace manifests, license/security/contribution docs, GitHub metadata, and compatibility wrappers such as `./cargo`, `./cargo-build-sbf`, and `./cargo-test-sbf`.

New crates should not be added at the root. Use the following destinations instead:

| Destination | Use for |
| --- | --- |
| `bin/` | User-facing binaries and operational entry points. |
| `crates/accounts/` | Account decoding, account DB, banks interfaces, stake account helpers. |
| `crates/client/` | Client libraries, wallet integrations, token helpers. |
| `crates/consensus/` | Consensus, gossip, PoH, vote, turbine, repair/local-cluster logic. |
| `crates/crypto/` | Signature, hash, merkle, precompile, random, proof helpers. |
| `crates/network/` | QUIC/UDP/TPU/streamer/XDP/TLS/network utility code. |
| `crates/runtime/` | Runtime, genesis, fee, feature, transaction, program runtime code. |
| `crates/rpc/` | RPC servers, clients, pubsub, send transaction service. |
| `crates/scheduler/` | Scheduler bindings, scheduler logic, scheduler pools. |
| `crates/storage/` | Ledger, snapshots, BigTable, storage proto, geyser components. |
| `crates/svm/` | SVM execution, syscalls, timings, callback, type overrides. |
| `crates/utils/` | Small shared utilities with no strong domain home. |
| `crates/programs/` | On-chain/native program crates, SBF test programs, and program binary support. |
| `tools/` | Developer tooling, install tooling, bench-only crates. |
| `scripts/dev/` | Small developer helper scripts. |
| `docs/` | Repository-level documentation. |

## Adding a crate

1. Pick the domain directory first.
2. Add the crate under that domain.
3. Add the new member path to root `Cargo.toml`.
4. Prefer workspace dependencies from `[workspace.dependencies]`.
5. Run `make layout`.

## Compatibility wrappers

The root `cargo`, `cargo-build-sbf`, and `cargo-test-sbf` wrappers remain at the root intentionally because many docs and developer workflows expect them there.
