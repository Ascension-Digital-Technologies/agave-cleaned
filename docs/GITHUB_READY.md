# GitHub Readiness Checklist

Use this checklist before pushing the cleaned repository to GitHub or cutting a public archive.

## Required before publishing

- [ ] Confirm the repository name and description are accurate.
- [ ] Keep upstream license and attribution files in place.
- [ ] Review [`README.md`](../README.md) for project positioning.
- [ ] Run `make github-ready`.
- [ ] Run `make verify-source-integrity`.
- [ ] Run `make metadata` in a Rust environment.
- [ ] Remove generated local files with `make clean-generated`.
- [ ] Check that no source-code logic changes are mixed into repository-cleanup work.
- [ ] Review [`UPSTREAM.md`](../UPSTREAM.md) and record the upstream commit before public release.
- [ ] Review [`docs/source-manifest.json`](source-manifest.json).
- [ ] Confirm GitHub issue and pull request templates match how the repository will be used.

## Automation

The cleaned archive intentionally does **not** include previous top-level CI/release/provisioning trees such as `ci/`, `infra/`, or `.buildkite/`. Lightweight GitHub Actions live under `.github/workflows/` and are limited to repository hygiene, source integrity, metadata, and code scanning.

## Recommended for source changes

If a future pull request changes Rust/C/C++/program logic, also run:

```bash
make fmt
make clippy
make test
```

Large full-workspace checks may take a long time. Keep docs-only and layout-only pull requests separate from source behavior pull requests.
