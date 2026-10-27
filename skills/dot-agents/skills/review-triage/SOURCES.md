# Review Triage Sources and Decisions

## Optional session checkpoints

User-approved refinement in this session: replace the earlier rejected forced-batch proposal with an offer after 4 completed items to hand over, compact manually, or continue. Source confidence: explicit user preference, not evidence that 4 is optimal or that either transition improves correctness. Installed Pi 1.4.0 `docs/sessions.md` and `docs/compaction.md` confirm that `/new` starts a fresh session and `/compact [instructions]` summarizes older context while retaining recent messages; neither guarantees faithful recovery. No extension/API dependency was adopted.

Behavior delta: intercept the existing safe advancement boundary, count only current-session/interval terminal items, and ask a separate Handover / Compact / Continue question without investigating the next item. Handover/Compact saves and verifies a dense checkpoint in existing `triage.md`, preserves exact identity and continuation state, returns manual transition instructions, and stops. Continue or explicit post-transition continuation resets the interval. Existing per-item decisions, validation/commit gates, immutable source, append-only logging and resume identity checks remain authoritative. Early user-requested checkpoints preserve active work/blockers; default offers never interrupt it. Failed persistence cannot masquerade as a saved handover.

Shape: inline workflow-process guidance plus updates to existing contract/provenance docs; no new artifact, dependency, script, extension or registration change. Description unchanged: existing-feedback walkthrough and resume requests still trigger; fresh code review, unrelated feature work and standalone session-management requests do not become triage triggers.

Qualitative desk checks only (expected behavior, not observed agent runs): four completed items plus a pending fifth -> session-choice question before fifth-item investigation; three completions plus a blocked fix -> preserve blocker, no automatic offer; final item completed at interval boundary -> final summary only; Continue -> next interval without immediate re-prompt; Compact chosen -> verified checkpoint and manual command, no claim of execution; handover with mismatched live branch on resume -> existing clarification gate; explicit early handover during Discuss -> preserve unresolved item and decision, never advance. No runtime adherence or effectiveness measurement.

Validation: targeted `git diff --check` passed; static review confirmed the new offer intercepts advancement without weakening existing per-item gates. Strict-depth validation was not rerun because the earlier validator attempts failed at startup with `ModuleNotFoundError: No module named 'yaml'`; no dependency was installed. Live triage, handover and compaction flows remain untested.

## Readable assessment followed by one interactive decision

Human-verified iteration on 2026-10-23 from user-supplied Pi screenshots in this session. Negative example A: the agent rendered Original feedback, context, recommendation and a numbered options list as plain text, ending with `Reply 1, 2 or 3`; no interactive selector appeared. Negative examples B/C: the interactive selector appeared with a short title/options, while the full Original feedback, context and verdict were absent from the active decision view.

Session-file investigation disproved the agent's repeated explanation that Pi rewrote or hid its assessment. Each failing assistant entry contained thinking blocks plus the `question` tool call - no visible text block. The one-line italic text in the screenshots exactly matched private/reasoning blocks. The same session contained nine earlier entries where normal text and a question call coexisted, so the runtime can support both, but two prompt-only attempts still failed after the skill was explicitly reloaded and after compaction. Prompt wording cannot reliably force the model to emit narration before tool use.

Behavior delta: put Item, Original feedback, Context, Verdict and the final decision prompt into the question tool's existing Markdown `question` field for normal-sized items, without adding a feedback-specific or generic `context` schema. Preserve original feedback as authored Markdown between item-specific begin/end markers instead of forcing every line into a blockquote; runtime evidence showed nested blockquotes add unwanted quote styling around fenced code and GitHub `suggestion` blocks. Treat marked source as data, visibly escape raw HTML or collapsed details when needed, and point to the immutable source. The extension removes terminal and bidirectional control characters before display. Context uses 1-3 short clear-English sentences. Verdict is 1-3 short, simple prose sentences explaining the recommended outcome and why; a canonical option label or selected answer is a decision, not the Verdict. Keep 2-4 canonical-action options concise, recommendation first and `multiple: false`; later independent follow-ups may use multi-select.

