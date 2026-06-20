# Release and Publish Checklist

This checklist is for publishing the cleaned repository, not for changing Agave protocol behavior.

## Before tagging or publishing an archive

- [ ] Review [`README.md`](../README.md).
- [ ] Review [`GITHUB_READY.md`](GITHUB_READY.md).
- [ ] Run `make clean-generated`.
- [ ] Run `make github-ready`.
- [ ] Run `make metadata`.
- [ ] Confirm `LICENSE`, `SECURITY.md`, `CONTRIBUTING.md`, and `CODEOWNERS` are present.
- [ ] Confirm cleanup summaries are under `docs/history/cleanup/`.
- [ ] Confirm no local build outputs are included.
- [ ] Confirm no private credentials, tokens, or machine-local paths are included.

## If source behavior changed

Also require:

- [ ] `make fmt`
- [ ] `make clippy`
- [ ] `make test`
- [ ] relevant benchmarks
- [ ] clear behavior-change notes in the pull request
- [ ] changelog/release notes if appropriate

## Archive command

From the parent directory:

```bash
zip -r agave-professional-github-ready.zip agave-professional \
  -x 'agave-professional/target/*' \
  -x 'agave-professional/.git/*'
```
