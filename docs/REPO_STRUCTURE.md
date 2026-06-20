# Professional Repository Structure

This cleanup turns the original flatter Agave workspace into a clearer Rust repository layout with a small root and domain-owned crate folders.

```text
agave-professional/
├── bin/                   # user-facing binaries: validator, CLI, faucet, keygen, watchtower
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
├── tools/                 # benches, install helpers, developer binaries
├── scripts/               # small repo maintenance scripts
├── docs/                  # project documentation and migration notes
├── .github/               # GitHub issue/PR templates and metadata
└── Cargo.toml             # workspace manifest with updated member paths
```

## Rules for adding new code

1. **Binary crates stay thin.** Put reusable logic under `crates/`, not inside `bin/` crates.
2. **Crates must have a domain.** Avoid adding new top-level crate folders.
3. **Utilities stay small.** `crates/utils` is for genuinely shared low-level helpers only.
4. **Programs stay isolated.** On-chain/native program crates live under `crates/programs/`.
5. **Scripts stay minimal.** Developer wrappers belong under `scripts/dev/`; do not reintroduce large unowned automation trees casually.

## Removed from this cleaned package

- `apps/` was renamed to `bin/`.
- `programs/` was folded into `crates/programs/`.
- `examples/` was removed.
- `ci/` was removed.
- `infra/` was removed.
- Buildkite/GitHub workflow scripts that depended on deleted CI assets were removed.