User-approved correction on 2026-10-26: a completed payload over 40 newline-delimited lines or 4,000 characters renders the complete assessment through Verdict as normal transcript Markdown, with no numbered/plain options or reply-by-number prompt. It then invokes the question tool with the same options and only a short pointer to the assessment immediately above. This supersedes the earlier oversized plain-text numbered-choice fallback while preserving the fixed threshold and one-item-at-a-time decision gate.

This presentation iteration supersedes the earlier requirement to repeat an unverified item's exact settling check in both Defer and Discuss options. Show the full check once in Verdict, keep both options concise, and preserve the unchanged rule that unverified findings cannot offer Fix/Skip.

Implementation research used public Pi extensions as pattern evidence. `SchneiderDaniel/cheasee-pi` question UI at commit `d87f6f65b188bfa85869c5f2c9b26824a50fc3c6` (MIT) demonstrated a compact fixed-height viewport, which was tried and rejected after runtime use showed its PageUp/PageDown path was unreliable. Pi's built-in `ScrollView` was then tested and rejected for the normal custom surface because `ctx.ui.custom()` mounts non-overlay questions in the unconstrained editor slot: wheel events scrolled the transcript and the nested view received no usable viewport height. A later centered-overlay experiment also failed: overlay `maxHeight` clipped the rendered root instead of giving the nested `ScrollView` a usable viewport, so neither mouse nor keyboard scrolling exposed the options. `openpi-dev/openpi` terminal sanitizer at commit `676cd5049e7652d6fcb6acbd987c058ab8f7853d` (MIT) confirmed the retained need to neutralize terminal and direction-spoofing controls. No dependency or feedback-specific presentation model was adopted.

Shape: one backward-compatible renderer change in the existing Pi question extension plus deterministic triage output guidance. No schema field, new tool, dependency, worker, script, overlay or active-question scroll subsystem. The question tool remains single-select by default with custom answers and optional multi-select. Normal-sized questions render complete Markdown above options. Completed results use Pi's standard tool expansion state: collapsed shows the short answer summary; `Ctrl+O` shows the full question plus answer. Oversized triage payloads keep assessment text in transcript scrollback and use the existing question tool only for the short final selector.

Qualitative replay targets: normal-sized item -> one full-question selector; selector-only/assessment-missing output -> assessment carried by the tool's question argument; payload over 40 lines or 4,000 characters -> complete assessment through a plain-language Verdict in transcript text, followed by a short question-tool selector with no numbered options in prose; Verdict -> understandable rationale rather than a copied option label or selected answer; fenced or `suggestion` feedback -> authored Markdown retained without outer quote styling; feedback-authored headings -> bounded by item-specific source markers; terminal/bidi controls -> removed before rendering; completed selection -> compact decision summary without replacing Verdict; unverified claim -> check once in Verdict plus Defer/Discuss; unsupported tool -> assessment plus unnumbered canonical-action bullets; canonical actions -> never multi-select; later independent checks -> multi-select allowed. Expected: reliable context and decisions without a custom scrolling or modal framework.

Validation: runtime screenshots after `/reload` confirmed the complete assessment reached the question tool, completed-result expansion restored context, and direct Markdown removed the outer quote styling. Oversized live tests proved the private viewport, nested built-in `ScrollView`, and later overlay experiment unsuitable: each path clipped or froze the question instead of providing usable scrolling to the options. Those experiments were removed. `git diff --check` and a runtime replay of the new transcript-assessment plus short-selector split remain required for this iteration. Vitest remains unavailable (`ERR_MODULE_NOT_FOUND: vitest`), strict skill validation remains blocked by missing PyYAML (`ModuleNotFoundError: No module named 'yaml'`), and no dependency was installed.

## Rule applicability, review-induced churn and round attribution

User-approved follow-up on 2026-10-22 after comparing local triage with private repository `booqable/local-spec-code-review` at pinned revision `c80707a4caeca397e31c2d9556385b27edd8dca8`. Reused the already inspected `plugins/local-spec-review/skills/run/references/triage.md` and `walk.md`; no additional retrieval. Trust/usage constraints remain secondary external pattern evidence only, high confidence for inspected pinned text, no effectiveness or lineage claim.

