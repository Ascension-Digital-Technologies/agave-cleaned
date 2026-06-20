# Restructure Policy

This repository is intentionally organized differently from upstream Agave. The goal is easier navigation, not behavioral divergence.

## Stable layout rules

- User-facing binary crates live in `bin/`.
- Reusable crates live in `crates/<domain>/`.
- Program crates and SBF fixtures live in `crates/programs/`.
- Developer utilities live in `tools/` and `scripts/`.
- Repository documentation lives in `docs/`.
- GitHub metadata lives in `.github/`.

The following root folders should not be reintroduced without a clear maintenance reason:

- `apps/`
- `programs/`
- `examples/`
- `ci/`
- `infra/`
- `.buildkite/`

## Review boundary

A restructure-only change may update paths, manifests, docs, and scripts. It should not change runtime behavior.

A source-behavior change may update Agave logic. It should be reviewed and tested as a normal source change.

## Required checks

For layout and documentation work:

```bash
make github-ready
make verify-source-integrity
```

For source behavior work:

```bash
make full-check
```
