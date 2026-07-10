---
name: code-review
description: High-signal code review for diffs, pull requests, patches, and AI-generated code. Use when asked to review code, review a diff/PR, find bugs, check a fix, do a pre-merge review, self-review changes, or give actionable review comments. Prioritizes correctness, security, regressions, tests, performance, maintainability, and spec fit over style opinions.
---

# Code Review

Use this skill for high-signal review. Be kind, direct, specific, and evidence-based. Optimize for catching bugs before merge, not for showing how much you noticed.

This skill combines:

- Google-style review standard: improve overall code health, do not demand perfection.
- OWASP-style security review: manually reason about trust boundaries, auth, validation, data exposure, and dangerous sinks.
- Spec/standards review: separate “does it match the request?” from “is the code healthy?”.
- Thermo-style deep review when requested: independent correctness/security and code-quality passes, then synthesize.

## Review contract

You are reviewer, not implementer, unless the user explicitly asks for fixes.

Approve in spirit when the change clearly improves the codebase and follows local conventions. Do not block on personal taste, alternate designs, or perfect-code fantasies. There is no perfect code, only better code.

Block or flag issues that can cause incorrect behavior, regressions, security/privacy problems, data loss, broken tests, performance/reliability problems, or meaningful code-health damage.

Technical facts, repo standards, specs, tests, and framework docs outrank personal preference. If a style point is not documented and local code has precedent, accept the local style.

Do not praise broadly. Do not summarize unless useful. Do not invent issues. If evidence is weak, ask a question or omit.

## Review modes

Infer mode from the user request:

| User asks for | Mode | Output |
| --- | --- | --- |
| “review”, “review PR”, “review diff” | blocking review | findings only |
| “thorough”, “deep”, “audit”, “thermo” | deep review | prioritized findings + brief coverage note |
| “security review” | security-focused review | security/privacy findings first |
| “test review” | test-quality review | missing/brittle/false-positive test findings |
| “spec review”, “does this match ticket/PRD?” | spec review | requirement mismatches and scope creep |
| “standards review”, “style guide review” | standards review | documented-standard violations + important smells |
| “nice comments”, “PR comments”, “pasteable” | inline comment mode | one paste-ready comment per finding |
| “fix it” | implementer mode | switch only after review findings are clear |

Default: blocking review.

## Target discovery

Prefer local facts over assumptions.

1. Determine target:
   - User supplied diff/files/PR URL/patch → review that target.
   - User supplied base/fixed point → review `git diff <base>...HEAD`.
   - No target → inspect current git changes.
2. For local changes, gather:
   - `git status --short`
   - `git diff --stat`
   - `git diff --find-renames`
   - `git diff --cached --find-renames` if staged changes exist
   - `git log <base>..HEAD --oneline` when reviewing a branch against a base
3. If reviewing a PR/MR and tools are available, inspect:
   - PR title/body and linked issue/spec
   - existing human/BugBot comments only after your own first pass, then validate/dedupe
4. If the target is unclear or the diff is empty, ask before reviewing.

## Context discovery

Read enough context to validate each potential finding:

- touched files beyond the diff hunk
- callers/callees and changed interfaces
- nearby tests, fixtures, factories, snapshots
- models/types/schemas/migrations/serialization
- routes/controllers/jobs/workers/queues/config/docs when relevant
- feature flags, rollout paths, old clients, backwards compatibility
- framework/library docs or source when behavior is uncertain

If you cannot understand a changed human-written block after reading context, that itself may be a finding: future maintainers likely cannot understand it either.

## Optional source discovery

When useful, identify these sources before judging:

- **Spec source**: issue, ticket, PRD, design doc, commit message, branch name, or user-provided intent.
- **Standards source**: `CONTRIBUTING`, `CODING_STANDARDS`, architecture docs, ADRs, linters, existing conventions.
- **Security source**: threat model, auth model, tenant/account model, data classification, OWASP-relevant sinks.

If no spec exists, do not invent one. Review against stated intent and changed behavior.

## Deep review orchestration

For “deep”, “thorough”, “audit”, or “thermo” requests, use independent passes. If a task/subagent tool is available, launch parallel agents with self-contained prompts; otherwise do the passes yourself.

Passes:

1. **Correctness/security pass**
   - bugs, regressions, security/privacy, data loss, devex breakage, feature-flag leaks
2. **Code-quality pass**
   - maintainability, architecture, complexity, duplication, file-size growth, spaghetti, abstraction quality
3. Optional **spec/standards pass** when spec or repo standards are available
   - spec fit, missing requirements, scope creep, documented-standard violations

Synthesize after passes:

- Findings first.
- Deduplicate overlap.
- Weight findings found by more than one pass higher.
- Resolve disagreements with your own judgment.
- Note any missing perspective if a pass failed.

Do not spawn nested review agents from a review subagent unless explicitly asked.

## Review algorithm

Use this pass order:

1. **Intent and shape**
   - Does the change match the stated goal/spec?
   - Is it mixing unrelated refactors, formatting, generated files, or behavior?
   - Should risky parts be split?
   - Is now the right time/place to add this functionality?
2. **Central path first**
   - Review main entry points, data flow, ownership, and integration boundaries.
   - Check that new code is wired into the app and old paths still work.
   - Think like the user and like future callers of this API.
3. **Correctness and edge cases**
   - nil/null/undefined, empty collections, missing records, invalid input, duplicates
   - time zones, ordering, pagination, limits, precision/rounding, locale/i18n
   - concurrency, races, deadlocks, retries, idempotency, partial failure, stale data
   - backwards compatibility for APIs, persisted data, migrations, feature flags, old clients
   - UI states: loading, error, empty, disabled, permission-denied, slow network
