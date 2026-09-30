# Code Review Contract

## Intent and scope

Primary automated, exhaustive review of a defined change and affected paths, or an explicitly requested whole-file audit (including existing defects in that scope). No later human review is assumed. Completeness means explicit coverage, not proof that no defects exist.

Default includes correctness, edge cases, security/privacy, data/rollout compatibility, tests, reliability/performance, maintainability, scoped rules, relevant documentation, and recent merged/deployed patterns. Narrow user-requested modes remain possible but cannot grant whole-change readiness.

## Inputs and outputs

Inputs: pinned target/base/head or stable local-change inventory; relevant requirements/rules/docs; callers/tests; recent history; deployment evidence when applicable; permitted validation tools/results.

Outputs: all distinct actionable findings with trigger, evidence, impact, location, blocking status, fix direction and regression check; coverage/evidence ledger; BLOCKED, INCOMPLETE or READY verdict; and a verified durable copy at `.agent-work/work/<work-id>/reviews/<branch-key>/<review-id>/review.md`. Work and branch indexes retain ordered history, latest-review metadata, and per-branch active-triage state. Unconfirmed hypotheses are gaps, not established findings.

## Safety and evidence invariants

- No application edits, comment publication, PR approval, merge, deploy, installs or permission bypass implied by review. The sole default write is the review artifact and its root/branch review indexes.
- No worktree checkout/reset/stash for history inspection; unrelated WIP preserved. Review artifacts are never staged, committed, ignored, or overwritten without explicit approval; already-staged `.agent-work/` content blocks artifact mutation pending clarification.
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

14. “For real” and completed-fix verification use this entry point, not a separate skill. Explicitly narrowed checks retain scoped reporting and cannot grant full-change readiness; initial diagnosis and test-first implementation are not triggers.
15. Material requirements cite user decisions, document sections/versions or established contracts and map to behavior/check evidence with verified/violated/unverified status. Unknown acceptance criteria or unresolved material conflicts prevent a completion claim. Tests and implementation alone do not establish intent.
16. UI runtime checks require permitted browser access and any needed server authorization. Missing required browser evidence remains a gap; green static checks are not a substitute.
17. Former for-real implicit repair authority is not retained: prior implementation approval alone does not authorize fixing review findings. Apply explicit per-finding approval, or explicitly authorized batch decisions, then re-review the changed revision.

18. Branch/PR reviews discover associated PRs and use the current description and relevant discussion/review threads as intent and risk context. Confirmed absence differs from unavailable lookup; unresolved material context gaps prevent READY. Prior reviewer claims and resolved threads require independent verification against pinned code.
19. Branch/PR reviews inspect the branch commit sequence and available PR timeline/review history, trace material decisions and prior fixes to the current revision, and report sources, inspected ranges and unavailable history alongside recent subsystem precedent.
20. Every review belongs to a confirmed Work-ID. If none exists, the workflow proposes and confirms one before creating a review-only work directory; it does not invent a Work-ID from the branch or force spec/plan creation.
21. Each branch has one exact-name-preserving series folder, root catalog entry, and branch index. Each completed review gets a unique timestamp/source/target directory and immutable complete `review.md`; history is newest-first. A new review updates only that branch's `Latest review`, never its `Active triage` or another branch's state.
22. Pre-PR, later PR revisions, and imported GitHub feedback stay in the same verified branch series. Different branches within one work remain separate. Detached/renamed/colliding branches require confirmation rather than automatic relinking. GitHub-sourced reviews preserve a complete verbatim source snapshot: exact overall-review URL/body when present and every comment's stable URL, identity, author/context, unchanged text and exact annotated source line/range from the correct side/revision in source order, plus retrieval time and target SHA—not only a PR number. Provider/API diff hunks, patches and surrounding source context are excluded from persistence. Missing, inaccessible, truncated, secret-redacted, or customer-data-redacted source content is explicit.
23. Artifact write/index failures are disclosed with the exact surviving path or reason and never misreported as persistence success. The complete review still appears in the response, and artifact failure does not alter its technical verdict.

## Limitations and validation

Model review remains fallible. Runtime accuracy, recall and false-positive rate require separate evaluation; static document checks do not establish them. Filesystem permission, staged-artifact, and partial-index failures can prevent durable persistence and must remain explicit. The existing strict validator requires PyYAML; do not install it without approval. See SOURCES.md for research provenance, desk cases and actual validation results. Existing name, registration and automatic invocation remain unchanged.
