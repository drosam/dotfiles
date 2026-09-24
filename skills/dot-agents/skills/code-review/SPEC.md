# Code Review Contract

## Intent and scope

Primary automated, exhaustive review of a defined change and affected paths, or an explicitly requested whole-file audit (including existing defects in that scope). No later human review is assumed. Completeness means explicit coverage, not proof that no defects exist.

Default includes correctness, edge cases, security/privacy, data/rollout compatibility, tests, reliability/performance, maintainability, scoped rules, relevant documentation, and recent merged/deployed patterns. Narrow user-requested modes remain possible but cannot grant whole-change readiness.

## Inputs and outputs

Inputs: pinned target/base/head or stable local-change inventory; relevant requirements/rules/docs; callers/tests; recent history; deployment evidence when applicable; permitted validation tools/results.

Outputs: all distinct actionable findings with trigger, evidence, impact, location, blocking status, fix direction and regression check; coverage/evidence ledger; BLOCKED, INCOMPLETE or READY verdict. Unconfirmed hypotheses are gaps, not established findings.

## Safety and evidence invariants

- No application edits, comment publication, PR approval, merge, deploy, installs or permission bypass implied by review.
- No worktree checkout/reset/stash for history inspection; unrelated WIP preserved.
- No production execution or private content in public research queries.
- Every factual claim must be confirmed by inspected evidence; static reasoning is not misrepresented as a runtime reproduction.
- Recent, merged, built, released and currently deployed are distinct states. Confirm environment/revision/current deployment evidence or label unverified.
- Repository facts and documentation are inspected for relevance/version; historical code is not automatically correct.
- Uncompleted required passes after worker failure/fallback, truncated input, stale CI, unstable worktree and critical unknowns cannot become clean readiness.
- Missing tests, many callers, or agent agreement do not automatically increase technical severity.

## Acceptance checks

1. Default review covers all changed lines/artifacts and all applicable dimensions, without a top-N finding cap.
2. Input-dependent failures receive concrete scenarios; counterevidence and safe patterns suppress false positives.
3. Applicable rules and relevant documentation are read; both compliance and newly stale documentation are checked.
4. Recent analogous implementations and removed protections are traced through history; pattern judgments cite evidence.
5. Live compatibility, rolling versions, migrations and rollback are checked when relevant; unknown deployment is not relabeled as confirmed.
6. Independent passes have sequential fallback; all applicable mandatory repo/spec/CI gates are inventoried with matching-revision evidence. Blocked required checks produce INCOMPLETE unless a proven blocker already produces BLOCKED.
7. P0/P1 and mandatory requirement failures block. Other findings declare blocking status and rationale.
8. No-findings output still includes evidence, gaps and a scoped verdict. READY is not merge/deploy authority.
9. Every adopted external idea preserves local permissions; no new required dependency or provider-specific agent.
10. Default review and “thermos” requests use the same four passes, not an additional two-pass audit. General workers cover behavior and tests; optional existing thermo specialists cover security/data/rollout and rules/docs/patterns/code health. Each receives the full assigned rubric and identical pinned scope.
11. Workers do not dispatch nested reviews or substitute `main`/current HEAD for the supplied scope. Unavailable skill reads use the supplied contract/rubric; missing both prevents complete coverage.
12. Devex/feature-gate checks and structural simplification scrutiny apply without a special keyword. File length or trust-boundary `unknown` alone is not a finding.
13. Original Thermos internet resource URLs and removal/replacement history remain in SOURCES.md for future updates, explicitly distinguished from runtime dependencies.

## Limitations and validation

Model review remains fallible. Runtime accuracy, recall and false-positive rate require separate evaluation; static document checks do not establish them. The existing strict validator requires PyYAML; do not install it without approval. See SOURCES.md for research provenance, desk cases and actual validation results. Existing name, registration and automatic invocation remain unchanged.
