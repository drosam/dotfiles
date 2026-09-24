---
name: thermos
description: Launches a two-pass thermo-nuclear branch review and synthesizes findings. Use when asked for thermos, thermo review, thermonuclear review, double review, deep branch audit, harsh code review, or combined bug/security and code-quality review.
disable-model-invocation: true
---

# Thermos

Run a two-pass branch audit, then synthesize the result. Optimize for high-signal findings, not volume.

## Scope

1. Determine the review target from the user request, PR URL, current branch, or local changes.
2. Honor the user-supplied base. Otherwise use the repository's documented/default branch if known; fall back to `main` only if it resolves. Ask if the base is ambiguous.
3. Review only changed/added code and changed integration paths.
4. Do not report pre-existing issues in untouched code unless the diff newly exposes or worsens them.
5. Resolve base and HEAD to immutable commits once; pass the same merge-base diff command and commit range to both workers. For local changes, specify staged/unstaged/untracked scope explicitly. Stop before dispatch on invalid refs or empty scope.
6. Review read-only. Do not edit, commit, install, or run side-effecting checks without separate authorization.

## Passes

Run these passes independently. If a task/subagent tool is available, launch both in parallel in the same tool turn; otherwise run both yourself sequentially.

| Pass | Agent, if available | Focus |
| --- | --- | --- |
| Correctness/security | `thermo-nuclear-review-subagent` | bugs, breakage, security/privacy, data loss, devex regressions, feature-gate leaks |
| Code quality | `thermo-nuclear-code-quality-review-subagent` | maintainability, structure, spaghetti growth, 1k-line rule, abstractions, type/boundary cleanliness |

Include this in each subagent task:

```text
Review <exact pinned diff command and commit range>. Scope: <user scope/context>. Read-only; gather your own context. Return prioritized findings with file:line evidence, impact, concrete fix direction, and coverage states: checked, inapplicable, or unchecked (reason). Include counterevidence. Do not report pre-existing untouched-code issues. Do not spawn nested subagents.
```

Check agent availability before dispatch. If specialized agents are missing, give the complete relevant rubric below to a general worker or run sequentially. If workers are denied or fail, do not retry blindly; use permitted direct reads or mark that pass incomplete.

## Correctness/security rubric

Find issues in changed code that can break production, users, developers, data, privacy, or security:

- incorrect behavior, missing wiring, broken old path, bad edge case
- authn/authz, tenant scoping, object ownership, direct object reference
- validation, canonicalization, injection, SSRF, path traversal, XSS, unsafe redirects
- secrets, tokens, PII logs/exposure, telemetry overcollection
- migrations, persisted data, backward compatibility, old clients
- concurrency, idempotency, retries, partial failure, stale data
- devex breakage: changed env names, ports, required manual setup, scripts, secrets lookup
- feature-gate leaks or internal-only behavior becoming user-visible

Rules:

- Trace end-to-end before reporting. Never say “if backend handles this then OK” when backend code is available.
- Check PR/MR discussion only after your own audit and only if you found medium-or-higher issues.
- Validate and dedupe BugBot/human findings; attribute sourced findings when included.
- Calibrate severity honestly. Do not inflate weak issues.

## Code-quality rubric

Be demanding about structure. Flag maintainability regressions that should be fixed before merge:

- a clear “code judo” simplification could delete branches/helpers/modes/layers
- file-size growth makes ownership/navigation materially worse (~1000 lines is an investigation heuristic, not an automatic blocker)
- ad-hoc conditionals or special cases are bolted into unrelated flows
- feature logic leaks into shared/general-purpose layers
- duplicate logic or repeated condition cascades suggest a missing model/helper
- unnecessary wrappers, magic generic handlers, casts, `any`/`unknown`, optionality churn
- consumer-side guards compensate for producer contract failures
- fallback handles impossible/corrupt states instead of making bad states unrepresentable
- related updates are non-atomic or orchestration is needlessly sequential

Prefer fixes that remove concepts, not rearrange mess:

- move logic to canonical owner/layer
- extract focused helper/module/component
- make invariant explicit in type/schema/constructor
- fix producer instead of scattering consumer guards
- delete impossible-state handling
- reuse canonical helper instead of bespoke near-duplicate

## Synthesis

After both passes:

1. Merge only findings with the same root cause and remedy; preserve distinct issues in the same file.
2. Treat corroboration as evidence to investigate, not an automatic severity increase.
3. Resolve disagreements against traced code and counterevidence, not worker vote counts.
4. Findings first; no generic summary unless needed.
5. If one pass failed, synthesize from the other and note the missing perspective.

## Output

Use this format:

```text
- P1 `path:line` — Problem; impact. Fix: concrete direction.
- P2 `path:line` — Problem; impact. Fix: concrete direction.

Coverage: reviewed <target/base>; missing <if any>.
```

Severity:

- `P0` — outage, data loss, exploitable security/privacy issue likely.
- `P1` — must fix before merge.
- `P2` — should fix before/soon after merge.
- `question` — blocking uncertainty after reasonable investigation.

If no findings and both passes completed, output exactly:

```text
No findings.
```

If coverage is incomplete, report `No findings in reviewed scope.` plus the missing pass/check and reason. Never turn a missing worker into a clean audit.
