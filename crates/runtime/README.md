# Runtime

Runtime, genesis, features, fees, transactions, compute budget, and program runtime crates.

## Crates

| Path | Role |
| --- | --- |
| `builtins/` | Workspace crate or crate group in the `runtime` domain. |
| `builtins-default-costs/` | Workspace crate or crate group in the `runtime` domain. |
| `compute-budget/` | Workspace crate or crate group in the `runtime` domain. |
| `compute-budget-instruction/` | Workspace crate or crate group in the `runtime` domain. |
| `cost-model/` | Workspace crate or crate group in the `runtime` domain. |
| `entry/` | Workspace crate or crate group in the `runtime` domain. |
| `feature-set/` | Workspace crate or crate group in the `runtime` domain. |
| `fee/` | Workspace crate or crate group in the `runtime` domain. |
| `genesis/` | Workspace crate or crate group in the `runtime` domain. |
| `genesis-utils/` | Workspace crate or crate group in the `runtime` domain. |
| `program-runtime/` | Workspace crate or crate group in the `runtime` domain. |
| `program-test/` | Workspace crate or crate group in the `runtime` domain. |
| `runtime/` | Workspace crate or crate group in the `runtime` domain. |
| `runtime-transaction/` | Workspace crate or crate group in the `runtime` domain. |
| `transaction-context/` | Workspace crate or crate group in the `runtime` domain. |
| `transaction-status/` | Workspace crate or crate group in the `runtime` domain. |
| `transaction-status-client-types/` | Workspace crate or crate group in the `runtime` domain. |
| `transaction-view/` | Workspace crate or crate group in the `runtime` domain. |
| `version/` | Workspace crate or crate group in the `runtime` domain. |

## Ownership guidance

- Keep this domain focused; do not add unrelated cross-cutting logic here.
- Prefer explicit domain dependencies over app-level dependencies.
- Avoid introducing cycles between domains.
- If a crate is moved into or out of this folder, update [`../../docs/MIGRATION_MAP.md`](../../docs/MIGRATION_MAP.md).

## Local checks

```bash
make layout
make metadata
```
