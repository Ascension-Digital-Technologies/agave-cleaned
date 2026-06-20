# Building and Checking

This document gives a practical path for working with the cleaned workspace. It does not replace upstream Agave build documentation; it focuses on this repository layout and the helper scripts included here.

## Toolchain

The workspace pins Rust in [`../rust-toolchain.toml`](../rust-toolchain.toml). Cargo will install the pinned toolchain automatically when `rustup` is available.

Recommended baseline tools:

- `rustup`, `rustc`, and `cargo`
- `rustfmt`
- `clang` / LLVM tooling
- `cmake`
- `protobuf-compiler`
- `pkg-config`
- OpenSSL development headers
- zlib development headers

## Linux dependencies

Ubuntu/Debian:

```bash
sudo apt-get update
sudo apt-get install -y \
  build-essential clang cmake llvm libclang-dev \
  libprotobuf-dev protobuf-compiler \
  libssl-dev libudev-dev pkg-config zlib1g-dev
```

Fedora:

```bash
sudo dnf install -y \
  clang cmake llvm libclang-devel \
  protobuf-devel protobuf-compiler \
  openssl-devel systemd-devel pkg-config zlib-devel perl-core make
```

## Windows notes

Windows builds are heavier because large dependency fetches and native OpenSSL/protobuf setup can fail on first run.

Recommended first commands:

```cmd
scripts\dev\bootstrap-windows.cmd
scripts\dev\diagnose-windows-build.cmd
scripts\dev\layout-windows.cmd
scripts\dev\check-windows.cmd
```

For the GNU Windows target, use the `scripts\dev\*-windows.cmd` wrappers instead of plain Cargo commands. They prepare MSYS2/MinGW paths so vendored OpenSSL resolves MSYS2 Perl, not native Windows Perl, and so OpenSSL Makefiles receive `C:/...` compiler paths instead of backslash paths. If an earlier build failed inside `openssl-sys`, run `scripts\dev\repair-windows-openssl.cmd` once to clear the stale OpenSSL build directory and retry.

Additional Windows docs:

- [`WINDOWS_CARGO.md`](WINDOWS_CARGO.md)
- [`WINDOWS_BUILD.md`](WINDOWS_BUILD.md)


## Upstream Agave command reference

The official Agave README documents the same core flow this cleaned repository should preserve:

```bash
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"
rustup component add rustfmt
./cargo build
./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml
rustup install nightly
cargo +nightly bench
```

For production validator builds, follow the upstream build-from-source documentation rather than relying on a debug `./cargo build` output:

```text
https://github.com/anza-xyz/agave/blob/master/docs/src/cli/install.md#build-from-source
```

## Lightweight checks

These are safe to run before committing docs, scripts, or layout work:

```bash
make layout
make metadata
make github-ready
```

Useful script equivalents:

```bash
scripts/dev/env.sh
scripts/dev/layout.sh
scripts/dev/github-ready.sh
scripts/dev/quick-check.sh
```

For Windows CMD:

```cmd
scripts\dev\env-windows.cmd
scripts\dev\layout-windows.cmd
scripts\dev\github-ready-windows.cmd
scripts\dev\quick-check-windows.cmd
```

## Formatting

```bash
make fmt
```

or:

```bash
scripts/dev/fmt.sh
```

## Clippy

```bash
make clippy
```

or:

```bash
scripts/dev/clippy.sh
```

## Tests

```bash
make test
```

or:

```bash
scripts/dev/test.sh
```

This uses the checked-in nextest profile:

```text
.config/nextest.toml
```

## Full local pre-publish flow

For a fast no-compile pass:

```bash
make quick-check
```

For the standard developer gate:

```bash
make check
```

For the fullest local gate, including tests:

```bash
make full-check
```

Equivalent direct scripts:

```bash
scripts/dev/quick-check.sh
scripts/dev/check.sh
scripts/dev/full-check.sh
```

For source-level changes, also run:

```bash
make fmt
make clippy
make test
```

## Notes for this cleaned repository

The restructuring changed paths, not intended behavior. If a script or doc still references an original root-level crate path, update that reference and record the mapping in [`MIGRATION_MAP.md`](MIGRATION_MAP.md) when appropriate.


## Source integrity commands

Use these commands before publishing a cleaned snapshot or after applying upstream source updates:

```bash
make source-manifest
make verify-source-integrity
```

To compare with a local upstream Agave checkout:

```bash
make verify-upstream UPSTREAM=/path/to/anza-agave
```


## Windows GNU jemalloc note

For Windows GNU builds, see [`WINDOWS_GNU_BUILD_PATCH.md`](WINDOWS_GNU_BUILD_PATCH.md).
