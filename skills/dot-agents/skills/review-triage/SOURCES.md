# Review Triage Sources and Decisions

Created 2026-09-24. Class: workflow-process. Shared canonical root: `skills/dot-agents/skills/review-triage/`.

## Behavior delta and shape

Move the detailed one-by-one feedback workflow out of Pi SYSTEM.md into a shared skill. Preserve a global Pi router plus explicit per-item approval and fallback. Preserve original order and the user's new evidence-backed rare-edge-case/value assessment. Add stale-comment handling, explicit decision transitions and failure status without expanding into discovery review.

Shape: one short sequential workflow with inline calibration examples; no scripts, dependencies, workers or runtime references needed. SPEC.md captures scope/acceptance; this file stores maintenance provenance. General code-review remains unchanged.

## Internet research

Inspected skills.sh before targeted discovery. Websearch failed (`fetch failed`); direct candidate/source retrieval succeeded. Closest inspected match: obra/superpowers receiving-code-review. Supplemented with Google Engineering Practices and Conventional Comments rather than another broad bug-finding skill. Nothing installed.

Observed listing: [receiving-code-review](https://skills.sh/obra/superpowers/receiving-code-review), 201.1K installs, 290.6K repository stars displayed. The pinned commit endpoint reports 2026-09-19T00:31:35Z; this is a commit timestamp, not independently verified latest push/activity. Metrics/badges are discovery context, not evidence of review quality or safety. No claim this is the best skill in the ecosystem.

## Source inventory

| Source | Trust / confidence | Contribution and usage constraints |
| --- | --- | --- |
| User requirements and pre-extraction `pi/dot-pi/agent/SYSTEM.md` review workflow | canonical local / high | Original order, per-item decision, rarity/value labels, shared placement. Preserve safety rather than importing upstream fix authority |
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
| Output and acceptance | complete | Stable item fields, four choices, conversation decision ledger and final summary |
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
| User approves item 1 | Only item 1 changes; tests/result reported before advancing |
| Test fails after authorized edit | Do not mark verified or silently advance; report blocker |
| User says fix all | Waive per-item prompts only; verify findings and report exclusions/blockers |
| Skill unavailable in Pi | Global approval safeguards remain; evidence-backed fallback |
| Ordinary new PR review | Discovery skill, not automatic interactive triage |

## Registration and validation

- Created approved canonical-source symlinks under `~/.agents/skills/review-triage` and `~/.claude/skills/review-triage`; Python resolved both to the shared repo directory. Pi uses shared discovery; no Pi-only copy or settings change.
- `git diff --check -- pi/dot-pi/agent/SYSTEM.md skills/dot-agents/skills/review-triage`: passed, no output.
- Dependency-free Python structural check: PASS for three skill files, scalar frontmatter, 77-line body, output fields, whitespace/fences, portable skill paths, two canonical symlinks and thin Pi router. Not full YAML/depth or runtime evaluation.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/review-triage --skill-class workflow-process --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependency installed.
- Re-read runtime skill and Pi router; desk cases above inspected only. Interactive discovery/behavior not executed.
- User follow-up strengthened confirmation into an explicit claim-by-claim evidence rule, including impact and validation results; recommendations/estimates remain labeled judgments. Re-ran structural checks and git diff whitespace validation successfully.

## Open gaps

- Run the strict validator in an already available compatible Python/PyYAML environment; no installation authorized.
- Inspect runtime discovery after reload and exercise representative triage conversations before claiming trigger/adherence performance.
- Runtime-specific tool permissions still apply; shared instructions do not grant cross-runtime access.
