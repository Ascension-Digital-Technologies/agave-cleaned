# Security Policy

This repository is an unofficial cleaned and restructured presentation of [Anza Agave](https://github.com/anza-xyz/agave). It is not an official Agave release or official security-response channel.

## Reporting Agave vulnerabilities

Do **not** open a public issue for a potential Agave security vulnerability.

For validator, runtime, SVM, networking, consensus, cryptographic, or protocol-impacting issues, use the official upstream Anza Agave security process:

- Official repository: <https://github.com/anza-xyz/agave>
- Private vulnerability report form: <https://github.com/anza-xyz/agave/security/advisories/new>

Include a clear title, affected component, reproduction details, and proof of concept where appropriate. Avoid posting exploit details publicly.

## Reporting issues in this cleaned repository

Public issues are appropriate for repository-maintenance problems such as:

- broken documentation links,
- incorrect path mappings,
- script portability bugs,
- packaging mistakes,
- source-manifest tooling errors,
- GitHub metadata problems.

Public issues are **not** appropriate for exploitable security details.

## Scope boundary

| Area | Where to report |
| --- | --- |
| Agave validator/runtime/SVM/protocol vulnerability | Official Anza Agave security advisory |
| Mainnet or cluster operational incident | Official Anza/Solana operational channels |
| SPL program issue | Relevant `solana-program` repository/security policy |
| Cleaned-repo documentation/script issue | Issue or PR in this repository |
| Secret accidentally committed to this cleaned repo | Private maintainer contact or private security advisory if available |

## Maintainer handling

If a report to this repository appears security-sensitive:

1. do not ask for more exploit detail in public,
2. move the reporter to the official Anza Agave advisory process when upstream code may be affected,
3. remove public exploit details if necessary,
4. preserve enough non-sensitive context for maintainers to route the issue,
5. update this repository only after the upstream/security path is clear.

## Local security hygiene

Before publishing or tagging this cleaned repository, maintainers should run:

```bash
make github-ready
make verify-source-integrity
```

For source-level changes, also run:

```bash
make full-check
```

Enable GitHub security features when the repository is published:

- Dependabot alerts,
- Dependabot security updates,
- secret scanning,
- push protection,
- CodeQL/code scanning where available.