Behavior delta: for the current item, verify the exact scope/version/precedence of any cited rule, convention, API contract or policy; a mis-citation invalidates only that rationale, while underlying behavior follows normal evidence rules. Detect code/defenses introduced by earlier review fixes and require concrete reachable harm or a broken contract before adding another defensive layer; material maintenance cost instead supports simplification/removal. Preserve `found by x/N rounds` when available but use it only to order otherwise equivalent verification leads within the current item, never to reduce verification scope/depth, break an evidence/verdict tie, confirm a claim, set severity or create a vote threshold.

User calibration: do not lose review quality. Every item receives the same verification standard regardless of reviewer, severity label, prior-review origin or round support. Do not make specs hard authority: specs/plans remain evidence of intended behavior and may be stale or incomplete; conflicts can reveal an intent gap rather than settle triage automatically. Current explicit user decisions and mandatory external contracts carry more weight. Rejected additions: automatic spec-based rejection and a new repository noise-policy mechanism. Existing explicit evidence, safety and user-decision gates remain authoritative.

Shape remains inline current-item verification guidance plus calibration examples; no new reference, worker, script, dependency or registration. Description remains unchanged because these checks refine existing-feedback assessment rather than add a trigger.

Qualitative desk cases only: private symbol under a public-API naming rule -> cited rationale invalid, underlying behavior still evaluated; independent runtime defect alongside a mis-cited rule -> defect remains; earlier hypothetical guard followed by request for another fallback state -> require reachable harm and prefer simplification; serious defect in earlier-review code -> still recommend action; supported `1/2` finding -> retain; unsupported `2/2` claim -> keep unverified until independently confirmed/disproven; missing round metadata -> no penalty; spec conflict -> present as intent context, not automatic Skip. Expected: fewer false positives and less review-driven complexity without weakening serious-risk handling. No runtime benchmark establishes decision quality.

Validation: targeted `git diff --check` passed. Three focused read-only code-health audits found and drove wording fixes for mis-cited-rule disposition, defense-layer gating, misuse of round agreement and unsupported-claim handling; final audit returned no actionable findings and confirmed unverified behavior remains Defer/Discuss. Strict-depth `quick_validate.py` was attempted with the workflow-process class and blocked by `ModuleNotFoundError: No module named 'yaml'`; nothing installed. No runtime triage conversation ran.

## Deterministic options and exact shaped decisions

User-approved change on 2026-10-22 after comparing the local workflow with private repository `booqable/local-spec-code-review` at pinned revision `c80707a4caeca397e31c2d9556385b27edd8dca8`. Inspected remote files: `plugins/local-spec-review/skills/run/references/triage.md` and `walk.md`. Trust tier: secondary external implementation. Confidence: high for retrieved instructions at the pinned revision, not for effectiveness; the repository described itself as pre-alpha. Usage constraints: pattern evidence only, no source text copied, no license inferred and no shared-lineage claim.

Behavior delta: add second-order "what the fix invites" cost to the existing evidence/value assessment; persist 2-4 concrete current-item options before asking, recommendation first; append the canonical action plus exact decisive user message as a one-line JSON string; echo the finding number/title/action/modifier before mutation or advancement; carry modifiers unchanged into implementation and validation. Ambiguous input records/echoes Discuss, never a guessed action. Unverified findings offer exactly Defer and Discuss, both with the exact settling check. Preserve one-item-at-a-time investigation and never precompute later options.

Rejected remote behavior: automatic acceptance/rejection, whole-queue verification before the walk, background fix polling, parallel worktree fixes/cherry-picks/reverts, mutable finding status as authority, and applying the "closest" interpretation of an ambiguous decision. Local immutable review, append-only triage, explicit user choice, serial validated per-item commit and no-silent-skip rules remain authoritative.

Shape remains inline workflow guidance; no new reference, script, dependency, worker or registration. Class: workflow-process. Selected synthesis profile: skill-writer `references/examples/workflow-process-skill.md`. Coverage: preconditions, ordered current-item flow, safety/approval boundaries, deterministic outputs, persistence failure, ambiguity recovery and implementation handoff are complete by desk inspection.

