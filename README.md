# Agave Professional

[![GitHub Ready](../../actions/workflows/github-ready.yml/badge.svg)](../../actions/workflows/github-ready.yml)
[![Source Integrity](../../actions/workflows/source-integrity.yml/badge.svg)](../../actions/workflows/source-integrity.yml)
[![Rust Metadata](../../actions/workflows/rust-metadata.yml/badge.svg)](../../actions/workflows/rust-metadata.yml)
[![CodeQL](../../actions/workflows/codeql.yml/badge.svg)](../../actions/workflows/codeql.yml)
![Unofficial cleanup](https://img.shields.io/badge/status-unofficial%20cleanup-orange)
![Upstream Agave](https://img.shields.io/badge/upstream-anza--xyz%2Fagave-blue)

A clean, GitHub-ready presentation of the official [Anza Agave](https://github.com/anza-xyz/agave) codebase. This repository was created as an unofficial cleaned-up and restructured repo for easier navigation, review, onboarding, and local maintenance; it is not an official Agave release.

Agave is the validator and client implementation maintained by Anza for the Solana network. This workspace keeps the upstream Agave source recognizable while presenting the project in a cleaner repository layout.

> [!IMPORTANT]
> This repository is a cleaned and restructured Agave workspace. It is not presented as a protocol fork, and it does not intentionally change validator, runtime, SVM, program, networking, or consensus behavior.

## Upstream Agave

| Resource | Link |
| --- | --- |
| Official Agave repository | <https://github.com/anza-xyz/agave> |
| Anza | <https://www.anza.xyz/> |
| Agave / Solana documentation | <https://docs.anza.xyz/> |
| Public cluster information | <https://docs.anza.xyz/clusters> |
| Build from source | <https://github.com/anza-xyz/agave/blob/master/docs/src/cli/install.md#build-from-source> |

Use upstream Agave as the source of truth for protocol behavior, validator operation, release notes, security policy, and network-specific guidance.

## Repository overview

```text
agave-professional/
├── bin/                   # user-facing Rust binary crates
├── crates/                # reusable Rust crates grouped by subsystem
│   ├── accounts/
│   ├── client/
│   ├── consensus/
│   ├── crypto/
│   ├── network/
│   ├── programs/          # on-chain/native program crates and SBF fixtures
│   ├── rpc/
│   ├── runtime/
│   ├── scheduler/
│   ├── storage/
│   ├── svm/
│   └── utils/
├── tools/                 # developer tooling, install tooling, and benchmarks
├── scripts/               # local developer helpers and repository checks
├── docs/                  # build, structure, script, and maintenance guides
├── .github/               # issue templates, PR template, CODEOWNERS, metadata
└── Cargo.toml             # workspace manifest
```

Helpful entry points:

| File | Purpose |
| --- | --- |
| [`docs/README.md`](docs/README.md) | Documentation hub. |
| [`UPSTREAM.md`](UPSTREAM.md) | Upstream provenance and source-of-truth notes. |
| [`docs/UPSTREAM_SYNC.md`](docs/UPSTREAM_SYNC.md) | How to sync from official Agave. |
| [`docs/SOURCE_INTEGRITY.md`](docs/SOURCE_INTEGRITY.md) | Source manifest and verification policy. |
| [`docs/RESTRUCTURE_POLICY.md`](docs/RESTRUCTURE_POLICY.md) | Cleanup/restructure boundaries. |
| [`docs/REPO_STRUCTURE.md`](docs/REPO_STRUCTURE.md) | Repository layout rules. |
| [`docs/WORKSPACE_GUIDE.md`](docs/WORKSPACE_GUIDE.md) | Workspace organization guide. |
| [`docs/MIGRATION_MAP.md`](docs/MIGRATION_MAP.md) | Path map for translating upstream locations into this cleaned layout. |
| [`docs/BUILDING.md`](docs/BUILDING.md) | Build and toolchain notes. |
| [`docs/SCRIPTS.md`](docs/SCRIPTS.md) | Developer script reference. |
| [`docs/NO_CODE_CHANGES.md`](docs/NO_CODE_CHANGES.md) | Source-behavior preservation policy. |
| [`docs/GITHUB_SETTINGS.md`](docs/GITHUB_SETTINGS.md) | Recommended GitHub repository settings. |
| [`docs/RELEASE_PROCESS.md`](docs/RELEASE_PROCESS.md) | Cleaned snapshot release process. |
| [`scripts/README.md`](scripts/README.md) | Script catalog and conventions. |

## Getting started

### 1. Install Rust

The workspace pins its Rust version in [`rust-toolchain.toml`](rust-toolchain.toml). With `rustup` installed, Cargo will automatically select the pinned toolchain.

```bash
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"
rustup component add rustfmt
```

### 2. Install native build dependencies

Ubuntu/Debian:

```bash
sudo apt-get update
sudo apt-get install -y \
  libssl-dev libudev-dev pkg-config zlib1g-dev \
  llvm clang cmake make \
  libprotobuf-dev protobuf-compiler libclang-dev
```

Fedora:

```bash
sudo dnf install -y \
  openssl-devel systemd-devel pkg-config zlib-devel \
  llvm clang cmake make \
  protobuf-devel protobuf-compiler perl-core libclang-dev
```

Windows users can start with the helper wrappers:

```cmd
scripts\dev\bootstrap-windows.cmd
scripts\dev\diagnose-windows-build.cmd
```

For `x86_64-pc-windows-gnu`, install MSYS2/MinGW and use the Windows wrappers so vendored OpenSSL sees MSYS2 Perl instead of native Windows Perl and receives forward-slash MinGW compiler paths. See [`docs/BUILDING.md`](docs/BUILDING.md), [`docs/WINDOWS_BUILD.md`](docs/WINDOWS_BUILD.md), and [`docs/WINDOWS_CARGO.md`](docs/WINDOWS_CARGO.md).

### 3. Inspect the local environment

```bash
make env
```

This prints OS, Git, Rust, Cargo, native tool, and workspace diagnostics.

### 4. Validate the repository layout

```bash
make layout
```

This checks the cleaned top-level layout, Cargo path dependencies, and workspace summary.

### 5. Build the workspace

```bash
./cargo build
```

> [!NOTE]
> Debug builds are useful for development only. For validator release builds, follow the upstream Agave build-from-source guidance.

## Common commands

### Developer workflow

| Command | Purpose |
| --- | --- |
| `make help` | Show available developer commands. |
| `make bootstrap` | Check local tool availability. |
| `make env` | Print environment and workspace diagnostics. |
| `make layout` | Validate cleaned layout and Cargo paths. |
| `make metadata` | Run `cargo metadata --no-deps`. |
| `make build` | Build the workspace with locked dependencies. |
| `make fmt` | Check Rust formatting. |
| `make fmt-fix` | Apply Rust formatting. |
| `make clippy` | Run workspace clippy checks. |
| `make test` | Run nextest or the Cargo test fallback. |
| `make bench` | Run nightly workspace benchmarks. |
| `make github-ready` | Run lightweight pre-publish repository hygiene checks. |
| `make quick-check` | Run hygiene checks plus Cargo metadata. |
| `make check` | Run hygiene, metadata, formatting, and clippy checks. |
| `make full-check` | Run the full local gate including tests. |
| `make clean-generated` | Remove generated local caches. |
| `make map` | Print a compact top-level repository map. |
| `make summary` | Print workspace member, file, and domain counts. |
| `make source-manifest` | Regenerate `docs/source-manifest.json`. |
| `make verify-source-integrity` | Verify source files against the committed manifest. |
| `make verify-upstream UPSTREAM=/path/to/agave` | Compare cleaned source files against a local upstream checkout. |
| `make clean-path P=programs/sbf` | Translate an upstream path into the cleaned layout. |
| `make upstream-path P=crates/programs/sbf` | Translate a cleaned path into the upstream layout. |

### Direct Cargo commands

| Command | Purpose |
| --- | --- |
| `./cargo build` | Build the workspace in debug mode. |
| `./cargo fmt --all -- --check` | Check Rust formatting directly. |
| `./cargo clippy --workspace --all-targets --locked -- -D warnings` | Run direct clippy checks. |
| `./cargo metadata --no-deps` | Inspect workspace metadata without compiling. |
| `./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml` | Run the upstream-style nextest profile. |
| `rustup install nightly` | Install nightly Rust for benchmark support. |
| `cargo +nightly bench` | Run benchmarks with nightly Cargo. |
| `./cargo nightly bench` | Run benchmarks through the checked-in cargo wrapper. |

### Windows wrappers

Windows command wrappers live under [`scripts/dev/`](scripts/dev/). They pause before exiting and prepare the MSYS2/MinGW environment before Cargo runs, which avoids the common vendored OpenSSL `MSWin32` Perl failure and the MSYS shell `C:msys64mingw64bingcc.exe` path-mangling failure on the GNU target.

| Script | Purpose |
| --- | --- |
| `scripts\dev\bootstrap-windows.cmd` | Check required tools and MSYS2 discovery. |
| `scripts\dev\diagnose-windows-build.cmd` | Diagnose Rust, Perl, MinGW, Make, and bindgen setup. |
| `scripts\dev\env-windows.cmd` | Print environment diagnostics. |
| `scripts\dev\layout-windows.cmd` | Validate layout and Cargo paths. |
| `scripts\dev\github-ready-windows.cmd` | Run the lightweight GitHub-readiness gate. |
| `scripts\dev\metadata-windows.cmd` | Run Cargo metadata. |
| `scripts\build.bat` | Build the workspace. |
| `scripts\dev\repair-windows-openssl.cmd` | Clear stale `openssl-sys` build state and rebuild. |
| `scripts\dev\fmt-windows.cmd` | Check Rust formatting. |
| `scripts\dev\fmt-fix-windows.cmd` | Apply Rust formatting. |
| `scripts\dev\clippy-windows.cmd` | Run clippy. |
| `scripts\dev\test-windows.cmd` | Run nextest or Cargo tests. |
| `scripts\dev\quick-check-windows.cmd` | Run the quick local gate. |
| `scripts\dev\check-windows.cmd` | Run the standard local gate. |
| `scripts\dev\full-check-windows.cmd` | Run the full local gate. |
| `scripts\dev\enter-windows-cargo-env.cmd` | Open a shell with the Cargo/MSYS2 environment prepared. |

## Testing

Recommended local test flow:

```bash
make test
```

Direct upstream-style test flow:

```bash
./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml
```

The wrapper will prefer `cargo nextest` when available and fall back to Cargo tests where appropriate.

## Benchmarking

Install nightly Rust:

```bash
rustup install nightly
```

Run benchmarks:

```bash
cargo +nightly bench
```

or use the repository wrapper:

```bash
make bench
```

## Local testnet and public clusters

For validator operation, cluster configuration, and local testnet guidance, use the upstream Anza documentation.

| Topic | Resource |
| --- | --- |
| Public clusters | <https://docs.anza.xyz/clusters> |
| Cluster benchmarking / local testnet guidance | <https://docs.anza.xyz/clusters/benchmark> |
| Agave source and upstream docs | <https://github.com/anza-xyz/agave> |

## Working with upstream paths

This repository uses a cleaned workspace layout. When applying upstream patches, reviewing upstream issues, or comparing files with `anza-xyz/agave`, use [`docs/MIGRATION_MAP.md`](docs/MIGRATION_MAP.md) to translate paths.

General rules:

- User-facing binary crates live in [`bin/`](bin/).
- Reusable Rust crates live in [`crates/`](crates/).
- Program crates and SBF fixtures live in [`crates/programs/`](crates/programs/).
- Developer utilities live in [`tools/`](tools/) and [`scripts/`](scripts/).
- Build, maintenance, and repository policy documentation lives in [`docs/`](docs/).

## Repository hygiene

Before publishing, opening a pull request, or handing off the repo, run:

```bash
make github-ready
make verify-source-integrity
```

For a deeper local pass:

```bash
make full-check
```

The lightweight readiness gate checks layout, local Cargo path dependencies, Markdown links, script permissions, generated-cache cleanliness, and source-manifest integrity. The full gate additionally runs metadata, formatting, clippy, and tests when the required Rust tooling is available.

## Release and production notes

- Use [`RELEASE.md`](RELEASE.md) and [`docs/RELEASE_CHECKLIST.md`](docs/RELEASE_CHECKLIST.md) for cleaned-repository release preparation.
- Use upstream Agave documentation for validator release builds and production operation.
- Treat any source edits under `bin/`, `crates/`, or `tools/` as normal Agave source changes that require review and tests.

## Source behavior policy

This workspace is intended to preserve upstream Agave source behavior. Documentation edits, repository layout changes, script cleanup, and path-maintenance updates are acceptable repository-maintenance work. Validator, runtime, SVM, program, networking, and consensus behavior should not be changed unless the change is intentional, reviewed, and tested.

See [`docs/NO_CODE_CHANGES.md`](docs/NO_CODE_CHANGES.md) for the review boundary.

## Contributing

Start with [`CONTRIBUTING.md`](CONTRIBUTING.md), then run the local gates before submitting changes:

```bash
make github-ready
make check
```

For source-level changes, prefer the full gate:

```bash
make full-check
```

## Security

Security policy and responsible disclosure guidance are kept in [`SECURITY.md`](SECURITY.md). For upstream Agave security context, refer to the official Anza Agave repository.

## Attribution

This repository is based on [Anza Agave](https://github.com/anza-xyz/agave). Keep upstream license terms, notices, security policy, changelog history, and contribution context visible when publishing derived cleanup work.
