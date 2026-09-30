# Review Triage Sources and Decisions

## Durable source and append-only progress decision

User approved work-local branch series: `.agent-work/work/<work-id>/reviews/<branch-key>/<review-id>/`, with immutable `review.md` and separate append-only `triage.md`. A root review index catalogs branches; each branch index tracks exact branch/repository/PR metadata, newest-first history, `Latest review`, and a distinct `Active triage`. This avoids a global current branch becoming stale when the user switches branches and later returns.

Different branches support multiple PRs within one work. Local pre-PR review, later PR revisions and GitHub-agent feedback share one series only through verified repository/head-branch identity; GitHub feedback retains a verbatim paginated snapshot of the exact overall review URL/body when present and every comment URL, identity, context and unchanged text, plus retrieval time and target SHA. Exact user/current-session paths override index discovery. Resume follows per-branch Active triage; an explicit latest request follows Latest review; a mismatch or competing choice asks rather than overwriting state. If no Work-ID exists, propose and confirm one before creating the review-only work folder.

Behavior delta: replace conversation-only decisions with conversation plus verified durable events. Persist external/unsaved feedback before investigation; reuse code-review artifacts without copying; validate work/branch/source/target/queue on resume; append presented assessments, decisions, validations, commits, blockers, corrections and final summary. Preserve `review.md`; never stage/commit/ignore artifacts. Persistence failure now pauses for an explicit continue-without-state decision. Shape remains one Markdown source plus one Markdown event log; JSON or a mutable status table was rejected because it duplicates truth and can diverge.

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
| Ordered flow | complete | Queue → verify → assess → present/wait → authorized decision/action → next |
| Safety and permission boundaries | complete | Per-item authorization; explicit batch scope; no production/install/publication authority |
| Output and acceptance | complete | Stable item fields, four choices, conversation plus append-only durable decision ledger, and final summary |
| Failure/recovery | complete | Missing source/tool, denied checks, validation failure, new broader fix scope and incompatible order |
| Handoff/escalation | complete | Specific missing evidence/decision requested; no implied remote issue or merge readiness |
| Examples | complete | Inline happy-path low-value skip; serious-risk guard; false-positive correction; inaccessible-evidence recovery |

Should trigger: “go through these review points one by one”, “which comments are worth fixing?”, “is this finding just a rare edge case?”, “triage the bot's feedback”, “address these review comments”, “walk through your previous findings”.

Should not trigger: “review this new PR”, “find security bugs in this diff”, “debug this production incident”, “implement a feature”, “summarize review best practices”.

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
- Human-verified fix example: an approved triage repair was at risk of remaining only in the working tree while the queue advanced. The workflow now treats Fix approval as authority for one focused local commit, requires the `commit` skill after validation, blocks advancement on commit failure/ambiguity, and preserves one commit per fixed item even under batch authorization. Static replay expects unchanged skip/defer/discuss behavior and a new implementation → validation → commit → next-item sequence.

## Open gaps

- Run the strict validator in an already available compatible Python/PyYAML environment; no installation authorized.
- Inspect runtime discovery after reload and exercise representative triage conversations before claiming trigger/adherence performance.
- Runtime-specific tool permissions still apply; shared instructions do not grant cross-runtime access.