Description retained: these changes refine interaction after review-triage already triggers; they do not add a new request category. Should trigger remains existing-feedback triage, worth-fixing decisions, review-comment walkthrough and post-triage replies. Should not trigger remains fresh review discovery, feature implementation without feedback, deployment and unrelated GitHub replies.

Qualitative desk evaluation only: verified issue with one small repair -> Fix first with exact change; verified low-value edge -> Skip first with residual behavior; unavailable evidence -> Defer/Discuss only with settling check; shaped decision -> exact message persisted, confirmation echoed and modifier preserved; ambiguous modifier -> Discuss rather than closest interpretation; proposed guard that creates another state/guard cascade -> compare smaller invariant repair; later queue items -> no investigation or options. Expected result: clearer decisions and safer shaped fixes; no runtime benchmark establishes adherence, latency or decision quality.

Validation: `git diff --check -- skills/dot-agents/skills/review-triage` passed. Shared and Claude live links resolve to the canonical repository directory. Two focused read-only code-health audits found and drove fixes for ambiguity being recorded as apparent Fix authority and unverified options still exposing Fix/Skip; final audit returned no actionable findings. Strict-depth `quick_validate.py` was attempted with `--skill-class workflow-process --strict-depth` and blocked at startup by `ModuleNotFoundError: No module named 'yaml'`; nothing installed. No runtime triage conversation or behavior benchmark ran.

Retrieval stopped after the remote triage and walk contracts exposed their worth-it, option, decision and mutation semantics. More remote files would be low-yield because source capture, review discovery and fixing orchestration are outside this approved change.

## Concise GitHub replies after triage

User-requested iteration from the named local session "PCO-5103 triage full review": after triage, the user may ask the agent to publish outcomes back to GitHub. The prior workflow correctly targeted inline comment threads, used a top-level PR comment for overall-review bullets, captured returned URLs, and logged publication. Its fixed-item replies were too verbose: phrases such as "applied your suggestion" and implementation summaries repeated what the commit already showed.

Behavior delta: triage decisions still imply no remote action. A separate explicit request to reply/comment authorizes publication only for the identified review scope, without another wording confirmation unless target/scope/text is materially ambiguous or preview is requested. Inline feedback stays in-thread; overall-review-only feedback uses a top-level comment with minimal identifying quotation. Fixed-item text defaults to `Fixed in <linked-short-sha>.`; context is added only when necessary. Skipped/deferred/already-resolved/question items get one brief direct rationale or answer. Never implicitly push, resolve, dismiss, approve, or merge. Verify targets and commit availability, capture returned URLs, and append outcomes to triage.

Shape remains inline conditional guidance; no new reference, script, dependency, or registration is needed. Existing persistence and GitHub source metadata already provide comment IDs, URLs, decisions, and commit hashes.

Static desk checks (expectations, not runtime agent runs):
- Explicit "reply on GitHub" after a fixed item posts `Fixed in <linked-short-sha>.` to the existing thread - improved concision.
- A fixed item needing no clarification omits "followed/applied your suggestion" and implementation detail - improved signal.
- A skipped item posts one short evidence-backed reason - improved concision, unchanged truthfulness.
- Overall-review-only bullets use a top-level PR comment with enough quotation to identify each response - unchanged targeting.
- A local-only commit blocks the reply pending separate push authorization; reply authority never becomes push authority - unchanged safety.
- "Fix this item" without a reply request posts nothing remotely - unchanged permission boundary.

Description now includes "reply on GitHub after triage" to cover the new explicit trigger while retaining the existing-feedback and no-fresh-review boundaries. Should trigger: "reply on GitHub to these triaged comments", "post the review outcomes", "tell the reviewer which commits fixed these". Should not trigger: "reply to this unrelated issue", "review this new PR", "push my commits", "resolve all review threads". Runtime adherence remains unmeasured.

## Prior-session finding history

User-requested workflow correction: triage of a current point must check the confirmed Work-ID's earlier review/triage sessions to determine whether the same behavior or root cause was already discussed. Previously, the skill preserved history and required full reads on resume but did not explicitly search earlier review runs for each point.