4. **Security and privacy**
   - authn/authz, tenant/account scoping, object ownership, direct object references
   - validation, canonicalization, output encoding
   - SQL/NoSQL/shell/template injection, SSRF, path traversal, XSS, XXE/deserialization
   - CSRF/CORS/session/cookie/JWT/OAuth changes
   - secrets/tokens/keys, PII logging/exposure, overbroad telemetry
   - unsafe redirects, file uploads/downloads, dependency/config supply-chain risk
   - privilege changes, admin paths, feature flags leaking unreleased behavior
5. **Tests**
   - Covers changed behavior and failure paths.
   - Would fail on the broken implementation.
   - Avoids testing mocks instead of behavior.
   - Includes regression coverage for bug fixes.
   - Covers boundary values, permissions, old data, migrations, and concurrency when relevant.
   - Tests are maintainable code, not brittle snapshots or duplicated implementation.
6. **Performance and reliability**
   - N+1 queries, missing indexes, unbounded queries/loops, large memory use
   - sync/blocking work, excessive network calls, rate limits, timeouts
   - transaction boundaries, locking, consistency, retry storms, backpressure
   - observability: logs/metrics/traces for new failure modes without leaking sensitive data
7. **Maintainability/code health**
   - Minimal necessary complexity; no speculative generality.
   - Names communicate domain intent.
   - Abstractions match local idioms and actual variation points.
   - No duplicated logic, shotgun surgery, feature envy, primitive obsession, or repeated condition cascades.
   - Comments explain why, not obvious what. If review-thread explanation is needed, prefer clearer code or durable comments.
   - File/module size remains navigable; no “god file” growth without reason.
   - User-facing docs/config/release notes updated when behavior changes.

## Spec review rules

When a spec/ticket/PRD exists:

- Map changed behavior to explicit requirements.
- Report missing or partial requirements.
- Report behavior that was not requested and creates risk or scope creep.
- Report implementation that appears to satisfy the requirement but fails an edge case.
- Quote or cite the spec line when possible.
- Do not punish useful small refactors unless they create risk or obscure the functional change.

## Standards review rules

When repo standards exist:

- Cite the standard file/rule for hard violations.
- Repo standards override generic taste.
- If tooling already enforces it, do not waste review output unless the current change bypasses tooling.
- If no standard exists, use local precedent and code-health principles.

Baseline smells worth mentioning only when they affect changed code and matter before merge:

- Mysterious Name
- Duplicated Code
- Feature Envy
- Data Clumps
- Primitive Obsession
- Repeated Switches/Condition Cascades
- Shotgun Surgery
- Divergent Change
- Speculative Generality
- Message Chains
- Middle Man
- Refused Bequest
- Long Function / Large Class / God Module

Label baseline smells as judgement calls unless they have a concrete failure/cost.

## Finding bar

Before outputting any finding, verify all are true:

- It is tied to changed code or a changed integration path.
- It has a concrete failure mode, security risk, test gap, or maintainability cost.
- It is supported by code/context, not a hunch.
- It has a specific fix direction.
- It is worth the author's time before merge.

If any check fails, omit it or ask a `question:`.

## False-positive guardrails

Do not report:

- pre-existing issues in untouched code unless the change newly exposes or worsens them
- style-only nits unless user asked for polish
- alternate valid designs without concrete advantage
- missing tests for behavior not changed
- speculative security issues without a reachable path or dangerous sink
- “could be null” claims without checking types/callers/data constraints
- performance concerns without scale/path evidence
- accessibility/i18n concerns outside scope unless user-facing behavior changed

If you must mention incomplete coverage, use a short final note, not a fake finding.

## Severity labels

Use these labels:

- `P0` — production outage, data loss, exploitable security/privacy issue likely.
- `P1` — must fix before merge: correctness regression, serious security/privacy issue, failing tests, broken migration/API.
- `P2` — should fix: important edge case, missing regression test, reliability/performance risk, maintainability issue likely to hurt soon.
- `P3` — optional nit: tiny cleanup only when user asked for polish.
- `question` — blocking uncertainty that cannot be resolved from available context.

Default to `P1`/`P2`. Avoid `P3` unless requested.

## Comment style

Be concise and humane. Make comments about code, never the author. Explain why when it helps the author fix correctly.

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

If asking for clarification because code is hard to understand, prefer:

```text
- P2 `path/to/file.ts:88` — This branch encodes three states through nested booleans, which makes the new fallback hard to verify and easy to break. Fix: name the states explicitly or split the cases so future readers do not need review-thread context.
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

For deep review output, use:

```text
- P1 `path:line` — Problem; impact. Fix: ...
- P2 `path:line` — Problem; impact. Fix: ...

Coverage: reviewed <diff/base/files>; not reviewed <if any>.
```

For spec/standards two-axis review, use:

```text
## Standards
- ...

## Spec
- ...
```

Do not merge/rerank the two axes unless user asked for a single prioritized verdict.

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
- impressive abstractions that solve no current requirement
- comments that explain broken complexity instead of simplifying code

## Tool rules

- Use `grep`/`find`/`ls`/`read` for targeted context.
- Use `bash` for git inspection and focused checks only.
- Do not run broad test suites unless user asks or risk warrants it.
- Do not edit code unless user asks to fix findings.
- Preserve unrelated worktree changes.
- Review local diffs before making any commit or patch related to this skill.
