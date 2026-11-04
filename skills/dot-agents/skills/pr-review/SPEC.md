# PR Review Contract

## Scope and shape

Workflow-process skill for preparing an outgoing GitHub review with the user. Sequential coordinator: reuse code-review investigation, then user-directed feedback selection and publication. No new discovery workers, scripts, dependencies or scoring systems. Publication details and calibration examples are directly routed references.

Not an incoming-feedback repair workflow. Suggested fixes are prose or complete anchored GitHub suggestions only; no local code changes, commits, pushes, applying suggestions, merge or thread-management authority.

## Inputs and outputs

Inputs: explicit PR target or selected full review, confirmed Work-ID/source identity, pinned revisions, discussion and applicable evidence, user's exact decisions and final publication authorization.

Outputs: full immutable `review.md`; append-only `feedback.md` with stable IDs, proposed dispositions, source locators, evidence corrections, draft versions, exact decisions, recommendation versus chosen event, approved payload snapshot and publication outcomes. Fresh direct runs create only those two files. Existing reviews/indexes remain intact; an existing complete review is reused without copying or creating indexes.

## Safety and evidence

- Investigate at code-review depth without weakening its evidence, rounds, coverage, source snapshots or technical verdict. Incomplete sources never become complete reviews merely because public feedback is short.
- Verify current-item reachability/impact and counterevidence independently. Preserve API/security concerns, unknown frequency and serious risks. Nits are recommended omissions, not silently discarded findings.
- Require explicit item or batch decisions and serial feedback investigation. Session continuation waiver is separate from action approval. Keep wording history append-only with actual UTC times and exact decisive inputs; no private reasoning diary.
- Separate acceptance of wording, choice of review event and explicit publication authorization. Bind authority to exact PR/revision/payload; material change requires revalidation and renewed authorization.
- No remote draft creation before authorization. Verify event, diff anchors and remote result; ambiguous attempts require reconciliation before retry. Logging failure blocks publication and never authorizes duplicate posting.
- Preserve WIP, artifact identity, redaction and staged-artifact gates. Missing tools or source/persistence failures are explicit blockers, not permission to guess or bypass controls.

## Acceptance checks

1. Direct PR invocation calls code-review in explicit handoff mode; normal standalone code-review storage and output remain unchanged.
2. Selected existing report is read fully, retained immutably and checked against current revisions; no repeated full discovery unless changed scope or evidence requires it.
3. Source report retains all supported findings and full coverage/results/gaps. Omission affects public feedback only; it does not resolve technical blockers.
4. A 12-finding source can produce two selected comments without losing the other findings or their disposition history.
5. Keep/Reword/Omit/Investigate controls outgoing feedback; none implies local edits, commits or publication. Suggestions are complete anchored replacements or concise directions.
6. Comments use natural short sentences, normally 1-3, with necessary examples/details; no mandatory report labels, padded praise or repetition.
7. UI, API and crafted-request reachability remain distinct; API-only serious defects are not discarded, and races are not called rare without evidence.
8. Recommendation and selected APPROVE/REQUEST_CHANGES/COMMENT remain separate from technical readiness. User chooses; unverified checks do not automatically become blockers or a clean approval.
9. Exact full preview precedes explicit publication. "Looks good" and selecting APPROVE alone post nothing. Changed base/head/text/event/relevant discussion invalidates publication approval.
10. Stable IDs and draft versions survive omissions, corrections, restarts and revision changes. Resume reconstructs state from complete source/log, not an index or summary.
11. New runs create only review.md and feedback.md, under a confirmed work directory. Existing files/indexes are not migrated or updated; no spec/plan scaffold is required.
12. All decisions, modifiers, material corrections, approved text and publication results are recoverable in timestamp order. Failed appends are never called saved.
13. Batched review uses exact authorized event/commit/body/comments. No own-PR failure fallback, arbitrary anchors, unrelated pending-review submission or blind retry.
14. Closed PR, inaccessible context, failed worker/check, publication error, stale revision and logging failure have explicit stop/recovery paths.

## Validation and limitations

Use the workflow-process strict validator plus desk cases in SOURCES.md and references/calibration.md. Desk checks assess instructions, not model adherence or review accuracy. No GitHub writes or application execution are needed for static validation. Live discovery requires the canonical directory to be exposed to the runtime and reloaded; prompt changes may require a new session. Publication behavior remains untested until exercised with explicit authorization.
