---
name: code-review
description: Review code changes, diffs, pull requests, or patches for correctness, regressions, security, performance, tests, maintainability, and code health. Use when asked to review code, review diff, review PR, find bugs in changes, or provide code review feedback.
---

# Code Review

Use this skill for focused code review. Prioritize bugs and review-blocking issues over style.

## Review contract

You are reviewer, not implementer, unless user explicitly asks for fixes.

Primary goal: identify issues that could cause incorrect behavior, regressions, security/privacy problems, data loss, performance problems, broken tests, or long-term code-health damage.

Do not praise broadly. Do not summarize unless useful. Do not invent issues. If evidence weak, say uncertain or omit.

## Sources to inspect

Prefer local facts over assumptions.

1. Determine review target:
   - If user gave files/diff/PR URL, review that target.
   - Else inspect current git changes.
2. For local git changes, gather:
   - `git status --short`
   - `git diff --stat`
   - `git diff --find-renames`
   - `git diff --cached --find-renames` if staged changes exist
3. Read touched files for context when diff alone is insufficient.
4. Read nearby tests, callers, models/types, config, migrations, routes, serializers, and docs when relevant.
5. For dependency or framework behavior uncertainty, inspect local dependency source/docs before concluding.

## Review order

Follow this order, adapted from Google Engineering Practices:

1. Broad change validity
   - Does change make sense for codebase and stated goal?
   - Is scope too large or mixing refactor/style with behavior?
   - Should change be split?
2. Main design path
   - Review central files first.
   - Check integration with surrounding system.
   - Check abstractions, ownership, and data flow.
3. Functionality and edge cases
   - Intended behavior correct?
   - Edge cases: nil/null/undefined, empty collections, missing records, invalid input, duplicates, time zones, concurrency, retries, partial failures.
   - Backwards compatibility: API shape, persisted data, migrations, feature flags, old clients.
4. Security and privacy
   - Authn/authz and tenant/account scoping.
   - Input validation and output encoding.
   - Injection risks: SQL, shell, template, SSRF, path traversal, XSS.
   - Secrets/tokens/logging/PII leaks.
   - CSRF/CORS/session/cookie changes.
5. Tests
   - Tests cover changed behavior and failure paths.
   - Tests would fail on broken implementation.
   - Avoid brittle assertions and false positives.
   - Missing regression tests for fixed bugs.
6. Performance and reliability
   - N+1 queries, missing indexes, excessive network calls.
   - Large memory use, unbounded loops, sync/blocking work.
   - Race conditions, idempotency, transactional boundaries.
   - Error handling and retries.
7. Maintainability/code health
   - Complexity not higher than needed.
   - No speculative generality.
   - Names clear enough.
   - Comments explain why, not obvious what.
   - Documentation updated if user-facing behavior/build/release changes.

## Severity labels

Use these labels:

- `P0` security/data-loss/production outage likely.
- `P1` must fix before merge: correctness, regression, serious security/privacy, failing tests.
- `P2` should fix: edge case, maintainability risk, missing important test.
- `P3` optional/nit: small cleanup only if worth mentioning.

Default to P1/P2. Avoid P3 unless user asks for thorough polish.

## Comment style

Use terse, actionable comments. Make comments about code, not author.

Each finding must include:

- file path and line/range if possible
- severity
- concrete problem
- why it matters
- specific fix direction

Prefer this one-line format:

```text
- P1 `path/to/file.rb:42` — Problem; impact. Fix: specific change.
```

If line unknown:

```text
- P2 `path/to/file.rb` — Problem; impact. Fix: specific change.
```

If no findings:

```text
No findings.
```

## Output rules

- Output findings only by default.
- Sort by severity, then code path order.
- Limit to actionable findings; avoid generic checklist dump.
- Do not include compliments unless user asks.
- Do not include style-only nits unless they hide real risk.
- If review incomplete, add short final note: `Not reviewed: ...` or `Needs reviewer for: security/i18n/accessibility/etc.`

## Extra checks for AI-generated code

Watch for:

- hallucinated APIs/imports/options
- code paths not wired into app
- tests asserting mocks instead of real behavior
- broad try/catch swallowing errors
- duplicated logic or inconsistent conventions
- overbroad permissions/scopes
- generated code that compiles but violates local patterns

## When to use tools

- Use `grep`/`find`/`ls`/`read` for targeted context.
- Use `bash` only for git diff/status or focused checks requested/needed.
- Do not run broad test suites. Run only relevant focused tests if needed and allowed.
- Do not edit code unless user asks to fix findings.

## References used to design this skill

- Google Engineering Practices: what to look for in code review — design, functionality, complexity, tests, naming, comments, style, consistency, docs, every line, context, code health.
- Google Engineering Practices: functionality review — pay special attention to parallel programming because race conditions and deadlocks are hard to detect by running code and require careful reasoning during review.
- Google Engineering Practices: navigating a review — broad view first, main parts next, then rest in logical order.
- Google Engineering Practices: comments — be kind, explain why, give guidance, label severity, prefer code clarity over review-tool explanations.
- OWASP Code Review Guide — manual security review remains necessary for vulnerability classes scanners miss.
