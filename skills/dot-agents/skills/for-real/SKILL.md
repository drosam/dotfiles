---
name: for-real
description: Verifies completed work with a skeptical second pass. Use when the user says "for real", challenges confidence, asks to verify a fix, or wants evidence before declaring work done.
disable-model-invocation: true
---

# For Real

Prove the result. Do not substitute confidence for evidence.

## 1. Establish scope

- Re-read the original request and acceptance criteria.
- Inspect status and the relevant staged, unstaged, or branch diff. Include new files; exclude unrelated WIP from edits.
- Compare requested behavior with delivered behavior. Flag missed requirements, speculative additions, and accidental scope expansion.
- This verification request does not grant new write, dependency-install, production-access, commit, or push permission.

## 2. Challenge the implementation

- Read every changed hunk and the callers/contracts needed to judge it.
- Check empty/error/permission-denied states, retries, partial failure, old data, and changed API boundaries.
- Verify referenced APIs, config keys, imports, and test helpers actually exist.
- Check tests exercise the real changed path and can fail for the reported bug. Reject assertions that merely reproduce the implementation or test mocks against themselves.
- Distinguish pre-existing failures from regressions with evidence, not guesses.

## 3. Run discriminating checks

- Discover repo-native commands. Start with focused tests, typecheck/lint, or build as appropriate; expand when blast radius justifies it.
- Check permission and side effects first. Tests/builds may write files or contact services. Do not start watchers, servers, or live-service checks without authorization.
- For UI changes, exercise the relevant flow when browser access is available and permitted; inspect console/network failures. Otherwise mark manual verification blocked.
- Record exact commands, exit status, and relevant results. A check not run is not a pass.
- If tooling or dependencies are missing, report the blocker. Do not install or silently replace the intended check.

## 4. Repair within authority, then recheck

- If implementation is already authorized, fix only in-scope issues discovered here and rerun affected checks.
- For review-only work or supplied review comments, present findings and wait for the required approval before editing.
- Do not reset/revert unrelated work or commit automatically.
- Re-read the final diff after repairs; stop when acceptance criteria are supported or a concrete blocker prevents further verification.

## Output

- `verified:` behavior and supporting commands/results.
- `fixed:` changes made, if authorized.
- `blocked:` checks not run and why; residual uncertainty.

Example: `verified: timeout regression test fails before the fix and passes after; focused suite 12/12. blocked: browser unavailable; UI flow not exercised.`

If no issues are found, say so without inventing one. Never claim complete verification while a required check remains blocked.
