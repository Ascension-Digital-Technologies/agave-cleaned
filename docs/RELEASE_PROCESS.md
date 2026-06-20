# Release Process

This process is for publishing cleaned repository snapshots. It is not the official Agave validator release process.

## Release naming

Recommended tag format:

```text
clean-v<cleaned-version>-agave-<upstream-short-sha>
```

Example:

```text
clean-v1.0.0-agave-abc1234
```

## Pre-release checklist

1. Confirm the upstream base.

   ```bash
   git -C /path/to/upstream-agave rev-parse HEAD
   ```

2. Update [`UPSTREAM.md`](../UPSTREAM.md).

3. Run repository hygiene checks.

   ```bash
   make clean-generated
   make github-ready
   ```

4. Run source integrity checks.

   ```bash
   make source-manifest
   make verify-source-integrity
   ```

5. Compare against upstream when possible.

   ```bash
   scripts/dev/verify-upstream.sh /path/to/upstream-agave
   ```

6. Run Cargo checks where toolchain support is available.

   ```bash
   make metadata
   make check
   ```

7. Package the release archive.

8. Generate checksums.

   ```bash
   sha256sum agave-professional-clean-*.zip > SHA256SUMS.txt
   ```

## Release artifacts

Recommended artifacts:

```text
agave-professional-clean-<version>.zip
SHA256SUMS.txt
docs/source-manifest.json
```

## Release notes

Release notes should include:

- upstream repository,
- upstream commit/tag,
- cleaned repository version,
- source-integrity status,
- whether source behavior changed,
- layout/documentation/script changes,
- checks run.

## Post-release

After publishing:

- confirm README links render correctly,
- confirm workflow badges resolve,
- confirm release artifacts download correctly,
- confirm `docs/source-manifest.json` is attached or present in the tag.
