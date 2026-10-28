# Code Review Sources and Decisions

## Additive code-quality iteration from saved review outcomes

User approved implementation after the six-history retrospective, with the explicit constraint: "do not remove/ignore existing points" and "add code quality, not change some points for anopther". Preserve all existing runtime guidance, examples, dimensions, workers, rounds, safety and readiness rules; add observable checks where earlier broad guidance did not produce enough evidence. No existing rule is replaced or narrowed in this iteration.

Class/profiles: security-review + workflow-process; skill-writer `references/examples/security-review-skill.md` and `references/examples/workflow-process-skill.md`. Shape: additive inline checks and packet/output requirements in the existing workflow, plus cases in the already-routed examples reference. No new reference, script, dependency, role or registration is needed. Existing ownership/pattern/scenario/re-review rules remain; the delta is concrete semantic reuse and contract evidence, same-identity action contrasts, and repair-surface closure rather than another general review checklist.

### Evidence and example intake

Provenance: user-selected saved local/GitHub review histories for booqable/booqable PRs #19387, #19513, #19587, #19798, #19939 and #19977; historical application source inspected read-only at pinned commits. Trust tier: mixed human feedback and saved agent artifacts, with representative static source verification; comments and earlier triage conclusions are not independently true by default. Transformed runtime examples are anonymized synthetic cases, not copied application source or measured agent outcomes.