Behavior delta: before current-code investigation, verify `review.md` Work-ID against directory/index identity, then search relevant earlier immutable reviews and append-only triages in that work. Start with pinned branch history and previous-review lineage; cross branch series only when code lineage makes it relevant. Match semantically using identifiers, paths and symbols as aids, read the full matched finding and later events, and cite the artifact/range. Revalidate prior fixes, defers and verdicts against the current target. Prior decisions remain context, never current evidence or authorization. State no match or access/search gaps explicitly. This adds one every-item lookup to the existing inline workflow; no script/reference/dependency needed.

Static desk checks (expectations, not runtime agent runs): repeated root cause with renamed title is found through path/symbol/behavior and cited; prior fixed item checks its commit and current code before calling feedback stale; prior deferred item checks the revisit condition; same title with a different cause is not treated as a match; unavailable or ambiguous history remains an explicit gap; later queue items remain uninvestigated. Expected: improved continuity and fewer repeated discussions, with unchanged per-item approval and evidence gates.

Description remains unchanged because this alters triage depth, not routing. Existing should-trigger queries such as "resume review triage" remain accurate; fresh-review and implementation requests remain excluded.

Validation: `git diff --check -- skills/dot-agents/skills/review-triage` passed. Strict-depth validator attempted with the workflow-process class and blocked by the existing environment gap: `ModuleNotFoundError: No module named 'yaml'`; no dependency installed. Runtime behavior remains unmeasured.

## Queue source locators

User-approved iteration from a human-supplied triage/review pair in this conversation: compressed queue entries preserved code locations but omitted document locations, making exact original feedback harder to retrieve. Anonymized negative example: two reviewers flag the same control at overlapping code lines; the queue has no direct locator for either distinct comment. Positive behavior to preserve: compact queue, full immutable source, separate decisions and append-only history.

Replace the queue format with an explicit `source: review.md:Lstart-Lend` field. Use verified, inclusive, 1-based document lines covering heading/metadata and complete comment; keep code locations separate. Existing logs receive append-only locator additions/corrections when resumed, not rewritten queues. Shape remains inline sequential guidance; no scripts, references, dependencies or registration changes needed. Scope: workflow-process skill maintenance only; the supplied application artifacts remain untouched.

Qualitative desk checks (static expectations, not agent runs):
- Working example: full first comment section maps to `review.md:24-51`; exact text recoverable without copying it into triage - improved.
- Duplicate findings: each reviewer retains an independent document range despite shared code locations - improved lookup, unchanged decision gates.
- Synthetic holdout: a local finding with fenced code includes the complete fence within its source range - improved lookup.
- Synthetic holdout: a legacy missing/wrong locator produces a verified append-only addition/correction; an ambiguous mapping asks - unchanged history safety, improved recovery.
- Fresh code-review requests still do not trigger triage; no investigation, approval or commit gates changed - unchanged.

Description retained verbatim: this changes output precision, not routing. Should trigger: "triage these comments", "resume review triage", "which findings should we fix?". Should not trigger: "review a new diff", "implement this feature", "explain Markdown line numbers". No runtime adherence or measured token-saving claim.

Validation: `git diff --check -- skills/dot-agents/skills/review-triage` passed; changed runtime guidance and contract re-read. The existing shared live symlink points to the canonical skill directory. Command `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/review-triage --skill-class workflow-process --strict-depth` exited 1: `ModuleNotFoundError: No module named 'yaml'`. No dependency installed; strict validation and runtime behavior remain unverified.

## Focused GitHub source excerpts

Human-verified negative example (2026-09-30): a GitHub feedback snapshot persisted raw API `diff_hunk` values. New-file comments duplicated every source line from file start through each anchor, while the GitHub UI showed only the annotated line/range. Path, range, side, revision, URL and unchanged comment body already established identity; repeated surrounding patch text wasted context whenever triage read or resumed the review.

Behavior delta: keep each inline comment's exact annotated source line or multi-line range, labeled with path/lines/side/revision, while excluding raw `diff_hunk`, patch and surrounding lines from durable snapshots. Use provider context only transiently to recover the selected lines. Preserve exact overall/comment text and embedded code; report inaccessible anchored source instead of saving a full hunk. This narrows existing persistence guidance and preserves immutable review/append-only triage architecture.

