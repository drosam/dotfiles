# Durable QA review and fix-agent handoff

## Contents
- Identity and allocation
- Style
- Finalize report
- Index and verification

Use the existing `code-review` / `review-triage` storage contract. Do not invent a parallel `qa-reviews/` hierarchy or require either skill to execute. All artifact paths below belong to the target project, not the installed skill.

## Identity and allocation

1. Inspect `.agent-work/` and git status, including the whole index, before writing. If any `.agent-work/` path is staged, stop and ask; never silently unstage it. Respect no-write requests and ordinary tool permissions.
2. Require a confirmed Work-ID and selected spec/plan paths or `Not created`. Work-ID must be a safe kebab-case directory segment. If no work exists, ask for a standalone Work-ID; create only its review storage, not a synthetic spec/plan.
3. Resolve `.agent-work/work/<work-id>/reviews/<branch-key>/`. Use the exact checked-out branch for branch QA or verified PR head branch for PR QA. Replace `/` with `--` for the branch-key and preserve the exact branch in metadata. Verify repository and stored branch mapping. Detached/unknown branch, rename, collision, unsafe path characters, or conflicting mapping requires a user-confirmed unique series key. Keep every resolved path inside the confirmed work directory; never move established series automatically.
4. Allocate a new run directory `<review-id>/` using UTC `YYYYMMDDTHHMMSSZ-qa-<short-head>` (include PR number if useful). Append a numeric suffix on collision; never reuse/overwrite a prior run. Read the current branch index and previous-review pointer first.
5. Place sanitized captures under that run's `evidence/` before finalizing. Keep incremental scenario notes in session context; if a durable draft is needed, label a separate `draft.md` as incomplete. Do not make a draft Latest or use immutable `review.md` as a scratchpad.

```text
.agent-work/work/<work-id>/reviews/
  index.md
  <branch-key>/
    index.md
    <review-id>/
      review.md
      evidence/
        QA-001-mobile-overflow.png
```

Do not store credentials, customer data, raw traces, auth-state files, or broad environment/network dumps. Sanitize before persistence. Use local relative links; do not rely on temporary tool output URLs. Verify each evidence file exists, opens, corresponds to the described state, and contains no sensitive content. Freeze referenced evidence with the finalized review; later retests use a new run. In a no-write run, do not persist screenshots/drafts either.

## Style

`review.md` is read whole by the fix agent and by `review-triage`; every token costs their context. Write caveman: fragments, labels, no narration, no hedging, no restating observations across fields. Compress wording, never evidence, finding count, or reproduction steps.

- Verbatim only where provenance requires it (source snapshot, requirement excerpts). Everything else compressed.
- Finding fields: one line each; omit a field with no content instead of writing `none`/`n/a` (keep Expected/Actual/Reproduction/Evidence always).
- Tables: fragments, not sentences. Coverage lists counts and labels, not every file read.
- Say each fact once; metadata lives in the header only.
- Keep exact routes, `path:line`, selectors, commands, results, evidence paths, unknowns.

## Finalize report

Write `review.md` once after synthesis. Include the complete report and metadata below; never edit a finalized report. Corrections/retests create another run linked to the prior report and finding IDs. The receiving agent can triage an earlier immutable review independently of a newer review.

For GitHub-sourced context/feedback, add a source snapshot before the agent report: exact supplied/canonical URL, retrieval time, target SHA, overall review body when present (otherwise `No overall review body`), then every comment from the selected feedback source in source order with stable URL/ID, author, thread/path/line context, and complete unchanged text. Retrieve all pages; do not discard supplied review comments because they appear unrelated to QA. Distinguish contextual PR excerpts from a complete supplied-review snapshot, and identify any missing feedback explicitly. Preserve code blocks. Include only the exact annotated source line/range at the correct side/revision for inline comments, not surrounding lines, API `diff_hunk`, or a whole patch. Record inaccessible source or pagination/truncation explicitly. Mark necessary secret/customer-data redactions. For PR descriptions, tickets and Figma, retain source locators, retrieved version/time and acceptance excerpts sufficient to reconstruct the oracle; do not copy unrelated private workspace material.

Use this template; all findings and scenarios, no top-N cap, one line per field:

