---
name: pr-review
description: Prepares concise, high-signal GitHub reviews when someone requests the user's PR review. Use for "review this PR for me", "draft feedback for GitHub", "turn this code review into PR comments", or walking through outgoing review feedback. Runs code-review or reuses a selected review, refines comments with the user, recommends approve/request changes/comment, and publishes only after explicit approval. Not for exhaustive local audits or addressing incoming comments on the user's code (use review-triage).
---

# PR Review

Investigate thoroughly, publish selectively. Flow: source review -> shortlist -> item walk -> event -> exact preview -> explicit publication approval.

## Boundaries

- Suggest fixes only: prose or complete anchored GitHub `suggestion` blocks. Never edit code, commit, push, apply suggestions, resolve threads, dismiss reviews or merge. Implementing a fix requires leaving this workflow.
- Draft locally. Creating even a pending remote review is a write that needs publication authorization.
- Keep/Reword/Omit/Investigate decisions affect public feedback only. Omitting a finding does not resolve it; serious unresolved risks still constrain the event recommendation.

## 1. Source review

1. Resolve repository, canonical PR URL/number, base/head SHAs, head branch, state and existing discussion with read-only `gh`. A closed/merged PR may be reviewed historically but never submitted as an active review.
2. Fresh PR: load `code-review` and run it normally; it persists `review.md` and returns `Artifact: <path>`. Existing report: use only an explicitly selected path; read it whole, do not rerun discovery, but check current head/discussion against its revision and re-review changed paths.
3. Create append-only `feedback.md` beside the selected `review.md`. Use the same log conventions as `review-triage`'s `triage.md` (identity header, `Source: ./review.md`, one dense timestamped line per event, exact decisive user input as a JSON string), with the outgoing vocabulary Keep/Reword/Omit/Investigate plus draft versions, event choice and publication outcome. If the file already exists with conflicting identity, ask. `review.md` stays immutable; corrections and revalidation go in `feedback.md` under the original finding IDs.

## 2. Shortlist, then walk items

- Propose which findings to publish and which to omit, one short reason each, keeping stable IDs and source order. Recommendations are not decisions; no silent omission, merge or reorder.
- Prioritize introduced/worsened defects with real impact, broken contracts and substantial maintenance cost. Recommend omitting taste, cleanup nits, feedback already in a thread, disproven claims and unrelated pre-existing problems. Do not filter by inherited P-labels, round votes or a comment quota.
- Investigate only the current item; verify its trigger, impact and counterevidence independently of the report's conclusion. Keep impact, reachability (UI vs API vs crafted request) and unknown frequency separate; a race is not rare without evidence. If evidence is incomplete, name the settling check and offer Investigate or an explicitly uncertain question draft.
- Ask with the question tool: assessment plus draft in the Markdown question, then Keep / Reword / Omit / Investigate as applicable, recommendation first, single-select. Keep means include this wording, not publish. Reword/Investigate keeps the item open.
- Log the decision, confirm briefly, pause for continuation before the next item unless the user explicitly waived stops for this session. Batch authority does not waive stops.

Read `references/calibration.md` when importance, disputed reachability or wording needs calibration.

## 3. Draft style

Natural short sentences, usually 1-3 per comment. Lead with what goes wrong and when, then concrete impact; add an example only when it clarifies the mechanism. Suggest the smallest sound fix; use a `suggestion` block only when replacing that exact range fully fixes the issue and syntax/companion changes are verified. No finding IDs, Problem/Evidence/Fix labels, severity boilerplate, filler praise or repeating inline comments in the body. Mark nonblocking suggestions as such. Evidence detail stays local unless the author needs it to act.

## 4. Event, preview, publication

1. Recommend one event with a short reason, independent of the internal BLOCKED/INCOMPLETE/READY label: APPROVE (no unresolved blockers), REQUEST_CHANGES (verified material problems), COMMENT (useful feedback or uncertainty prevents approval). Missing runtime checks alone are not a defect.
2. User chooses; log recommendation and choice separately. If the choice conflicts with known blockers, say so and clarify.
3. Show the complete exact payload: body, inline comments with anchors, suggestion blocks, event, PR URL and head SHA, as a numbered draft version. Any wording change needs renewed acceptance.
4. Ask for explicit publication authorization of that exact version. "Looks good", choosing APPROVE or the original review request is not authorization. Do not re-ask when authorization is explicit and unchanged.
5. Before posting, read `references/github-publication.md`. Changed head, content, event or relevant discussion invalidates approval: re-preview and re-ask. Log the result with URLs; an ambiguous response is blocked, not posted, and logging failure blocks any retry until remote state is reconciled.

Return short progress summaries with artifact paths; the full investigation stays in `review.md`.