Static replay: the reported multi-line case retains only its selected range; a single-line anchor retains one line; left-side/outdated comments use their matching side/revision; inaccessible source stays explicit; code blocks authored in comment text remain verbatim. Expected result: lower resume-token cost without losing feedback or its precise code anchor. This is a desk check, not a measured runtime triage session.

Validation (2026-09-30): targeted `git diff --check` passed. Manual structural checks passed for frontmatter, required files, portable paths and the canonical live-skill symlink. Strict-depth `quick_validate.py` was attempted and blocked by `ModuleNotFoundError: No module named 'yaml'`; no dependency was installed.

## Durable source and append-only progress decision

User approved work-local branch series: `.agent-work/work/<work-id>/reviews/<branch-key>/<review-id>/`, with immutable `review.md` and separate append-only `triage.md`. A root review index catalogs branches; each branch index tracks exact branch/repository/PR metadata, newest-first history, `Latest review`, and a distinct `Active triage`. This avoids a global current branch becoming stale when the user switches branches and later returns.

Different branches support multiple PRs within one work. Local pre-PR review, later PR revisions and GitHub-agent feedback share one series only through verified repository/head-branch identity; GitHub feedback retains a verbatim paginated snapshot of the exact overall review URL/body when present and every comment URL, identity, context and unchanged text, plus retrieval time and target SHA. Exact user/current-session paths override index discovery. Resume follows per-branch Active triage; an explicit latest request follows Latest review; a mismatch or competing choice asks rather than overwriting state. If no Work-ID exists, propose and confirm one before creating the review-only work folder.

Behavior delta: replace conversation-only decisions with conversation plus verified durable events. Persist external/unsaved feedback before investigation; reuse code-review artifacts without copying; validate work/branch/source/target/queue on resume; append presented assessments, decisions, validations, commits, blockers, corrections and final summary. Preserve `review.md`; rely on the managed global Git exclude and never stage/commit artifacts. Persistence failure now pauses for an explicit continue-without-state decision. Shape remains one Markdown source plus one Markdown event log; JSON or a mutable status table was rejected because it duplicates truth and can diverge.

Static desk checks: switching branches resolves separate Active triage pointers; returning to a branch resumes its prior triage; a new review updates Latest without displacing Active triage; exact older review paths remain selectable; missing/malformed/target-mismatched indexes, detached heads and branch collisions ask instead of guessing; compaction resume reads both full files and reconstructs state; terminal completion clears only its branch pointer; failed append or staged `.agent-work/` blocks advancement; corrections append rather than erase history. File size is an accepted limitation and expected to remain small for normal review queues. These are static expectations, not runtime measurements.

Description optimization remains unchanged: durable persistence is not routing language. Existing should-trigger existing-feedback queries and should-not-trigger fresh-review queries remain accurate.

Validation for this change: `git diff --check` passed; dependency-free structural checks passed for frontmatter, balanced fences, portable paths, work/branch hierarchy, separate Latest review/Active triage state, GitHub verbatim snapshot marker, and branch-switch behavior. Shared live skill symlink resolves to this canonical directory. Strict-depth validation remains blocked by `ModuleNotFoundError: No module named 'yaml'`; nothing was installed. No runtime triage session was executed.

Created 2026-09-24. Class: workflow-process. Shared canonical root: `skills/dot-agents/skills/review-triage/`.

## Behavior delta and shape

Move the detailed one-by-one feedback workflow out of Pi SYSTEM.md into a shared skill. Preserve a global Pi router plus explicit per-item approval and fallback. Preserve original order and the user's evidence-backed rare-edge-case/value assessment. Add stale-comment handling, explicit decision transitions and failure status without expanding into discovery review. A later human-verified workflow requirement adds a commit checkpoint: each approved, validated fix must use the `commit` skill before triage investigates the next point.

Shape: one short sequential workflow with inline calibration examples; no scripts, dependencies or workers. The existing `commit` skill is a required action at the approved-fix checkpoint. SPEC.md captures scope/acceptance; this file stores maintenance provenance. At original extraction, general code-review remained unchanged; the later durable-artifact decision above intentionally co-updates both skills.

## Internet research

