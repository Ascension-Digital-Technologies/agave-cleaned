# Release and Publish Checklist

This checklist is for publishing the cleaned repository, not for changing Agave protocol behavior.

## Before tagging or publishing an archive

- [ ] Review [`README.md`](../README.md).
- [ ] Review [`GITHUB_READY.md`](GITHUB_READY.md).
- [ ] Run `make clean-generated`.
- [ ] Run `make github-ready`.
- [ ] Run `make source-manifest`.
- [ ] Run `make verify-source-integrity`.
- [ ] Run `make metadata`.
- [ ] Confirm `LICENSE`, `SECURITY.md`, `CONTRIBUTING.md`, and `CODEOWNERS` are present.
- [ ] Confirm upstream provenance is recorded in [`UPSTREAM.md`](../UPSTREAM.md).
- [ ] Confirm release steps match [`RELEASE_PROCESS.md`](RELEASE_PROCESS.md).
- [ ] Confirm no local build outputs are included.
- [ ] Confirm no private credentials, tokens, or machine-local paths are included.
- [ ] Generate `SHA256SUMS.txt` for release archives.

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
