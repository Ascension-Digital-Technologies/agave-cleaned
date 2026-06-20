# Release Notes for the Cleaned Package

This repository is a cleaned and restructured Agave source package. It does not include the previous top-level CI/release automation tree.

## Publishing this cleaned repository

Before publishing a GitHub archive or creating a tag:

```bash
make clean-generated
make github-ready
make metadata
```

Run the heavier source checks when source behavior changes:

```bash
make fmt
make clippy
make test
```

## Upstream releases

Agave's upstream project has its own release process, branches, channels, and automation. Use upstream release documentation for official validator releases. This cleaned package should not be treated as an official release pipeline unless new automation is deliberately added and tested.