```markdown
# QA Review

- Work-ID: ...
- Review-ID: ...
- Created: ... UTC
- Repository: ...
- Exact branch: ...
- Branch-key: ...
- Source: qa-review; branch | PR
- PR: URL/number or Not created
- Previous review: relative link or None
- Spec: exact selected path or Not created
- Plan: exact selected path or Not created
- Target: base ref/SHA, head ref/SHA, merge-base SHA, exact diff command
- Worktree: HEAD plus staged/unstaged/untracked inventory and final stability check
- Runtime: local URL, build/revision evidence, backend/test isolation, browser/version,
  viewport/device scale, role/fixture/flags/theme/locale as relevant
- Scope: changed journeys, visual surfaces, exclusions; QA only

## Source snapshot
Source locators, requirement excerpts, feedback provenance, redactions and retrieval gaps.

## Findings
### QA-001 — P1 [blocking] — Short observable defect
- Category: functional | visual | responsive | accessibility | runtime
- Requirement/scenario: R1 / S2; expected-behavior source locator
- Location: route/component and verified path:line, or source location unconfirmed
- Preconditions: role, synthetic fixture, flags, browser, viewport/state
- Reproduction:
  1. Exact starting route and action.
  2. Action and observation.
- Expected: source-backed behavior or reference appearance.
- Actual: observed behavior/appearance.
- Impact: affected journey/users; why blocking/nonblocking.
- Evidence: relative captures/excerpts; observed runtime vs static; attempts/results.
- Counterevidence: exceptions/stale state/fixture/design checks performed.
- Attribution: introduced | worsened | pre-existing | unknown; supporting comparison.
- Cause: inspected trace or explicitly unconfirmed hypothesis.
- Fix direction: smallest sound proposal, not an authorized change.
- Regression check: concrete flow/assertion and relevant viewport/state to rerun.

## Coverage and evidence
### Requirements and scenarios
| ID | Source/requirement | Role/data/flags/viewport | Steps/expected result | Result | Evidence or gap/next action |
| --- | --- | --- | --- | --- | --- |

### Visual/style coverage
| Surface/state | Reference/node/version | Viewport/theme | Dimensions checked | Result | Matched evidence/limits |
| --- | --- | --- | --- | --- | --- |

### Validation gates
| Required/supplemental | Exact command or CI check | Revision/environment | Result | Missing prerequisite |
| --- | --- | --- | --- | --- |

### Context and limitations
- Selected work status/constraints, relevant glossary/ADRs, project QA/setup guides.
- PR, ticket and Figma source ledger: read / not linked / unavailable / partial.
- Console/network findings and baseline noise; simulated versus real integration.
- Untested scenarios, conflicts, missing evidence, and exact next checks.
- Approved side effects, cleanup performed, remaining fixtures/processes.

## Verdict
BLOCKED | INCOMPLETE | READY — QA scope only; evidence-based reason.

## Fix-agent handoff
- Finding IDs and suggested investigation order/dependencies; preserve original IDs.
- Exact reviewed target and evidence paths; revalidate against current code before fixing.
- Needed decisions/permissions; no implementation/commit/publication authority granted.
- Retest commands/flows/visual states and blocked prerequisites.
```

If no supported defects, write `No actionable findings in reviewed QA scope.` Still include all coverage, visual results, gaps and verdict. An untested browser, unresolved mandatory design criterion, or unknown running revision cannot produce READY.

## Index and verification

After writing and rereading the complete report:

- Maintain `reviews/index.md` as branch catalog only: Work-ID, exact branch, branch-key, repository, branch-index link, latest-review timestamp. Order by most recently completed review for readability, never for work selection.
- Maintain `<branch-key>/index.md`: Work-ID, repository, exact branch, confirmed aliases, PR URL/number or `Not created`, `Latest review`, `Active triage`, newest-first review history. Point Latest to the new finalized `review.md`; preserve existing Active triage byte-for-byte. Use `None` only for a newly created index with no triage.
- Preserve existing entries and review-type distinctions. Recheck indexes before editing; if another run changed them, reconcile without overwriting its entries or triage pointer. Broken/cross-work mappings require clarification.
- Verify metadata, every index/report/evidence link, and that the full findings/coverage were saved. Do not create `triage.md`; `review-triage` owns that lifecycle.
- Never stage/commit artifacts or modify ignore rules without explicit inclusion approval.

On write failure, return the complete report with `Artifact: not saved — reason`. For a saved report with failed index updates, report its exact path as **saved but unindexed**, not Latest. Do not delete partial artifacts or hide the gap. Artifact failure is separate from technical verdict. Return the verified artifact path, finding summary, scope-qualified verdict and gaps; do not auto-launch fixes or triage.