| Label / kind / origin | Provenance pointer | Intake and supported delta |
| --- | --- | --- |
| Negative / edge-case / mixed | [#19387 review 5441194187](https://github.com/booqable/booqable/pull/19387#pullrequestreview-5441194187); local review `ce8aa9c823`, human revision `21446cc0b6` | Earlier review checked individual refresh repairs while duplicate authority/repair obligations remained. Preserve the ownership checks already added in the earlier iteration; require concrete reuse/contract evidence, not another ownership slogan. |
| Positive + negative / fix / mixed | [#19587 review 5487072370](https://github.com/booqable/booqable/pull/19587#pullrequestreview-5487072370); local review `fcedba2`, repair `5777539f82` | Incorrect root-cause claim already caught locally; migration comment fixed but PR claim remained. Closure must cover every affected representation; do not count this as a new discovery miss. Invoice-selector concern was already inspected and matched test purpose, not a confirmed regression. |
| Negative / regression / mixed | [#19939 comment 4359252494](https://github.com/booqable/booqable/pull/19939#discussion_r4359252494); local `c4e1c5a8`, human `d3845d7e` | Producer kept an addition timestamp but exposed only line ID; consumer reveal/scroll depended on ID. Same-line repeat behavior present at local review was not reported. Add repeated-action contrasts and discriminating assertions. |
| Negative / fix / mixed | [#19977 comments 4397750268 and 4397750275](https://github.com/booqable/booqable/pull/19977#pullrequestreview-5678911832); local `4fd6febd`, human `05b717f6`, repair `ed5287856c` | Existing barcode lookup was inspected as consistent while parallel request remained; require semantic reuse decision. Missing safety explanation arose after initial review when a repair introduced `safety_assured`; require newly applicable rule checks, not false earlier-miss attribution. |
| Positive / true-positive + false-positive / mixed | Same #19977 review; local `4fd6febd`, human `05b717f6` | Three local rounds already caught duplicated booking rules. Backend order lock plus planning inference countered the later duplicate-planning premise. Preserve independent counterevidence, safety tracing and correct attribution. |
| Unscored / edge-case / mixed | #19513 saved local review `2ec5e3bf9c`; #19798 saved human review `6f6b062f` | No established pre-human local baseline for either history. Do not compute misses from absence of artifacts or use every human preference as a defect label. |

Historical rubric inspection: ownership/recurrence additions already landed in dotfiles commit `1c4837a`; independent rounds and simplicity changes were also present by the later reviews. More rounds or another overlapping worker are not justified by these cases. Artifacts do not establish exact historical worker packets or model-level causes. Further source collection stops here: the pinned evidence supports these bounded deltas, while application fixes, harness changes and a quantitative benchmark are outside this update.

### Qualitative replay and trigger expectations

Desk comparison only, not observed review runs or measured accuracy. Working cases informed the additions. Transfer probes below are synthetic holdout-style checks not used as historical source evidence; they are not an independent empirical holdout or assurance against overfitting.

| Slice / representative prompt | Before -> after expectation | Desk outcome |
| --- | --- | --- |
| Working: review a parallel lookup beside an existing one | General pattern comparison -> explicit paths, scope/encoding/effect comparison, complete-result/caller checks and reuse/separation decision | Improved specificity |
| Working: repeated add to same row before marker expiry | General time/state checks -> unchanged-ID event trace and second reveal/scroll assertion | Improved specificity |
| Working: code comment fixed but PR claim stale; repair adds safety bypass | Generic re-review -> affected-surface closure and newly activated rule, attributed to correct revision | Improved specificity |
| Working negative: backend serializes planning inference | Existing counterevidence requirement retained -> suppress unsupported duplicate-record claim; assess inaccurate rationale separately | Unchanged safeguard |
| Transfer probe: cache refresh requested twice for same document, second while first pending | General concurrency check -> distinguish refresh-operation identity from document identity, trace cancellation/coalescing and consumer effects | Improved specificity |
| Transfer negative: replayed payment uses a stable idempotency key | Preserve required deduplication; no fresh charge solely to force a repeated UI effect | Unchanged safeguard |
| Transfer negative: similar query has narrower permissions/page limits; external caller reads result | Preserve separation and consumed API; missing caller evidence remains a gap | Unchanged safeguard |
| Preservation: ordinary review, security-only request, failed worker, unavailable prior revision | Existing scope, all findings, safety, failure handling and readiness rules retained; no old checks sacrificed | Unchanged contract |

Description remains verbatim in frontmatter: execution depth changes, not invocation. Should trigger: "review this PR", "audit code quality in this diff", "thermos review", "verify this completed fix". Should not trigger: "implement this feature", "deploy this branch", "explain this API", "debug this initial failure" without a review request. No classifier run or description change is needed by desk inspection.

Profile coverage: existing vulnerability classes, exploit prerequisites, false-positive controls, severity and remediation remain; new safe reuse/idempotency/locking variants supplement them. Workflow preconditions, ordered dispatch, bounded permissions, output and failure handling remain; new code-quality/scenario/closure coverage requires concrete evidence or explicit gaps. API-depth rubric is inapplicable: this is neither an integration API guide nor a skill-authoring runtime.

Validation for this iteration:
- `git diff --check -- skills/dot-agents/skills/code-review`: passed.
- User-approved read-only `python3 -` checks against Git HEAD: passed. All original lines retained in order across the five changed files, zero deletions, unchanged frontmatter/description, original review dimensions/counts/safety/severity, all 14 original cases plus 3 additions, 29 SPEC criteria, reference/anchor targets, fences/whitespace, portable runtime paths, ASCII additions, packet routing/blind isolation and existing shared/Claude symlinks checked. No registration changes or unrelated WIP edits.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. The selected interpreter is Python 3.9.6, also below the script's declared Python 3.12+ requirement. Nothing installed. Structural checks are not a strict YAML/depth pass.
- Final diff read against the approved additive scope; qualitative cases above are guidance-only desk checks, not observed model/application runs or measured recall improvement.

Remaining gaps: run strict validation in an approved existing Python 3.12+/PyYAML environment. Desk expectations do not establish runtime recall, precision, cost or worker adherence. Next empirical step, if requested: freeze old/new guidance and permissions, keep feedback hidden during discovery, score correct-revision valid findings and false positives, then confirm on unseen PRs.

## Dedicated whole-change simplicity worker

User-approved follow-up on 2026-10-22: adopt only the remote workflow's dedicated simplicity perspective; explicitly defer spec sharding, one-worker-per-rule fan-out and verifier swarms. Normal and quick full-dimension reviews run one whole-change simplicity worker outside the sampled rounds. Explicitly narrowed reviews omit it unless requested. Default full-review discovery count becomes 10: 2 rounds x 4 dimensions, one intent-blind worker and one simplicity worker.

External pattern inspected read-only at private repository `booqable/local-spec-code-review`, pinned revision `c80707a4caeca397e31c2d9556385b27edd8dca8`: `plugins/local-spec-review/agents/review-simplicity.md`, `skills/run/references/fan-out.md` and `principles/simpler-with-a-smaller-scope.md`. Trust tier: secondary external implementation. Confidence: high for retrieved instructions at the pin, not for effectiveness; repository labels itself pre-alpha. Usage constraints: concept evidence only, no source text copied, no license inferred and no lineage claim.

Behavior delta: add `code-review-simplicity` as a focused Pi agent and route it from `references/review-rounds.md`. It reads confirmed requirements/non-goals and the complete pinned change, asks whether optional capability/variation/generality can be removed or deferred or an established approach can eliminate a substantial new subsystem, and reports at most three proposals with removed concepts, evidence/counterevidence, user/business cost and migration/regression boundary. It does not duplicate code health's internal ownership/lifecycle redesign, execute shared checks, assign severity or count as round agreement. The coordinator verifies every requirement-preserving proposal before classifying it. A proposal contradicting a confirmed requirement is only an optional scope challenge requiring explicit user approval, never a finding/readiness input. Required security, tenancy, money, data-integrity, availability, migration, rollback and compatibility behavior cannot be removed merely for fewer lines.

Shape: one additional parallel specialist outside rounds; no new runtime reference, script or dependency. A missing specialist uses a general worker with the same focused packet; blocked simplicity coverage prevents READY for a full review. Description remains unchanged because simplicity is mandatory review depth, not a separate invocation trigger.

Qualitative desk evaluation only: generic provider framework exceeds confirmed single-provider acceptance -> reuse direct established integration and remove plugin subsystem; optional requested variant -> separate scope challenge requiring user approval, not a finding; compatibility state required by live old payloads -> no unsafe cut; deliberate minimal implementation -> `No significant simplicity cut`; internal state ownership or local helper/style issue -> left to code health; unavailable worker -> focused general fallback then unchecked/INCOMPLETE if blocked. Expected: stronger whole-change scope challenge without remote swarm cost or duplicate structural review. No runtime benchmark establishes usefulness, false-positive rate, latency or token cost.

Selected class/profile remain security-review + workflow-process and skill-writer `references/examples/workflow-process-skill.md`. Coverage: preconditions, full/narrow applicability, pinned inputs, safety exclusions, deterministic output, fallback, candidate verification and happy/robust/anti-pattern examples are complete by desk inspection. Validation: targeted `git diff --check` passed; two focused read-only code-health audits found and drove fixes for requirement-violating cuts and overlap with internal ownership/lifecycle review; final audit returned no actionable findings and confirmed default `2x4+2 = 10` counting. Strict-depth `quick_validate.py` was attempted with the security-review class and blocked by `ModuleNotFoundError: No module named 'yaml'`; nothing installed. No runtime review or benchmark ran. Retrieval stopped after the remote simplicity agent, fan-out contract and principle established the distinct whole-change role; the user explicitly rejected the remaining remote fan-out ideas.

## Independent review rounds and intent-blind sampling

User-approved change on 2026-10-22: normal full reviews default to 2 independent samples of each existing review dimension, announce round/worker cost before dispatch, and start without another confirmation. Explicit counts 1 through 3 override the default; a quick full-dimension or explicitly narrowed review defaults to 1; invalid explicit counts require correction. Run one intent-blind worker outside the rounds for full reviews, including quick full-dimension reviews; explicitly narrowed reviews omit it unless requested. Spec mapping, docs/history, checks and verification remain single-run work. Exclude sibling-repository verification by explicit user decision.

External candidate inspected read-only at private repository `booqable/local-spec-code-review`, pinned revision `c80707a4caeca397e31c2d9556385b27edd8dca8`. Relevant files: `plugins/local-spec-review/skills/run/SKILL.md`, `skills/run/references/fan-out.md`, `skills/run/references/verify-claims.md`, `agents/review-blind.md`, `agents/review-spec-fidelity.md`, `skills/run/references/triage.md` and `skills/run/references/walk.md`. Trust tier: secondary external implementation. Confidence: high for retrieved instructions at the pinned revision; low for effectiveness because its README labels the plugin pre-alpha and its manual-verification ticket remained ready-for-human. Usage constraints: private source used as pattern evidence only; no source text or implementation copied, no license inferred, and no claim of shared lineage.

Behavior delta: replace one worker per dimension with 1-3 independent review rounds, default 2, while retaining the same four dimensions and all existing evidence/severity/readiness rules. Add `references/review-rounds.md` for conditional runtime depth and `code-review-blind` as the isolated Pi role. Tag candidates by round/dimension, merge only identical trigger/behavior/root-cause/remedy, verify every unique claim once, and report `found by x/N rounds`. Agreement affects confidence/tie-breaking only; it is never factual evidence, a vote threshold or a severity multiplier. Sampled workers propose checks while the coordinator executes shared validation once. Missing required sample/applicable blind coverage remains unchecked and prevents READY. Do not substitute a general worker whose standing instructions require reading selected work documents for the blind role.

Rejected remote behavior: destructive branch-local `--fresh` history, first-hit spec authority without confirmation, mutable-HEAD substitution, auto-accepted fixes, background concurrent cherry-pick/revert orchestration, ambiguous-decision interpretation, execution of auto-discovered shell commands, sibling-checkout scanning and rarity claims without representative evidence. Preserve local immutable review artifacts, append-only triage, permissions, pinned scope, explicit fix decisions and evidence-backed likelihood.

Class: security-review + workflow-process. Shape: parallel workers with pinned shared input, a bounded return schema, merge rule and missing-dimension-worker fallback; one conditionally loaded rounds reference; one harness-specific isolated blind role. Selected synthesis profile: skill-writer `references/examples/workflow-process-skill.md`. Coverage: preconditions, ordered dispatch, permission boundaries, outputs, failure fallback, escalation/handoff and happy/robust/anti-pattern cases are represented in runtime guidance and `references/review-examples.md`. No script or dependency added.

Description retained: round count is execution configuration, not a new invocation category. Should trigger remains code/PR/diff review, edge-case search, thermos audit and completed-fix verification. Should not trigger remains implementation, deployment, API explanation and initial diagnosis without a review request.

Qualitative desk evaluation only: normal review -> announces 2 rounds and 10 discovery workers; `rounds=1` full review -> 4 sampled workers plus blind and simplicity; invalid `rounds=4` -> correction request; repeated claim -> one verified finding with round attribution; one-round-only claim -> retained when supported; repeated unsupported claim -> dropped after verification; failed second sample -> fallback then unchecked/INCOMPLETE if still blocked; round 2 given round 1 findings -> contract violation; blind scope filters intent-document paths before launch; blind worker exposed to spec/PR rationale -> stops without findings and reports unchecked. Expected behavior is more explicit and potentially higher recall; no runtime benchmark establishes recall, precision, latency or token cost.

Validation: `git diff --check -- skills/dot-agents/skills/code-review pi/dot-pi/agent/agents/code-review-blind.md` passed. Canonical shared/Claude code-review links and the Pi agents-directory symlink resolve to this repository; the active task registry exposed `code-review-blind`. Strict-depth `quick_validate.py` was attempted with `--skill-class security-review --strict-depth` and blocked at startup by `ModuleNotFoundError: No module named 'yaml'`; nothing installed. Three focused read-only code-health audits found and drove fixes for blind identity leakage, invalid general-worker blind fallback, duplicate validation execution, narrowed-review applicability and contamination handling; final audit returned no actionable findings. No runtime review or behavior benchmark ran.

Retrieval stopped after the pinned coordinator, fan-out, verification, blind-worker, triage and walk contracts exposed the sampling, deduplication, failure and mutation semantics needed for this change. Further remote hook/profile retrieval would be low-yield because progress UI and repository profiles are outside the approved implementation.

## Ownership and recurrence iteration

User-approved improvement from [human review 5441194187](https://github.com/booqable/booqable/pull/19387#pullrequestreview-5441194187), pinned application revision `21446cc0b6eb0bd72ccb3cd33a98e0aa30988391`. Inspected the overall body and six inline comments, including the user-selected local verbatim snapshot, plus pinned refresh, panel-state, selector, stock-chip and cleanup source. Trust: human-authored feedback with mixed static verification; not every proposed remedy is proven. Original automated-review execution was not inspected, so missed findings cannot be attributed to a particular worker or historical skill version.

Intake: negative/maintenance examples for distributed repair callbacks, synchronized state, duplicated selection policy, optional internal contracts and mode-dependent lifecycles; edge-case questions for cleanup/deletion and responsive capability loss; localization and locator feedback. Transform into generic synthetic calibration cases, not copied application code or an assertion that all human comments are confirmed defects.

Behavior delta: replace broad structural bullets with owner/derived-state/writer tracing, recurring-fix analysis, semantic-predicate and caller-contract comparisons, and lifecycle separation with continuity checks. Require source-backed ownership coverage even with no findings. Extend existing UI/test checks for mounting x viewport visibility, configurable terminology, semantic locators and cleanup triggers/test timing. Route the existing examples reference for these change shapes. No new worker, script, dependency or reference file; retain the four-pass workflow and all previous review dimensions, safety, severity and evidence requirements.

Preservation constraint: retain layers/coupling, naming, type/nullability and cast/optionality checks, dependency direction/navigability, wrapper/special-case and shared-layer leakage scrutiny, simplification, producer/schema invariants, trust-boundary validation, atomicity/sequencing, migration/test boundaries and the nonmechanical file-size signal. Retain failure propagation, observability, cleanup/recovery and justified fallback/cancellation checks. Existing calibration cases remain unchanged; new cases supplement them. This strengthens execution and coverage evidence, not scope or permissions.

### Qualitative replay expectations

Desk comparison only; no observed agent run or measured recall improvement. Working examples derive from the supplied feedback; transfer probes are synthetic and were not used as source evidence.

| Prompt/case | Before -> after guidance expectation | Desk outcome |
| --- | --- | --- |
| All previously missed refresh callbacks now repaired | Generic ownership scrutiny -> investigate distributed obligations without resurrecting fixed bugs | Improved specificity |
| Repeated mode flag governs fetch/reset/render | Generic simplification -> compare lifecycles and retain pending/focus/error continuity | Improved specificity |
| Copied selector / optional internal callback | Generic duplication/types -> compare semantic predicates and actual caller guarantees | Improved specificity |
| Deferred save added for one unmount reason | Generic concurrency/cleanup -> enumerate deletion/navigation/identity triggers and timing shortcuts | Improved specificity |
| Replacement UI hidden at a breakpoint | Generic UI checks -> cross ancestor mounting with reachable capabilities; unknown intent stays a question | Improved specificity |
| Legitimate draft, optional shared callback, existing canonical invalidation | Preserve counterevidence and safe boundaries; suppress unjustified centralization/guard removal | Unchanged safeguards, more explicit examples |
| Transfer probe: background job duplicates a cache-repair obligation | Same owner/writer procedure applies without React or UI assumptions | Improved specificity |
| Transfer probe: repeated permission guards at distinct trust boundaries | Preserve required validation; repetition alone does not establish removable duplication | Unchanged safeguard |

Description retained verbatim: this changes review execution, not invocation. Should trigger: "review this PR", "audit this diff for maintainability", "thermos review", "verify this completed fix". Should not trigger: "implement this panel", "deploy this branch", "explain this hook", or initial incident diagnosis without a review request. Manual trigger inspection found no reason to broaden or narrow the existing description; no classifier benchmark run.

Validation:
- `git diff --check -- skills/dot-agents/skills/code-review`: passed.
- Approved read-only `python3 -` checks against Git HEAD: passed for unchanged frontmatter, dispatch, scope/docs/history, security, comment-quality, severity, persistence, existing non-UI coverage rows, nine original examples, unaffected SPEC criteria and historical provenance. Checked retained structural/failure-handling dimensions, reference/anchor targets, Markdown structure, line limit and canonical/live symlinks. The first checker run overran a subsection boundary (`AssertionError: Comment quality and AI-style clutter`); corrected heading parsing and reran successfully, with no product-guidance change needed.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. Nothing installed. Structural checks are not a strict-depth pass or a behavioral benchmark.

Remaining limits: no original-run causal proof, no runtime application reproduction or blind behavior benchmark; desk expectations do not establish recall. Class remains security-review + workflow-process; integration-documentation and skill-authoring API-depth rubrics are inapplicable. Existing registrations and specialized-worker names remain unchanged.

## Comment-quality decision

User-directed behavior delta: make the code-health pass critical of added or changed comments and docstrings that resemble generated clutter. Judge content rather than guessing authorship. Replace the implicit generic maintainability treatment with explicit decisions: remove narration, duplication and transient history that offer no durable rationale; trim useful but wordy comments to the shortest precise explanation; preserve required API documentation, external constraints, invariants and safety reasoning. Convert useful API-contract content to JSDoc when discoverability, editor tooling, type guidance or generated documentation gains concrete value; keep implementation rationale inline. Keep the existing concrete-cost bar, group repeated instances, and reject tone-only findings. Inline guidance is sufficient; no script, dependency or new reference is justified.

Desk cases: a comment repeating the next assignment is removed; a multi-paragraph comment with one non-obvious compatibility reason is reduced to that reason; required public API documentation remains; useful function-contract guidance moves from an inline comment to JSDoc when editor/tooling consumers benefit; implementation rationale stays inline; a long safety explanation is shortened only when its conditions and consequences remain intact; uncertain authorship is not labeled AI-generated. These are static expectations, not measured review runs.

Validation: `git diff --check` passed, the canonical/live skill structure and new runtime/SPEC markers were found, and manual desk cases passed. Strict-depth validation was attempted and blocked by `ModuleNotFoundError: No module named 'yaml'`; no dependency was installed.

Description optimization remains unchanged: users still invoke this through code/PR/diff review requests, not a separate comment-polishing trigger.

## Focused GitHub source excerpts

Human-verified negative example (2026-09-30): a persisted GitHub review copied raw API `diff_hunk` values. Comments on newly added files repeated every line from file start through the anchor, while GitHub displayed only the annotated range. The saved artifact retained path, line range, side, revision, URL and unchanged comment body, so the extra patch context added substantial runtime tokens without adding comment identity.

Behavior delta: preserve the exact annotated source line or multi-line range for each inline comment, labeled with path/lines/side/revision, but exclude raw `diff_hunk`, patch and surrounding lines from `review.md`. Provider context may be used transiently to recover the selected lines; inaccessible source is reported rather than replaced by a full hunk. Keep exact overall/comment bodies and embedded code unchanged. This narrows existing persistence guidance; no script or new artifact is justified.

Static replay: the reported multi-line case retains only its selected range; a single-line comment retains one line; a left-side/outdated comment requires the matching side/revision; inaccessible source records a gap; code blocks written inside the comment remain verbatim. Expected result: reduced snapshot size with unchanged reviewer feedback and stronger anchor precision. This is a desk check, not a runtime review measurement.

Validation (2026-09-30): targeted `git diff --check` passed. Manual structural checks passed for frontmatter, required files, portable paths and the canonical live-skill symlink. Strict-depth `quick_validate.py` was attempted and blocked by `ModuleNotFoundError: No module named 'yaml'`; no dependency was installed.

## Durable review artifact decision

User approved durable review history inside confirmed work: `.agent-work/work/<work-id>/reviews/<branch-key>/<review-id>/`. If no work exists, propose and confirm a stable Work-ID, then create a review-only work directory without forcing spec/plan files. Each exact branch has a sanitized series folder (`/` -> `--`), branch `index.md`, immutable per-run `review.md`, and on-demand append-only sibling `triage.md`. The work's `reviews/index.md` is a branch catalog, not a mutable current-branch selector.

Branch identity handles one work spanning several PRs: different branches are separate series; local pre-PR review, later PR revisions and imported GitHub feedback remain in the same verified branch series. Each branch index tracks `Latest review` separately from `Active triage`, so branch switching and a newly completed review cannot silently move an in-progress triage. Exact branch names, repository/PR metadata, aliases and links remain in indexes; detached, renamed or colliding identities require confirmation.

Behavior delta: replace the prior rejected blanket "force report-file writes" rule with one narrow, user-authorized local artifact write after synthesis. Preserve the no-application-edit contract, rely on the user-approved managed global exclude for `.agent-work/`, never stage/commit it, stop on already-staged artifacts, redact sensitive content, verify saved content and links, and disclose partial persistence without changing the technical verdict. Shape remains inline workflow guidance; no script, dependency, JSON state, symlink, global Active review, or separate reference is justified.

Static desk checks: two reviews in one second receive a collision suffix; a new completed review updates only its branch's Latest review while older history and Active triage remain; switching checked-out branches resolves another branch index; a rerun never edits prior `review.md`; pre-PR and PR review share verified branch identity; another PR branch remains separate; GitHub feedback records a verbatim paginated snapshot of the exact overall review URL/body when present and every comment URL, identity, context and unchanged text, plus retrieval time and target SHA under the PR head branch; a saved-but-unindexed review is reported but not treated as latest; malformed indexes, detached heads and branch-key collisions cause clarification; strict no-write and staged-artifact cases disclose blocked persistence. These are guidance inspections, not executed runtime review sessions.

Description optimization remains unchanged: persistence is an execution detail, not a trigger. Existing should-trigger review/PR/diff queries and should-not-trigger implementation/deployment queries remain accurate.

Validation for this change: `git diff --check` passed; dependency-free structural checks passed for frontmatter, balanced fences, portable paths, work/branch hierarchy, separate Latest review/Active triage state, GitHub verbatim snapshot marker, and branch-switch behavior. Shared live skill symlink resolves to this canonical directory. Strict-depth validation remains blocked by `ModuleNotFoundError: No module named 'yaml'`; nothing was installed. No runtime review session was executed.

Original synthesis: 2026-07-08. Research and primary-review redesign: 2026-09-24.

## Local For Real consolidation

User approved absorbing `for-real` into `code-review`, including explicit checks that requirements were implemented. Inspected source: former `for-real/SKILL.md` and `SOURCES.md`; recorded local history `f1ff2f87ff72e170bf897326c1a6f60b64cc308e`. Trust: canonical local; high confidence in instruction content, not measured effectiveness. No verified external original exists; do not invent an upstream URL or synchronization claim.

Replace overlapping verification guidance rather than add a workflow: retain target/diff scrutiny, independent expectations, actual checks, exact evidence and blocked prerequisites. Extend existing requirements/docs and validation sections with source-to-behavior/check mappings, missing/surplus scope, API/config existence checks and browser verification boundaries. Keep the four-pass shape and readiness output. No new dependencies or wrappers.

Deliberately reject former implicit repair authority: prior implementation approval alone does not authorize fixing findings in this review. Explicit per-finding or explicit batch authorization remains required, followed by verification on the changed revision. Narrow verification requests retain scope limits, not whole-change readiness. "For real" and "verify completed fix" should trigger; initial diagnosis and test-first implementation should not.

Static calibration case added to `references/review-examples.md`: independently sourced expiry requirement contradicts code and passing tests; missing intent stays unverified; missing required browser checks prevent READY. Sources are user decisions, referenced specs and applicable established contracts - not inferred implementation intent. This is desk evaluation, not an executed product review or measured model benchmark.

Retire the canonical `for-real` skill and its verified shared/Claude links. Validation results for this merge are recorded separately below; Thermos and earlier validation entries are historical, not proof of this change. Stop source collection here: the local contracts and explicit user decision suffice; external ancestry remains unknown.

### For Real merge validation

- Removed the canonical directory and both verified live symlinks. Existing shared/Claude code-review links still resolve to the canonical directory.
- Dependency-free `python3 -c` checks passed: requirement mapping, triggers, approval boundary, four-pass routing, reference existence, registration/removal state, whitespace and fenced blocks. Repository search found only historical/provenance references to `for-real`, not a remaining runtime dependency.
- `git diff --check -- skills/dot-agents/skills/code-review skills/dot-agents/skills/for-real skills/UPSTREAM.md`: passed, no output. Python also checked ignored skill-file whitespace.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`. Nothing installed; strict validation remains blocked.
- No spawned review or browser/product test executed. Static contract checks do not establish runtime adherence or completeness of future reviews.

## Local Thermos consolidation

User approved one `code-review` entry point with thermo checks always included in the existing four passes, not a separate opt-in mode or six-worker review. Keep both specialized Pi agents; dispatch them for security/data/rollout and rules/docs/patterns/code health, with general workers for the other two passes. Missing specialists use the same complete task packet through a general worker or permitted sequential review.

Absorb explicit developer-setup/feature-gate checks and stronger ownership, invariant and structural-simplification scrutiny. Preserve code-review's evidence, validation, scope, severity and readiness contract where the former thermo contracts differ: no default `main`, bare clean-audit output, automatic high severity or line-count blocker. Workers do not orchestrate nested reviews. Explicitly requested narrower scopes remain supported and cannot grant full-change readiness.

Inspected local sources: former `thermos/{SKILL.md,SOURCES.md}`, both Pi `thermo-nuclear-*/{SKILL.md,SOURCES.md}`, and both specialized agent definitions. Trust: canonical local; confidence high for instruction content, not empirical effectiveness. Remove the three redundant skill entry points and their verified live links; retain upstream consultation links below. No new dependencies or skill references required.

Desk cases: ordinary review dispatches four tasks, not six; "thermos" selects the same workflow; specialist unavailable gets general/sequential fallback; worker cannot load skill uses supplied rubric or reports incomplete; security-only excludes other dimensions; a 1001-line file or `unknown` at a trust boundary alone is not a defect; no findings still requires coverage and verdict. These are static contract checks, not observed review runs.

### Local specialist agent names - upstream mapping

User approved responsibility-based names after consolidation. Files live under `pi/dot-pi/agent/agents/` from the repository root; their filename stems and frontmatter names match the current names below. The dispatch table in `SKILL.md` uses these names. Only names, titles and routing descriptions changed; review rubrics and safeguards remain unchanged. No legacy runtime aliases are retained.

| Current local name / filename stem | Original upstream name / filename stem | Assignment |
| --- | --- | --- |
| `code-review-security` | `thermo-nuclear-review-subagent` | Security/data/rollout; explicitly assigned correctness audits |
| `code-review-code-health` | `thermo-nuclear-code-quality-review-subagent` | Rules/docs/patterns/code health |

For future source updates, use the original worker URLs and removal history below to locate upstream content, then apply relevant changes to the mapped local files. Preserve current local names, dispatch references, full assigned-pass coverage and approval/evidence safeguards; do not overwrite local adaptations or restore old registrations automatically. This rename did not fetch or verify upstream content anew.

### Original Thermos resources - retain for future updates

Consult these upstream resources when updating the absorbed Thermos behavior. These exact historical URLs were recorded by the former `thermos/SOURCES.md`; they are provenance, not runtime dependencies. They are mutable and may now be missing. Do not claim a fresh fetch or immutable original-content pin from this consolidation.

| Resource | Original upstream URL |
| --- | --- |
| Thermos coordinator | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermos/SKILL.md |
| Correctness/security rubric | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-review/SKILL.md |
| Code-quality rubric | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-code-quality-review/SKILL.md |
| Correctness worker | https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-review-subagent.md |
| Code-quality worker | https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-code-quality-review-subagent.md |

Recorded upstream trust: secondary-external; historical source content/removal comparison previously recorded with high confidence. Exact original ancestry/content revision remains unpinned. To recover removed files, inspect the repository's history before the removal commit rather than assuming current URLs still contain them:

- Repository: https://github.com/sndrgrdn/pi
- Removal commit (`remove thermos skill + agents`): https://github.com/sndrgrdn/pi/commit/54b2037a480491d2a7e8eaebd854163e875edad5
- Inspected replacement coordinator: https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/deep-review/SKILL.md
- Current replacement lookup: https://github.com/sndrgrdn/pi/blob/master/skills/deep-review/SKILL.md (mutable; verify on refresh).

The earlier comparison inspected the replacement coordinator, not all its rubric leaves. Adopted pinned shared scope, independent evidence, counterevidence, root-cause/remedy deduplication and honest incomplete coverage. Do not automatically import upstream four-judge policies, tool assumptions, permission changes or mechanical blockers. Local four-pass behavior is this user's decision, not a claim of an upstream migration. Stop research here for this local merge; no new external claim needs retrieval.

### Consolidation validation

- Dependency-free `python3 -c` structural check passed: four-pass routing, all five original upstream URLs, removal/replacement commit reference, bundled reference existence, worker coverage/no-nesting contracts, canonical registration targets, removed directories/link, balanced fences and whitespace. This is not strict YAML/depth validation or a runtime review test.
- `git diff --check -- skills/dot-agents/skills/code-review skills/UPSTREAM.md pi/dot-pi/agent/agents pi/dot-pi/agent/skills`: passed, no output. Ignored skill/agent file whitespace was also checked by Python.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependencies installed.
- Live registration verified: shared code-review links point to the canonical source; Pi agents/skills use canonical parent-directory links. Removed three skill directories and the sole separate Thermos symlink; both specialist agent files remain.
- No application review or spawned-worker behavior evaluation performed. Future runtime adherence and strict validation remain open gaps.

The research and validation sections below predate this consolidation unless explicitly labeled otherwise.

## Requested behavior and shape

User requires exhaustive automated review with no assumed later human review: repo rules, best practices, edge cases, recent deployed-code patterns, relevant documentation, and confirmation rather than guessing.

Class: security-review + workflow-process. Shape: one self-contained ordered review workflow with four independent perspectives and permitted sequential fallback. One directly routed examples reference supports evidence calibration; SPEC.md records the materially changed readiness contract. No scripts, dependencies, new agent definitions or registration changes needed.

Replace the former lightweight/findings-only default and optional deep mode. Preserve read-only boundaries, local severity names, scoped findings, counterevidence and concise individual comments. Exhaustiveness is coverage accountability, not a claim of perfect recall.

## Research shortlist

Checked the skills.sh leaderboard before other discovery. Public websearch failed (`fetch failed`); used public skill pages and read-only GitHub metadata/tree/content retrieval instead. No CLI bootstrap or installs. Popularity is a discovery signal, not measured effectiveness or safety.

Observed 2026-09-24; install counts are rounded as displayed and stars are repository-wide:

| Candidate | Installs | GitHub stars / last push | Fit and limits |
| --- | --- | --- | --- |
| [Trail of Bits differential-review](https://skills.sh/trailofbits/skills/differential-review) | 6.9K | 7,226 / 2026-09-23 | Strongest inspected specialist for history, blast radius and adversarial tracing. Not a complete general review. Reject scope-skipping shortcuts and automatic risk/severity inflation |
| [Matt Pocock code-review](https://skills.sh/mattpocock/skills/code-review) | 609.3K on leaderboard | 268,883 / 2026-09-24 | Strong fit for independent standards/spec checks and pinned target. Add correctness/security/rollout and remove fixed short-output limits |
| [Sentry code-review](https://skills.sh/getsentry/skills/code-review) + find-bugs | 4.8K for code-review; find-bugs not verified | 1,004 / 2026-09-21 | Broad baseline and complete-diff/attack-surface accounting. Do not import human escalation, Sentry-specific conventions or assume a framework |
| [Anthropic code-review and PR toolkit](https://github.com/anthropics/claude-code/tree/d78be9481b889e11186ec4578b4f5e9301396e25/plugins) | Not verified | 147,907 / 2026-09-24 | Useful separate validation, behavioral test and failure-path perspectives. Default code-review explicitly excludes input/state-dependent bugs; unsuitable unchanged for this request |

Recommendation: maintain this local synthesis rather than install a replacement. These are task-fit judgments from inspected content, not an empirical ranking of the ecosystem. No upstream scripts executed or agent/tool availability assumptions imported.

## Source inventory

All GitHub paths below were read at the exact revision shown. These are pattern references, not newly claimed original ancestry. Usage is original local formulation of review ideas; no upstream files/scripts or substantial example text copied.

| ID | Source and exact inspected files | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- | --- |
| T | [trailofbits/skills @ 32e34f8173796e3566a51aee877dc96bc5191f64](https://github.com/trailofbits/skills/tree/32e34f8173796e3566a51aee877dc96bc5191f64/plugins/differential-review/skills/differential-review): SKILL.md, methodology.md, adversarial.md | canonical publisher; external pattern | High for retrieved instructions, not automatic correctness | Repo license metadata CC-BY-SA-4.0. Attribute concepts; no text/code vendored. Reject checkout commands, obligatory file writes, heuristic severity multipliers and unproved example impacts |
| M | [mattpocock/skills @ c55ee46073ed923f86ce59a5eb3b6d895095d1b7](https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/code-review/SKILL.md): skills/engineering/code-review/SKILL.md | canonical publisher; external pattern | High | Repo license metadata MIT. No setup dependency or fixed 400-word worker cap; scoped standards/spec remain distinguishable |
| S | [getsentry/skills @ c2f99a5b04b4cd992ec3022d7c2c3e23e938d241](https://github.com/getsentry/skills/tree/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills): code-review/SKILL.md, find-bugs/SKILL.md | canonical publisher; external pattern | High | Repo license metadata Apache-2.0. Complete input and verification concepts only; no human-review requirement, shell substitution or assumed local tooling |
| A | [anthropics/claude-code @ d78be9481b889e11186ec4578b4f5e9301396e25](https://github.com/anthropics/claude-code/tree/d78be9481b889e11186ec4578b4f5e9301396e25/plugins): code-review/commands/code-review.md; pr-review-toolkit/agents/silent-failure-hunter.md and pr-test-analyzer.md; root LICENSE.md | canonical publisher; external pattern | High for retrieved content | LICENSE.md reserves rights under Commercial Terms; no content vendored. Reject guaranteed-tool assumptions, automatic comments, no-context review, input-independent-only bug bar, provider models and unconditional critical severity for catches |
| G | [Google review scope](https://google.github.io/eng-practices/review/reviewer/looking-for.html) and [standard](https://google.github.io/eng-practices/review/reviewer/standard.html) | canonical engineering guidance | High | Live pages, no immutable revision captured. Every-line/context, meaningful tests, code health and documented-rule precedence; adapt away from human-review handoff |
| O | [OWASP Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html) | canonical security guidance | High | Live page. Object-level authorization, per-request enforcement, framework/config verification, safe denial and privacy-aware logging; not a comprehensive language security reference |
| D | [skills.sh leaderboard](https://skills.sh/) and candidate pages above | secondary discovery/metrics | Medium | Report displayed metrics only; badges/install counts are not a code audit or effectiveness benchmark |
| L | Existing local SKILL.md/SOURCES.md, adjacent thermos workflow, skill-writer workflow and user requirements | canonical local | High | Existing safeguards and new user contract override upstream defaults. Skill-writer workflow/security example profiles selected |

## Decisions and rationale

| Decision | Status | Evidence / reason |
| --- | --- | --- |
| Default exhaustive primary review, all actionable findings, explicit readiness | adopted | User request; S complete-input accounting; G every-line coverage. Replace optional-depth and bare no-findings output |
| Four independent perspectives with sequential fallback | adopted | M standards/spec separation; A specialized test/error reviews; local missing-worker safety. No assumption a particular agent exists |
| Mandatory relevant-document review in both directions | adopted | User follow-up; G documentation/consistency. Check code against rules/contracts and docs made stale by the patch |
| Version-matched official references and confirm-before-asserting | adopted | User follow-up; O framework/config caveats. Unverified behavior/intent/deployment stays unknown |
| Recent analogues, removed-guard history and deployed-contract comparison | adopted | User requirement; T history/baseline invariant tracing. Distinguish merged/released/deployed and account for rollback/mixed versions |
| Concrete edge-case/abuse scenarios and counterevidence | adopted | T attacker model; S attack-surface mapping; O authorization; A behavioral test perspective |
| Drop input/state-dependent bugs or context outside diff | rejected | A defaults conflict directly with requested edge-case and integration coverage |
| Automatically escalate risk based on caller count, absent tests or broad catch | rejected | T/A heuristics do not prove harm; severity must follow confirmed impact |
| Skip low-risk files, force report-file writes, checkout baseline, post comments | rejected | T/A defaults conflict with complete coverage and local read-only/permission boundaries |
| Treat recent deployed pattern as correct by definition | rejected | Deployment proves use only; rules/invariants/confirmed failure outrank frequency |
| Delegate final safety to unspecified human review | replaced | User workflow. Missing evidence produces scoped INCOMPLETE with exact next action |
| New reference and SPEC | adopted | Material readiness change needs a maintenance contract; synthetic true-positive, safe-pattern, remediation and recovery examples prevent abstract-only guidance |

## Coverage matrix

Statuses below describe documentation coverage by desk inspection, not executed review accuracy.

| Dimension | Status | Evidence / remaining limit |
| --- | --- | --- |
| Preconditions / ordered process | complete | Pin -> inventory -> docs -> recent/deployed context -> four passes -> verify -> verdict |
| Safety and failure recovery | complete | Read-only, permitted test environment, denied worker fallback, stale CI/changed worktree handling |
| Outputs / acceptance | complete | Per-finding blocking status; coverage/source/validation ledger; BLOCKED/INCOMPLETE/READY |
| Vulnerability classes and prerequisites | complete for general-review rubric | Auth, input/sink, privacy, supply chain and resource/business risk; actual target determines applicable classes |
| Exploit evidence / safe counterexamples / remediation | complete | Traced guard/caller evidence; synthetic tenant regression, equivalent policy, correction and test cases |
| Severity and confidence | complete | Confirmed impact separate from uncertainty, coverage and mandatory-rule gate |
| Rules, relevant docs and best practices | complete | Scoped standards, version evidence, contract mapping, stale-doc check and conflict handling |
| Edge cases, tests and operational failure | complete | Input/state/time/concurrency/partial-failure/version matrix, behavioral assertions, exact check evidence |
| Recent pattern / deployed compatibility | complete guidance | Recent independent analogues, history, verified current deployment per environment, old/new coexistence |
| Framework-specific exploit details | partial | Retrieve locked-version official security/source docs when reviewing an actual target; no language-specific completeness claim |
| Empirical detection quality | partial | Run isolated baseline/candidate cases before making precision/recall claims |

Selected profiles: skill-writer `references/examples/security-review-skill.md` and `workflow-process-skill.md`. The examples reference covers true/false positives, remediation, happy path, guarded production boundary, denied-worker recovery, deterministic reporting and version ambiguity. This is a general workflow, not a vendored integration API guide.

## Trigger and behavior desk checks

Should trigger: "review this PR", "review my diff exhaustively", "find edge cases", "check these changes against repo rules and docs", "compare this approach with recently deployed code", "security review this patch", "give pasteable review comments".

Should not trigger: "implement this feature", "deploy this branch", "explain this API", "find a skill to install", "write a PR description", or production debugging without a review target.

Description change: make exhaustive/default coverage, relevant docs, recent deployed patterns and absence of later human review discoverable; retain PR/diff/review/edge-case language without provider assumptions.

Static expected before/after behavior (not measured model runs):

| Case | New required result / delta |
| --- | --- |
| Plain "review this diff" | All passes + docs/history + coverage/verdict, rather than lightweight findings only |
| Bug only at expiration boundary | Investigate exact inputs; do not discard as merely input-dependent |
| Authentication exists but object ownership removed | Trace middleware/policy and return confirmed finding if exposed |
| Mandatory equivalent guard exists elsewhere | Suppress pattern-only accusation after inspecting guard/callers |
| Ten independent actionable issues | Return all ten, not strongest few |
| Worker denied | Sequential permitted review or explicit incomplete pass |
| Required tests blocked / CI stale | Not READY; show command/error/revision mismatch |
| Recent merge with no deployment evidence | Do not call it deployed; incomplete if live compatibility is required |
| Rollback or mixed producer versions | Check both schemas and old queued payloads, not only all-new state |
| New code follows docs but docs describe wrong framework version | Resolve locked-version facts; unknown if inaccessible |
| Config renamed but runbook unchanged | Verify and report the concrete broken documented workflow |
| Valid intentional departure from recent patterns | Explain justification; no taste-only finding |
| No findings, complete appropriate checks | Scoped READY with coverage, not bare "No findings" |
| Security-only or truncated review | No whole-change READY; identify exclusions and remaining work |
| Explicit audit of unchanged files | Review pinned content and existing defects within that scope; do not demand a diff |
| Focused tests pass but mandatory integration gate absent | Inventory applicable gates; missing mandatory evidence prevents READY |

## Validation and registration

- `git diff --check -- skills/dot-agents/skills/code-review skills/UPSTREAM.md`: passed, no output.
- Dependency-free `python3 -c` structural check: PASS for four skill files; scalar frontmatter/name/description, 188-line body, one routed reference, balanced fences, whitespace, portable paths and key contract markers. This is not a general YAML parser or a behavioral evaluation.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependency installed.
- Independent read-only document audit identified three consistency gaps; corrected whole-file scope, worker-fallback wording, and explicit inventory of mandatory validation gates. Final local desk inspection confirmed the corrections and the representative cases above; no model benchmark or application review executed.
- GitHub commit endpoints independently confirmed all four publisher revisions used above.
- Existing registration/name/invocation preserved. No installation, application-code changes, production access, PR publication or git commit performed.

## Retrieval stopping rationale

Four inspected publishers plus Google/OWASP cover complementary orchestration, completeness, rules/spec, history, abuse evidence, tests and failure paths. User requirements supply the deployment/docs/confirmation contract. Additional generic review lists would duplicate these concepts; target-specific docs and actual deployment data belong in each future review. No claim that one published skill is universally best.

## Open gaps

- Run strict validation in an existing approved Python/PyYAML environment if available; do not install dependencies implicitly.
- Run isolated behavior/trigger evaluations to measure adherence, precision, recall and cost; desk checks cannot establish effectiveness as the only review layer.
- Retrieve application-specific locked-version docs, current deployment evidence and repo-required gate policy during actual reviews. This dotfiles update has no application deployment target.
- Candidate install metrics for find-bugs and Anthropic plugins were not verified; verify them if installation is later considered.

## Historical provenance

The previous local synthesis recorded sndrgrdn/pi `skills/code-review/SKILL.md`, thermos and thermo agents. Earlier 2026-09-24 research inspected [revision 54b2037a480491d2a7e8eaebd854163e875edad5](https://github.com/sndrgrdn/pi/tree/54b2037a480491d2a7e8eaebd854163e875edad5/skills), where deep-review replaces removed thermos paths. That comparison contributed pinned shared input, root-cause/remedy deduplication and honest incomplete coverage. Those safeguards remain; the old lightweight/findings-only default is intentionally superseded by this user's new contract. No new historical-lineage claim made for the additional publishers.
