# GitHub Settings

Recommended repository settings for publishing this cleaned Agave workspace.

## Repository basics

| Setting | Recommendation |
| --- | --- |
| Default branch | `main` |
| Issues | Enabled for cleanup/docs/tooling issues only |
| Discussions | Optional |
| Wiki | Disabled unless maintained |
| Projects | Optional |
| Releases | Enabled |
| Packages | Disabled unless needed |

## Branch protection / rulesets

Recommended protections for `main`:

- require pull request before merge,
- require at least one approving review,
- dismiss stale approvals after new commits,
- require conversation resolution,
- require status checks that are expected to pass,
- block force pushes,
- block branch deletion,
- restrict bypass permissions to trusted maintainers.

Suggested required checks once workflows are enabled:

- `GitHub Ready`
- `Source Integrity`
- `Rust Metadata`

## Security settings

Enable:

- Dependabot alerts,
- Dependabot security updates,
- secret scanning,
- push protection,
- CodeQL/code scanning if available for the repository plan and language set.

## Labels

Suggested labels:

| Label | Purpose |
| --- | --- |
| `cleanup` | Repository cleanup only. |
| `docs` | Documentation updates. |
| `scripts` | Developer script/tooling updates. |
| `upstream-sync` | Sync from official Anza Agave. |
| `source-behavior` | Source behavior changed; requires deeper review. |
| `path-maintenance` | Cargo/path/layout maintenance. |
| `security` | Security process or advisory coordination. |

## Release naming

Use tags that identify both the cleaned package and upstream source base:

```text
clean-v1.0.0-agave-<upstream-short-sha>
```

Do not publish a release as an official Agave validator release.
