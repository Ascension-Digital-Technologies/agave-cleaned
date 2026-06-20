# Agave Professional

A GitHub-ready, professionally cleaned and restructured copy of the official [Anza Agave repository](https://github.com/anza-xyz/agave).

Agave is the validator/client implementation maintained by Anza for fast, secure, scalable decentralized applications and marketplaces. This package keeps the upstream Agave codebase recognizable while making the repository easier to browse, review, and maintain.

> [!IMPORTANT]
> This repository is a **cleaned and restructured Agave workspace**. It is not presented as a protocol fork, and this cleanup does not intentionally change validator, runtime, SVM, program, networking, or consensus behavior.

## Upstream Agave

| Resource | Link |
| --- | --- |
| Official repository | <https://github.com/anza-xyz/agave> |
| Anza website | <https://www.anza.xyz/> |
| Agave / Solana docs | <https://docs.anza.xyz/> |
| Public clusters | <https://docs.anza.xyz/clusters> |
| Build-from-source notes | <https://github.com/anza-xyz/agave/blob/master/docs/src/cli/install.md#build-from-source> |

Keep upstream license, security, changelog, and contribution context intact when publishing or modifying this cleaned package.

## What changed

| Area | Result |
| --- | --- |
| Rust binary crates | Moved from `apps/` to `bin/` for a clearer Rust workspace layout. |
| Source crates | Reusable crates remain grouped under `crates/` by domain. |
| Programs | On-chain/native program crates now live under `crates/programs/`. |
| Scripts | Legacy CI/release/provisioning scripts were removed; only small developer scripts remain under `scripts/dev/`. |
| CI, infra, examples | Top-level `ci/`, `infra/`, and `examples/` folders were removed from this cleaned package. |
| Documentation | Added and updated repository guides, build notes, script notes, migration notes, and no-code-change policy. |

## Repository layout

```text
agave-professional/
├── bin/                   # user-facing Rust binary crates
├── crates/                # reusable Rust crates grouped by subsystem
│   ├── accounts/
│   ├── client/
│   ├── consensus/
│   ├── crypto/
│   ├── network/
│   ├── programs/          # on-chain/native program crates and SBF tests
│   ├── rpc/
│   ├── runtime/
│   ├── scheduler/
│   ├── storage/
│   ├── svm/
│   └── utils/
├── tools/                 # developer tools, install tooling, and benchmarks
├── scripts/               # small developer maintenance wrappers
├── docs/                  # repository documentation and migration notes
├── .github/               # GitHub templates and metadata
└── Cargo.toml             # workspace manifest with cleaned member paths
```

Start here:

- [`docs/README.md`](docs/README.md) — documentation hub.
- [`docs/REPO_STRUCTURE.md`](docs/REPO_STRUCTURE.md) — full layout rules.
- [`docs/MIGRATION_MAP.md`](docs/MIGRATION_MAP.md) — original-path to cleaned-path map.
- [`docs/NO_CODE_CHANGES.md`](docs/NO_CODE_CHANGES.md) — source-behavior preservation policy.
- [`scripts/README.md`](scripts/README.md) — script catalog and conventions.

## Quick start

### 1. Install Rust, Cargo, and rustfmt

The workspace pins its Rust version in [`rust-toolchain.toml`](rust-toolchain.toml). With `rustup` installed, Cargo will automatically use or install the pinned toolchain.

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

For Windows setup checks, use:

```cmd
scripts\dev\bootstrap-windows.cmd
```

See [`docs/BUILDING.md`](docs/BUILDING.md) for full Linux, macOS, and Windows notes.

### 3. Check the cleaned layout

```bash
make layout
```

or directly:

```bash
scripts/dev/layout.sh
```

### 4. Build the workspace

```bash
./cargo build
```

> [!NOTE]
> This creates a debug build. As upstream Agave notes, debug builds are not suitable for running a testnet or mainnet validator. For release/testnet/production validator builds, follow the upstream build-from-source guidance linked above.

### 5. Run the lightweight GitHub-readiness gate

```bash
make github-ready
```

This verifies layout, workspace path dependencies, local Markdown links, script permissions, and generated-cache cleanliness.

## Common commands

### Cleaned-repo maintenance commands

| Command | Purpose |
| --- | --- |
| `make help` | Show the primary developer commands. |
| `make bootstrap` | Check local tool availability. |
| `make env` | Print OS, Git, Rust, Cargo, native tool, and workspace diagnostics. |
| `make layout` | Validate the cleaned repository layout, Cargo paths, and workspace summary. |
| `make metadata` | Run `cargo metadata --no-deps` without compiling the full tree. |
| `make build` | Build the workspace with locked dependencies. |
| `make github-ready` | Run a lightweight pre-publish hygiene gate. |
| `make quick-check` | Run GitHub-readiness checks plus Cargo metadata. |
| `make check` | Run the standard local development gate: hygiene, metadata, fmt, and clippy. |
| `make full-check` | Run the full local gate including tests. |
| `make clean-generated` | Remove generated local caches. |
| `make map` | Print a compact top-level repository map. |
| `make summary` | Print Cargo workspace member/file/domain counts. |

### Rust workspace commands

| Command | Purpose |
| --- | --- |
| `./cargo build` | Build the workspace in debug mode. |
| `make fmt` | Run `cargo fmt --all --check`. |
| `make clippy` | Run workspace clippy checks. |
| `make test` | Run the nextest workspace test profile. |
| `./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml` | Direct upstream-style test command. |
| `rustup install nightly` | Install nightly Rust for benchmark support. |
| `cargo +nightly bench` | Run benchmarks using nightly Cargo. |
| `./cargo nightly bench` | Equivalent benchmark command through the checked-in cargo wrapper. |

## Testing

Run the standard cleaned-repo test wrapper:

```bash
make test
```

Or run the upstream-style nextest command directly:

```bash
./cargo nextest run --profile ci --cargo-profile ci --config-file .config/nextest.toml
```

## Benchmarking

Install nightly Rust first:

```bash
rustup install nightly
```

Then run benchmarks:

```bash
cargo +nightly bench
```

or through this repository's cargo wrapper:

```bash
./cargo nightly bench
```

## Local testnet and public clusters

- Local testnet guidance is maintained in the upstream Anza docs: <https://docs.anza.xyz/clusters/benchmark>
- Public cluster information is maintained here: <https://docs.anza.xyz/clusters>
- `devnet` is the stable public development cluster and is accessible through `devnet.solana.com`.

## Release and production notes

- Use [`RELEASE.md`](RELEASE.md) and [`docs/RELEASE_CHECKLIST.md`](docs/RELEASE_CHECKLIST.md) for this cleaned repository's publish/release checklist.
- Use upstream Agave release/build documentation for production validator release guidance.
- Treat changes under `crates/`, `bin/`, and `tools/` as source-level changes that require normal upstream-style review and tests.

## No source behavior changes

This cleanup may move files, rewrite paths in Cargo manifests, remove repository automation folders, and update docs/scripts. It should not alter Rust/C/C++/program source behavior. See [`docs/NO_CODE_CHANGES.md`](docs/NO_CODE_CHANGES.md) for the review boundary.

## Attribution

This repository is based on [Anza Agave](https://github.com/anza-xyz/agave). Keep upstream notices, license terms, security policy, changelog history, and contribution context visible when publishing derived cleanup work.
