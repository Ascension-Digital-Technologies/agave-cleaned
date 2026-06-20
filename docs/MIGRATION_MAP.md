# Migration Map

This map helps readers find crates after the repository cleanup.

## Major top-level changes

| Original path | Cleaned path/status |
| --- | --- |
| `apps/` | `bin/` |
| `programs/` | `crates/programs/` |
| `examples/` | Removed from this cleaned package. |
| `ci/` | Removed from this cleaned package. |
| `infra/` | Removed from this cleaned package. |

## Binary crates

| Original path | Cleaned path |
| --- | --- |
| `cli` | `bin/cli` |
| `faucet` | `bin/faucet` |
| `faucet-cli` | `bin/faucet-cli` |
| `gossip-cli` | `bin/gossip-cli` |
| `keygen` | `bin/keygen` |
| `test-validator` | `bin/test-validator` |
| `validator` | `bin/validator` |
| `watchtower` | `bin/watchtower` |

## Program crates

| Original path | Cleaned path |
| --- | --- |
| `programs/bpf-loader-tests` | `crates/programs/bpf-loader-tests` |
| `programs/bpf_loader` | `crates/programs/bpf_loader` |
| `programs/compute-budget` | `crates/programs/compute-budget` |
| `programs/compute-budget-bench` | `crates/programs/compute-budget-bench` |
| `programs/ed25519-tests` | `crates/programs/ed25519-tests` |
| `programs/sbf` | `crates/programs/sbf` |
| `programs/system` | `crates/programs/system` |
| `programs/vote` | `crates/programs/vote` |
| `programs/zk-elgamal-proof` | `crates/programs/zk-elgamal-proof` |
| `programs/zk-elgamal-proof-tests` | `crates/programs/zk-elgamal-proof-tests` |
| `programs/zk-token-proof` | `crates/programs/zk-token-proof` |

## Notes

Cargo workspace members and path dependencies were updated to the cleaned paths. Source behavior should remain unchanged; the move is organizational.
