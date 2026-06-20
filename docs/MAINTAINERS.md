# Maintainer Guide

This guide keeps the cleaned repository professional over time.

## Maintenance goals

1. Keep the root directory small.
2. Keep `bin/` crates thin and domain logic in `crates/`.
3. Keep reusable crates grouped by subsystem.
4. Keep scripts discoverable and documented.
5. Keep cleanup-only changes separate from source behavior changes.
6. Preserve upstream attribution and license information.

## Adding files

| File type | Preferred location |
| --- | --- |
| User-facing binary crate | `bin/<name>/` |
| Reusable library crate | `crates/<domain>/<name>/` |
| On-chain/native program crate | `crates/programs/<name>/` |
| Developer tool | `tools/<name>/` |
| Benchmark crate | `tools/benchmarks/<name>/` |
| Developer helper script | `scripts/dev/` |
| Repository documentation | `docs/` |

## Pull request expectations

Every pull request should state:

- Whether it changes source behavior.
- Which top-level areas it touches.
- Which local checks were run.
- Whether migration docs need updates.

## Layout drift checks

Run:

```bash
make layout
make github-ready
```

Update [`MIGRATION_MAP.md`](MIGRATION_MAP.md) whenever a path move changes how developers find a crate or tool.
