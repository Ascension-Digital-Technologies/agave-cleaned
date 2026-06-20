# Upstream Provenance

This repository is an unofficial cleaned and restructured presentation of the official [Anza Agave](https://github.com/anza-xyz/agave) repository.

It is intended to make the Agave workspace easier to browse, review, and maintain locally while keeping upstream source behavior recognizable. It is not an official Agave release, validator distribution, or protocol fork.

## Source of truth

| Field | Value |
| --- | --- |
| Upstream project | Anza Agave |
| Upstream repository | <https://github.com/anza-xyz/agave> |
| Upstream documentation | <https://docs.anza.xyz/> |
| Official validator/release guidance | Use upstream Anza Agave release documentation |
| Cleaned repository status | Unofficial presentation/restructure |

## Upstream base

The exact upstream commit is not embedded in this archive. Before publishing a tagged release of this cleaned repository, maintainers should record the upstream base here and in `docs/source-manifest.json`.

```text
upstream_repository=https://github.com/anza-xyz/agave
upstream_commit=<fill-before-release>
upstream_tag=<optional>
cleaned_release=<fill-before-release>
```

## What changed at the repository level

This cleaned workspace focuses on repository organization, documentation, scripts, and maintainer ergonomics.

Major layout conventions:

| Upstream-style path | Cleaned path/status |
| --- | --- |
| `apps/` | `bin/` |
| `programs/` | `crates/programs/` |
| root-level crate directories | grouped under `crates/<domain>/` |
| `examples/` | intentionally removed from this package |
| `ci/` | intentionally removed from this package |
| `infra/` | intentionally removed from this package |

See [`docs/MIGRATION_MAP.md`](docs/MIGRATION_MAP.md) for path translation details.

## Source-behavior policy

This repository should not intentionally change validator, runtime, SVM, program, networking, consensus, or cryptographic behavior as part of cleanup work.

Allowed cleanup work:

- documentation updates
- README improvements
- script cleanup
- workspace navigation helpers
- repository metadata
- path updates required by the cleaned layout
- GitHub community/profile files

Source-behavior work should be treated as normal Agave source work and reviewed separately.

## Verification model

This repository includes two complementary verification flows:

1. `make verify-source-integrity` checks current source files against the committed cleaned-repo source manifest.
2. `scripts/dev/verify-upstream.sh <path-to-upstream-agave>` compares cleaned source files against a local upstream checkout using the cleaned path translation rules.

Because this archive does not include an upstream Git commit, upstream comparison requires a maintainer-supplied upstream checkout.
