# QA calibration examples

Synthetic desk-check transcripts, not executed tests or findings about this repository.

## Happy path: PR acceptance plus visual defect

User: “QA PR 42 using `.agent-work/work/search-filter/spec.md`; the local app is already running. Disposable test-role login is approved; don't change records.”

1. Resolve PR base/head and current worktree; verify local build matches. Validate selected spec Work-ID and reciprocal plan. Read project browser guide, linked ticket acceptance and Figma node.
2. Map `R1` filter navigation and `R2` mandatory mobile layout to scenarios. Confirm fixture is read-only and interaction does not persist settings. Match the Figma mobile width/theme/content before comparison.
3. Exercise filter, empty results, keyboard selection and reset. Inspect console/network and capture desktop/mobile screenshots. Desktop works; mobile clear action is clipped.
4. Inspect component styles and establish the new fixed width from the diff. Record the observed defect, not a redesign wish.

Example finding:

```text
QA-001 — P2 [blocking: R2 requires visible mobile actions]
Category: responsive
Location: /search; src/search/FilterBar.css:42 (hypothetical verified location)
Preconditions: synthetic reader role; 375×812 viewport; default theme; active filter.
Steps: open /search → select Status=Open → inspect/activate Clear filters.
Expected: Clear filters remains visible and keyboard accessible (spec R2, Figma node).
Actual: fixed-width bar pushes Clear filters outside the clipped container.
Impact: narrow-screen users cannot discover the reset action.
Evidence: evidence/QA-001-mobile.png and reference node; 2/2 attempts.
Counterevidence: fonts loaded; matching viewport/content; not an intentional scroll region.
Attribution: introduced; pinned diff replaces wrapping layout with fixed width.
Fix direction: restore responsive sizing/wrapping, preserving desktop alignment.
Regression: filter/reset at 375px and desktop; screenshot and keyboard-focus checks.
```

Finalize a new review and indexes; preserve an existing Active triage. Verdict: BLOCKED, QA scope only. Hand off QA-001 without editing CSS or starting triage.

## Guarded variant: local frontend, unsafe backend

User: “QA checkout; localhost is running.” Project configuration points the frontend to a live payment service.

- Inspect configuration before navigation/submission; localhost is insufficient isolation evidence.
- Do not log in, submit payment, call real endpoints, or replace secrets. Ask for the documented local/mock payment setup and exact authorization for disposable checkout flows.
- Complete permitted requirements/design/diff inspection. Mark checkout execution blocked; do not call it a product defect or a pass. Preserve no customer/session data.
- If no confirmed work exists, ask for standalone Work-ID before saving an INCOMPLETE review. If writes are declined, return the report in chat without screenshots/drafts on disk.

## Failure recovery: stale locator versus intermittent product defect

A click fails because the element reference is stale after the list rerenders.

- Capture tool failure, refresh snapshot, reacquire the intended control, and retry once from safe known state.
- If the UI works, record tooling recovery rather than inventing a product bug.
- If the selected value disappears after reload in one of three attempts, preserve that observation and evidence. Investigate request ordering/fixtures; report the intermittent defect if supported, with attribution/cause unknown where unresolved. Do not discard it because a later attempt passed.
- If runtime access is denied, stop browser work; report completed static checks separately and list the exact missing runtime scenario. Do not route through shell automation to evade denial.

## Anti-patterns and corrections

| Anti-pattern | Corrected behavior |
| --- | --- |
| “The matching branch-name spec must be ours.” | Inventory titles/status/scope and ask, even with one candidate; offer standalone |
| “Figma looks different, P1.” | Match node/state/viewport/theme; cite concrete requirement or usability impact and calibrate severity |
| “No Figma, skip styles.” | Inspect screenshots against applicable design-system conventions; check overflow/typography/states; disclose missing fidelity baseline |
| “Snapshot has all text, visual check passed.” | Visually inspect screenshots at relevant widths/states; DOM presence cannot prove readable layout |
| “Screenshot baseline updated; all green.” | Preserve old baseline and report mismatch; review grants no baseline-edit authority |
| “Five issues required; spacing feels off.” | No quota; only actionable source-backed mismatch or observed harm |
| “Blocked ticket access means no ticket exists.” | Record unavailable source, affected acceptance gap, and next retrieval action |
| “The PR SHA is right, so the app must be right.” | Verify running build/backend and dirty-worktree provenance independently |
| “A new review should replace Active triage.” | Update Latest only; existing triage remains pinned to its original review |
| “Save trace/auth state so the fix agent can log in.” | Use synthetic repro setup and sanitized excerpts; keep credentials/session dumps out of artifacts |

## Retesting and iteration

For retests, read the explicitly selected earlier review, revalidate current target, and rerun its exact failing and adjacent regression scenarios, including matched visual states. Preserve old finding IDs as references; record fixed/still failing/not retested with new evidence in a new review. Never rewrite the earlier verdict or infer a fix from changed source alone.

When improving this skill from real runs, add anonymized cases to maintenance evaluation with source/run provenance; distinguish observations from these synthetic examples. Record the behavior delta and replaced rule in `SOURCES.md`; do not turn failures into a growing mandatory checklist without evidence.
