# Contributing

Thanks for helping keep this cleaned Agave workspace professional and easy to review.

## First rule

Separate repository-cleanup work from source-behavior work.

- Cleanup-only PRs may touch docs, scripts, metadata, layout notes, and path organization.
- Source-behavior PRs may touch Rust/C/C++/program logic and should include tests or a clear verification plan.
- Mixed PRs should be split whenever possible.

## Local checks

For docs/layout/script cleanup:

```bash
make clean-generated
make github-ready
make metadata
```

For source behavior changes:

```bash
make fmt
make clippy
make test
```

## Layout rules

- User-facing binary crates belong in `bin/`.
- Reusable logic belongs in `crates/<domain>/`.
- On-chain/native program crates belong in `crates/programs/`.
- Developer tools belong in `tools/`.
- Small repository helper scripts belong in `scripts/dev/`.
- Do not reintroduce large unowned CI/release/provisioning folders without a clear maintenance plan.

## Pull request description

Please include:

- What changed.
- Whether source behavior changed.
- Which top-level folders were touched.
- Which local checks were run.
