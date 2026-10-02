# QA Review — Skill Contract

Maintenance-only contract, not a feature spec under `.agent-work/`.

## Intent and shape

Create a portable `workflow-process` skill for branch/PR functional **and visual/style** browser QA. Use sequential orchestration with focused browser, visual, artifact, and calibration references. Reuse installed Playwright MCP and project-native testing guidance; add no executables, dependencies, browser driver wrappers, or mandatory workers.

## Scope

- Inputs: branch/PR target; repository rules/diff; explicitly selected work context; associated requirements/tickets/Figma if available; project browser instructions; permitted local environment and test identity.
- Outputs: requirement/scenario and visual matrices; evidenced findings; QA-only verdict; immutable review/evidence and indexes compatible with `code-review` / `review-triage`.
- Trigger: QA this branch/PR, browser acceptance check, visual/style regression check, compare implemented UI to Figma, QA fix-agent handoff.
- Exclude: design implementation, test authoring, automatic repairs, static-only security/code review, production/staging testing, tracker publication, merge approval, automatic triage/commit.

## Invariants

1. Confirm target base/head/merge-base and runtime provenance; a dirty worktree or stale build cannot stand in for pristine PR head.
2. Inspect `.agent-work/`; select by explicit path/current confirmation/validated reciprocal link, never branch/recency. Absent docs are allowed; durable review still requires confirmed Work-ID.
3. Read relevant spec/plan status, acceptance/non-goals, glossary/ADRs, project testing guides, and linked ticket/design sources. Label unavailable sources and consequential conflicts, not inferred truth.
4. Run functional and visual checks separately. Compare actual screenshots at matched viewport/state to Figma or applicable design-system/established UI evidence. No Figma does not remove style QA.
5. Keep side-effect approval, local-only execution, fixture isolation, secret protection, and artifact/commit gates intact. Preserve old reports, Active triage, source and baselines.
6. Record observed versus static versus inferred evidence; distinguish product defect, pre-existing behavior, infrastructure failure, and unknown attribution. No issue quotas or guessed root causes.
7. READY requires completed applicable agreed QA checks and no blockers. It never implies complete code/security review or permission to merge.

## Acceptance checks

Use synthetic examples in `references/qa-examples.md` plus these desk checks; runtime adherence needs separate isolated evaluation.

| Case | Required result |
| --- | --- |
| Explicit spec with valid plan link | Read both plus applicable context without another identity interview |
| One plausible work folder, no selection | Ask with candidate status/scope and standalone option |
| No spec/ticket/Figma | Use explicit intent/contracts; confirm Work-ID for report; visual checks remain required |
| Ticket/Figma conflict or denied source | Ask or mark affected criteria incomplete; do not invent expectations |
| Local page proxies live backend | Stop execution before unsafe flow; request safe local setup |
| Dirty worktree/wrong build | Record mismatch; no pristine-head QA claim |
| Styling-only PR | Inspect actual screenshots, states, responsive widths and shared consumers, not clicks alone |
| Shared token change | Include representative affected screens and theme/breakpoint checks |
| Stale/mismatched screenshot baseline | Align state/config before finding; never rewrite baseline to pass |
| Intermittent bug | Preserve first evidence/attempt counts and investigate, not retry until green |
| Browser/screenshot unavailable | Safe partial work plus INCOMPLETE; static trace is not browser/visual pass |
| Supplied GitHub review has multiple comments, one apparently irrelevant | Preserve the complete source feedback unchanged and paginated; separate contextual excerpts |
| Existing Active triage | New immutable review changes Latest only |
| Staged work artifacts / no-write | Stop and ask / return report without artifact writes respectively |
| Evidence/index write failure | Explicit not-saved or saved-but-unindexed state; no false durable handoff |
| Fix-agent reads report | Stable IDs/repro/expected source/fix direction/retest; revalidate and request fix authority |

## Validation and limitations

- Validate frontmatter/name/portable paths with repository `quick_validate.py --skill-class workflow-process --strict-depth`; separately inspect reference links, source provenance, profile coverage, and trigger boundaries.
- Qualitative comparison only by default; do not claim measured model improvement, exhaustive skill-market ranking, full accessibility compliance, pixel-perfect fidelity, or actual app execution from desk checks.
- No project target or authorized app supplied during skill authoring. No real browser/PR QA, private ticket/Figma access, or fix-agent round trip is implied.
- Skills steer agents; they do not technically sandbox browsers or guarantee compliance. Repository permissions and runtime evidence remain necessary.
