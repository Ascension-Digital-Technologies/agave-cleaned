# No-Code-Changes Policy

This cleanup is intended to professionalize the repository without changing Agave source behavior.

## What is allowed in cleanup-only work

- README and documentation updates.
- GitHub templates and lightweight hygiene workflows.
- Script wrappers that call existing commands.
- Repository layout documentation.
- Cargo/path-string updates that are required only because files moved.
- Cleanup of generated cache files such as `__pycache__`.
- Moving generated cleanup summaries into an archive directory.

## What is not allowed in cleanup-only work

- Rust logic changes.
- C/C++/header logic changes.
- Consensus behavior changes.
- Runtime behavior changes.
- SVM behavior changes.
- Validator behavior changes.
- Program behavior changes.
- Cargo dependency version changes unless explicitly called out as dependency maintenance.

## Review rule

A pull request should be easy to classify:

| PR type | Should include |
| --- | --- |
| Cleanup-only | Docs, scripts, metadata, layout notes. No source logic changes. |
| Source behavior | Code changes, tests, benchmarks, migration notes, and explicit behavior summary. |
| Mixed | Avoid when possible. Split into separate pull requests. |

## Suggested local verification

```bash
make clean-generated
make github-ready
make metadata
```

For source behavior changes, add:

```bash
make fmt
make clippy
make test
```
