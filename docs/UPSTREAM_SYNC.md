# Upstream Sync Guide

This guide describes how to update the cleaned repository from the official Anza Agave repository while preserving the cleanup boundary.

## Goals

- Keep upstream Agave source behavior recognizable.
- Keep repository organization clean and predictable.
- Separate upstream source imports from local presentation/documentation changes.
- Make every sync auditable.

## Recommended workflow

1. Clone or fetch upstream Agave.

   ```bash
   git clone https://github.com/anza-xyz/agave upstream-agave
   ```

2. Record the upstream commit.

   ```bash
   cd upstream-agave
   git rev-parse HEAD
   ```

3. Apply upstream source updates into the cleaned layout.

   Use [`docs/MIGRATION_MAP.md`](MIGRATION_MAP.md) and the path helpers:

   ```bash
   scripts/dev/path-map.py --from-upstream programs/sbf
   scripts/dev/path-map.py --from-clean crates/programs/sbf
   ```

4. Run the local gates.

   ```bash
   make clean-generated
   make github-ready
   make metadata
   ```

5. Regenerate and verify the source manifest.

   ```bash
   make source-manifest
   make verify-source-integrity
   ```

6. Compare against the upstream checkout when possible.

   ```bash
   scripts/dev/verify-upstream.sh ../upstream-agave
   ```

7. Update provenance.

   Update [`UPSTREAM.md`](../UPSTREAM.md) with the upstream commit/tag and summarize the sync in the release notes.

## PR discipline

Prefer separate pull requests for:

- upstream source imports,
- path-maintenance updates,
- documentation polish,
- script/tooling changes.

Mixed PRs are harder to review and make the “no unintended source behavior change” claim weaker.
