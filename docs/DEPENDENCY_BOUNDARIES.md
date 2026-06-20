# Dependency Boundaries

These are the intended dependency boundaries for the cleaned workspace. They are not all enforced by Cargo yet, but they give the repo a professional direction.

## Directional rules

- `bin/` may depend on domain crates, but domain crates should not depend on `bin/`.
- `crates/utils/` should stay low-level and avoid depending on large domain crates.
- `crates/crypto/` should not depend on networking, RPC, storage, or validator binary code.
- `crates/network/` may depend on crypto and utilities, but should avoid runtime/storage coupling unless unavoidable.
- `crates/runtime/` and `crates/svm/` should avoid RPC server dependencies.
- `crates/storage/` may depend on runtime types where needed, but should avoid binary-level validator logic.
- `crates/programs/` should stay isolated from validator/client operational code.

## Cleanup targets

Future hardening should add automated checks for:

1. Binary-to-crate dependency direction.
2. No top-level crate directories.
3. No new path dependencies pointing outside the workspace without an explicit reason.
4. No new references to the removed `apps/`, `ci/`, or `infra/` layouts.
5. No new mega-crates that combine unrelated domains.
