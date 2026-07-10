---
name: thermo-nuclear-review
description: Comprehensive security and correctness audit of branch changes. Use for thermo nuclear review, thermonuclear review, deep diff audit, branch audit, PR audit, bugs, breaking changes, security issues, devex regressions, and feature-gate leaks.
disable-model-invocation: true
---

# Thermo-Nuclear Review

Audit changed code for correctness, security, privacy, data, developer-experience, and release-gating risks. Be rigorous, but do not over-report.

## Scope

- Review only added/modified code and changed integration paths.
- Do not report pre-existing untouched-code issues unless the diff newly exposes or worsens them.
- Default diff base: `main`, unless the caller provides another base.
- Gather your own diff and context: changed files, callers/callees, tests, configs, migrations, routes, jobs, schemas, and docs as relevant.

## What to catch

- Incorrect behavior, missing wiring, broken old path, bad edge case.
- Authn/authz, tenant/account scoping, object ownership, direct object references.
- Validation/canonicalization/output encoding gaps.
- SQL/NoSQL/shell/template injection, SSRF, path traversal, XSS, unsafe redirects.
- Secrets/tokens/keys, PII logging/exposure, overbroad telemetry.
- CSRF/CORS/session/cookie/JWT/OAuth changes.
- File uploads/downloads and dependency/config supply-chain risk.
- Migrations, persisted data, backward compatibility, old clients.
- Concurrency, retries, idempotency, partial failure, stale data.
- Devex breakage: env vars, secrets lookup, ports, required manual setup, scripts, build/run workflow.
- Feature-gate leaks, internal-only behavior becoming user-visible, rollout bypasses.

## Critical rules

- Never present issues with unfinished research. If related code exists, inspect it.
- Do not write “if the backend handles this” when you can check the backend.
- Finish independent audit before reading PR/MR comments.
- If there is a PR/MR and you found medium-or-higher issues, then inspect human/BugBot comments with `gh`/`glab` when available; validate, dedupe, and attribute sourced findings.
- Do not inflate severity. Weak, unproven, or unreachable issues erode trust.
- If the branch intentionally breaks behavior and the blast radius is clearly constrained, do not report it unless the implications seem underweighted or malicious.

## Output

Return prioritized findings only:

```text
- P1 `path:line` — Problem; impact. Fix: concrete direction.
- P2 `path:line` — Problem; impact. Fix: concrete direction.
```

If no findings, output exactly:

```text
No findings.
```

Add one short coverage note only when review was incomplete.
