# Bin

This folder contains the workspace binary crates: command-line tools, validators, local test nodes, and other user-facing entry points.

These crates should stay thin. Shared runtime, networking, storage, RPC, SVM, consensus, and utility logic should live under `crates/`, while on-chain/native program code should live under `crates/programs/`.

## Current binary crates

- `cli/`
- `faucet/`
- `faucet-cli/`
- `gossip-cli/`
- `keygen/`
- `test-validator/`
- `validator/`
- `watchtower/`
