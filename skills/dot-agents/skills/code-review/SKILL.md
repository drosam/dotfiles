---
name: code-review
description: High-signal code review for diffs, pull requests, patches, and AI-generated code. Use when asked to review code, review a diff/PR, find bugs, check a fix, do a pre-merge review, self-review changes, or give actionable review comments. Prioritizes correctness, security, regressions, tests, performance, and code health over style opinions.
---

# Code Review

Use this skill for high-signal review. Be kind, direct, specific, and evidence-based. Optimize for catching bugs before merge, not for showing how much you noticed.

## Review contract

You are reviewer, not implementer, unless the user explicitly asks for fixes.

Approve in spirit when the change clearly improves the codebase and follows local conventions. Do not block on personal taste, alternate designs, or perfect-code fantasies.

Block or flag issues that can cause incorrect behavior, regressions, security/privacy problems, data loss, broken tests, performance/reliability problems, or meaningful code-health damage.

Do not praise broadly. Do not summarize unless useful. Do not invent issues. If evidence is weak, ask a question or omit.

## Review modes

Infer mode from the user request:

| User asks for | Mode | Output |
| --- | --- | --- |
| "review", "review PR", "review diff" | blocking review | findings only |
| "thorough", "deep", "audit" | deep review | findings + brief coverage note |
| "security review" | security-focused review | security/privacy findings first |
| "test review" | test-quality review | missing/brittle/false-positive test findings |
| "nice comments", "PR comments", "pasteable" | inline comment mode | one paste-ready comment per finding |
| "fix it" | implementer mode | switch only after review findings are clear |

Default: blocking review.

## Target discovery

Prefer local facts over assumptions.

1. Determine target:
   - User supplied diff/files/PR URL/patch → review that target.
   - No target → inspect current git changes.
2. For local changes, gather:
   - `git status --short`
   - `git diff --stat`
   - `git diff --find-renames`
   - `git diff --cached --find-renames` if staged changes exist
3. Read enough context to validate each potential finding:
   - touched files beyond the diff hunk
   - callers/callees and changed interfaces
   - nearby tests and fixtures
   - models/types/schemas/migrations
   - routes/controllers/jobs/serializers/config/docs when relevant
4. Inspect dependency/framework source or local docs when behavior is uncertain.
5. Run focused tests or static checks only when useful and safe; report exact command and result if used.

## Review algorithm

Use this pass order:

1. **Intent and shape**
   - Does the change match the stated goal?
   - Is it mixing unrelated refactors, formatting, generated files, or behavior?
   - Should risky parts be split?
2. **Central path first**
   - Review main entry points, data flow, ownership, and integration boundaries.
   - Check that new code is wired into the app and old paths still work.
3. **Correctness and edge cases**
   - nil/null/undefined, empty collections, missing records, invalid input, duplicates
   - time zones, ordering, pagination, limits, precision/rounding
   - concurrency, retries, idempotency, partial failure, stale data
   - backwards compatibility for APIs, persisted data, migrations, feature flags, old clients
4. **Security and privacy**
   - authn/authz, tenant/account scoping, object ownership
   - validation, output encoding, SQL/shell/template injection, SSRF, path traversal, XSS
   - secrets/tokens, PII logging/exposure, CSRF/CORS/session/cookie changes
5. **Tests**
   - Covers changed behavior and failure paths.
   - Would fail on the broken implementation.
   - Avoids testing mocks instead of behavior.
   - Includes regression coverage for bug fixes.
6. **Performance and reliability**
   - N+1 queries, missing indexes, unbounded queries/loops, large memory use
   - sync/blocking work, excessive network calls, rate limits, timeouts
   - transaction boundaries, error handling, retries, observability
7. **Maintainability/code health**
   - Minimal necessary complexity.
   - No speculative generality or duplicated logic.
   - Names and abstractions match local idioms.
   - Comments explain why, not obvious what.
   - User-facing docs/config/release notes updated when behavior changes.

## Finding bar

Before outputting any finding, verify all are true:

- It is tied to changed code or a changed integration path.
- It has a concrete failure mode, security risk, test gap, or maintainability cost.
- It is supported by code/context, not a hunch.
- It has a specific fix direction.
- It is worth the author's time before merge.

If any check fails, omit it or ask a `question:`.

## Severity labels

Use these labels:

- `P0` — production outage, data loss, exploitable security/privacy issue likely.
- `P1` — must fix before merge: correctness regression, serious security/privacy issue, failing tests, broken migration/API.
- `P2` — should fix: important edge case, missing regression test, reliability/performance risk, maintainability issue likely to hurt soon.
- `P3` — optional nit: tiny cleanup only when user asked for polish.
- `question` — blocking uncertainty that cannot be resolved from available context.

Default to `P1`/`P2`. Avoid `P3` unless requested.

## Comment style

Be concise and humane. Make comments about code, never the author.

Use this default one-line format:

```text
- P1 `path/to/file.rb:42` — Problem; impact. Fix: specific change.
```

If line is unknown:

```text
- P2 `path/to/file.rb` — Problem; impact. Fix: specific change.
```

For inline/pasteable mode:

```text
P1: This accepts any account ID from params, so a user can read another tenant's record. Scope the lookup through `current_account.records.find(...)`.
```

For genuine uncertainty:

```text
- question `path/to/file.rb:42` — Does this path run for guest users? If yes, the new lookup can bypass tenant scoping.
```

## Output rules

- Output findings only by default.
- Sort by severity, then code path order.
- Include no more than the strongest actionable findings unless user asks for exhaustive review.
- Do not include a generic checklist dump.
- Do not include compliments unless user asks for a nicer PR-ready tone.
- Do not include style-only nits unless they hide real risk.
- If no findings, output exactly: `No findings.`
- If incomplete, add one final short note: `Not reviewed: ...` or `Needs reviewer for: security/i18n/accessibility/etc.`

## AI-generated code checks

Be extra skeptical of:

- hallucinated APIs/imports/options
- code paths not wired into app
- tests asserting mocks instead of real behavior
- broad rescue/try-catch that swallows errors
- duplicated logic or inconsistent conventions
- overbroad permissions/scopes
- fake migrations/config/docs that look plausible but do nothing
- green tests caused by skipped paths, bad fixtures, or weak assertions

## Tool rules

- Use `grep`/`find`/`ls`/`read` for targeted context.
- Use `bash` for git inspection and focused checks only.
- Do not run broad test suites unless user asks or risk warrants it.
- Do not edit code unless user asks to fix findings.
- Preserve unrelated worktree changes.
