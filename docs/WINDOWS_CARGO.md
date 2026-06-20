# Windows Cargo Fetch and Check Guide

This workspace is large enough that the first `cargo check` can fail before compilation if crates.io is slow or the local Cargo cache is empty.

The error below means Cargo resolved the local workspace successfully and then timed out while downloading an external crate:

```text
failed to get `rts-alloc` as a dependency of package `solana-core`
unable to update registry `crates-io`
curl failed
[28] Timeout was reached
```

## Recommended Windows flow

From the repository root, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\cargo-prefetch-windows.ps1 -Check
```

Or from `cmd.exe`:

```bat
scripts\cargo-check-windows-clean-native.cmd
```

Use `scripts\cargo-check-windows.cmd` only for the lighter fetch/check path when native toolchain state is already clean.

This uses:

- Cargo sparse registry protocol
- longer HTTP timeout
- more retries
- disabled HTTP multiplexing, which is often more reliable on Windows/corporate/VPN networks
- `--locked`, so Cargo uses the checked-in `Cargo.lock`

## Manual equivalent

```powershell
$env:CARGO_REGISTRIES_CRATES_IO_PROTOCOL = "sparse"
$env:CARGO_NET_RETRY = "10"
$env:CARGO_HTTP_TIMEOUT = "180"
$env:CARGO_HTTP_LOW_SPEED_LIMIT = "1"
$env:CARGO_HTTP_MULTIPLEXING = "false"
$env:CARGO_NET_GIT_FETCH_WITH_CLI = "true"

cargo fetch --locked
cargo check --locked
```

## If crates.io is still timing out

Try again after the prefetch command. Cargo resumes partial cache state and usually succeeds on a second run.

If the network blocks crates.io entirely, use a local Cargo mirror or run from a network that allows access to the crates.io sparse index and crate downloads.

## Why this is not a cleanup-path failure

A broken workspace move usually fails with an error like `failed to read Cargo.toml` or `No such file or directory` for a local `path = ...` dependency. The `rts-alloc` error is different: Cargo is trying to download a published external crate from crates.io.