Inspected skills.sh before targeted discovery. Websearch failed (`fetch failed`); direct candidate/source retrieval succeeded. Closest inspected match: obra/superpowers receiving-code-review. Supplemented with Google Engineering Practices and Conventional Comments rather than another broad bug-finding skill. Nothing installed.

Observed listing: [receiving-code-review](https://skills.sh/obra/superpowers/receiving-code-review), 201.1K installs, 290.6K repository stars displayed. The pinned commit endpoint reports 2026-09-19T00:31:35Z; this is a commit timestamp, not independently verified latest push/activity. Metrics/badges are discovery context, not evidence of review quality or safety. No claim this is the best skill in the ecosystem.

## Source inventory

| Source | Trust / confidence | Contribution and usage constraints |
| --- | --- | --- |
| User requirements and pre-extraction `pi/dot-pi/agent/SYSTEM.md` review workflow | canonical local / high | Original order, per-item decision, rarity/value labels, shared placement, and human-verified per-fix commit checkpoint. Preserve safety rather than importing upstream fix authority |
| [obra/superpowers receiving-code-review](https://github.com/obra/superpowers/blob/5bf4e78011075bcfc0dc295f0724994cd123ee71/skills/receiving-code-review/SKILL.md), commit `5bf4e78011075bcfc0dc295f0724994cd123ee71` | canonical publisher / high for inspected text | Verify feedback, assess actual use/compatibility, technical pushback, correct mistaken assessment. Read complete SKILL.md and root LICENSE (MIT, Jesse Vincent 2025). Concepts independently formulated; no upstream file or substantial text/example copied |
| [Google review standard](https://google.github.io/eng-practices/review/reviewer/standard.html) | canonical guidance / high | Code health over perfection, factual evidence, optional polish. Live page, revision unpinned; no automatic approval imported |
| [Google handling comments](https://google.github.io/eng-practices/review/developer/handling-comments.html) | canonical guidance / high | Clarify request, reason about pros/cons, preserve useful context in code when needed. Live page; no automatic code change or human escalation requirement imported |
| [Conventional Comments](https://conventionalcomments.org/) | canonical project guidance / high | Distinguish issue/suggestion/question, blocking/nonblocking and minor-only value. Live page; source label is intent, not proof; no mandatory praise or upstream examples copied |
| [skills.sh](https://skills.sh/) and candidate listing above | secondary discovery / medium | Candidate and displayed metrics only; no executable instructions followed |
| Local `skill-writer` workflow and workflow-process example profile | canonical local / high | Minimal shape, contract, provenance, recovery, trigger checks and honest validation limits |
| Existing `skills/dot-agents/skills/code-review/SKILL.md` contract/scope sections | canonical local / high | Separate discovery from triage; preserve evidence and no-implied-fix-authority boundaries |
| Observed installed Pi 0.87.1 `docs/skills.md`; live directory/symlink inspection | canonical installed docs / high for inspected installation | Shared `~/.agents/skills` discovery, explicit skill invocation and reload. Did not establish which executable is active; no active-version compatibility claim |

## Adopted / rejected

- Adopt verification-before-action, explicit uncertainty, contextual pushback and correction of earlier mistakes from receiving-code-review.
- Reject its automatic implementation, priority reordering and assumption human feedback is technically correct; local approval/order rules take precedence.
- Narrow its unused-code/YAGNI heuristic: no local callers is not proof of no external/dynamic consumers, nor permission to remove code.
- Adopt Google's benefit/progress versus unnecessary polish distinction without treating all maintainability comments as taste.
- Adopt Conventional Comments' nonblocking distinction without accepting reviewer labels as validated severity.
- Preserve user-specific rare-edge-case labeling, but require evidence and separate frequency from serious consequences.
- Reject provider-specific APIs and extra orchestration; question-tool fallback makes the shared skill usable across runtimes.

Retrieval stopped because the closest receiving-feedback skill plus two complementary review standards cover verification, pushback, optionality and tradeoffs. Local policy supplies the strict interaction contract. More generic review checklists would not fill a remaining high-impact requirement. Future changes should record the failing example, source/evidence and resulting guidance change here.

## Coverage and desk checks

Selected profile: skill-writer `references/examples/workflow-process-skill.md`. Coverage is static inspection, not measured agent behavior.

| Dimension | Status | Evidence |
| --- | --- | --- |
| Preconditions and context | complete | Existing feedback/target required; current revision and stale locations checked |
| Ordered flow | complete | Queue -> verify -> assess -> present/wait -> authorized decision/action -> next |
| Safety and permission boundaries | complete | Per-item authorization; explicit batch scope; no production/install/publication authority |
| Output and acceptance | complete | Stable item fields, four choices, conversation plus append-only durable decision ledger, and final summary |
| Failure/recovery | complete | Missing source/tool, denied checks, validation failure, new broader fix scope and incompatible order |
| Handoff/escalation | complete | Specific missing evidence/decision requested; no implied remote issue or merge readiness |
| Examples | complete | Inline happy-path low-value skip; serious-risk guard; false-positive correction; inaccessible-evidence recovery |

Should trigger: "go through these review points one by one", "which comments are worth fixing?", "is this finding just a rare edge case?", "triage the bot's feedback", "address these review comments", "walk through your previous findings".

Should not trigger: "review this new PR", "find security bugs in this diff", "debug this production incident", "implement a feature", "summarize review best practices".

Description explicitly says existing feedback, one point at a time and decision value; excludes discovering fresh findings. Shared/provider-neutral wording replaces the initial Pi-only placement proposal.

| Desk case | Expected behavior / before-after delta |
| --- | --- |
| Confirmed very rare cosmetic issue; complex repair | Preserve explicit not-necessary-to-fix recommendation; ask, do not auto-skip |
| Duplicate charge path; frequency unknown | Preserve serious-impact exception; recommend fix without guessed probability |
| No local call sites but external contract exists | Improved explicit guard against false unreachable/unused claims |
| Reviewer cites code already fixed | Improved stale-target revalidation; recommend skip as resolved with evidence |
| Required source unavailable | Explicit gap and investigate/defer decision; no invented fix |
| User chooses discuss | Remain on current point; no edits |
| User approves item 1 | Only item 1 changes; validate it, commit it through the `commit` skill, and report hash/title before advancing |
| Test fails after authorized edit | Do not mark verified, commit, or silently advance; report blocker |
| Commit is blocked or fails | Keep the current item active; resolve the commit or obtain an explicit defer decision before investigating the next point |
| User says fix all | Waive per-item prompts only; verify and commit each accepted fix before investigating the next, and report exclusions/blockers |
| Skill unavailable in Pi | Global approval safeguards remain; evidence-backed fallback |
| Ordinary new PR review | Discovery skill, not automatic interactive triage |

## Registration and validation

- Created approved canonical-source symlinks under `~/.agents/skills/review-triage` and `~/.claude/skills/review-triage`; Python resolved both to the shared repo directory. Pi uses shared discovery; no Pi-only copy or settings change.
- `git diff --check -- pi/dot-pi/agent/SYSTEM.md skills/dot-agents/skills/review-triage`: passed, no output.
- Dependency-free Python structural check: PASS for three skill files, scalar frontmatter, 77-line body, output fields, whitespace/fences, portable skill paths, two canonical symlinks and thin Pi router. Not full YAML/depth or runtime evaluation.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/review-triage --skill-class workflow-process --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependency installed.
- Re-read runtime skill and Pi router; desk cases above inspected only. Interactive discovery/behavior not executed.
- User follow-up strengthened confirmation into an explicit claim-by-claim evidence rule, including impact and validation results; recommendations/estimates remain labeled judgments. Re-ran structural checks and git diff whitespace validation successfully.
- Human-verified fix example: an approved triage repair was at risk of remaining only in the working tree while the queue advanced. The workflow now treats Fix approval as authority for one focused local commit, requires the `commit` skill after validation, blocks advancement on commit failure/ambiguity, and preserves one commit per fixed item even under batch authorization. Static replay expects unchanged skip/defer/discuss behavior and a new implementation -> validation -> commit -> next-item sequence.

## Open gaps

- Run the strict validator in an already available compatible Python/PyYAML environment; no installation authorized.
- Inspect runtime discovery after reload and exercise representative triage conversations before claiming trigger/adherence performance.
- Runtime-specific tool permissions still apply; shared instructions do not grant cross-runtime access.
