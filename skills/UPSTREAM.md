# Repo Skill Refresh — 2026-09-24

Maintenance-only audit; not loaded with normal skill execution. Scope: all 17 `SKILL.md` directories under `skills/dot-agents/skills/` and `pi/dot-pi/agent/skills/`. Existing names, manual-invocation flags, registration, and unrelated WIP are preserved. No skills or dependencies installed. An additional ignored, untracked `skills/dot-agents/skills/pr-description/` directory was excluded and left untouched.

## Later local review consolidation

The review-family rows below describe the historical audit, not current registration. By user decision, `thermos`, `thermo-nuclear-review`, and `thermo-nuclear-code-quality-review` were absorbed into `code-review` and removed as skill entry points. The two specialist agents remain; thermo checks now participate in code-review's four default passes. Original upstream Thermos skill/agent URLs and removal/replacement history are preserved in `dot-agents/skills/code-review/SOURCES.md` for future consultation. Do not recreate removed entry points during an upstream refresh without approval.

## Retrieved sources

GitHub contents/tree/history inspected through read-only `gh api`; web pages inspected without running their instructions. Revisions below identify the inspected source state, not a claim that the local skill was originally copied from that revision.

| ID | Source / revision | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- | --- |
| S | `https://github.com/getsentry/skills/tree/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241` | canonical upstream | high | Adapt skill-writer patterns; Sentry commit conventions are not local policy |
| M | `https://github.com/mattpocock/skills/tree/c55ee46073ed923f86ce59a5eb3b6d895095d1b7` | canonical upstream | high for current content; inferred for local ancestry | Preserve local PRD/todo storage, TDD refactoring, and approval contracts |
| P | `https://github.com/sndrgrdn/pi/tree/54b2037a480491d2a7e8eaebd854163e875edad5` | recorded upstream for review family | high | Current commit removes thermos skills/agents; deep-review is a pattern reference, not an automatic migration |
| V | `https://github.com/vercel-labs/skills/tree/7407f3893ad4dceab546ac002c3ef806e4000c73` | canonical upstream | high | Installed skill-lock identifies find-skills; never bulk-update repo adaptations |
| A | `https://github.com/anthropics/skills/tree/34040c9c568585f6929bedeaad110ad08f079624` | canonical upstream | high | skill-creator is a pattern reference; no evaluator/viewer scripts copied or executed |
| Spec | `https://agentskills.io/specification` | canonical specification | high | Retrieved live; no immutable page revision captured; applies format, not runtime permissions |
| Google | `https://google.github.io/eng-practices/review/reviewer/{standard,looking-for,comments}.html` | canonical guidance | high | All three pages re-read; preserve fact-based review and local concise output; no historical page snapshot for change detection |
| OWASP | `https://owasp.org/www-project-code-review-guide/` | canonical index | medium | Current page is mostly project/license metadata, not evidence of detailed vulnerability updates; CC BY-SA 4.0; no new guide text vendored |
| Grug | `https://grugbrain.dev/` | attributed philosophy | high for philosophy; unknown skill ancestry | Re-read complexity, factoring, testing, refactoring, and fence guidance; no permission-bypass advice adopted |
| Pi | Installed `@earendil-works/pi-coding-agent` 0.87.1 | canonical installed docs | high for observed package | `docs/skills.md`, `settings.md`, `packages.md`, package metadata and docs index; active-executable binding not independently verified |
| Local | Existing skills, source notes, git history, README, live tool schemas | canonical local | high | Local policy and requested scope win over upstream defaults |

## Per-skill comparison and decisions

All paths below are relative to the relevant repository revision above. `candidate` means useful current pattern source, not proven original provenance. No historical snapshot exists for several local skills, so comparison is current upstream versus current local—not a fabricated upstream release diff.

| Local skill | Class / primary shape | Source evidence | Adopted / preserved / rejected |
| --- | --- | --- | --- |
| skill-writer | skill-authoring / reference router | S `skills/skill-writer/SKILL.md`; authoring-path, execution-shapes, reference-architecture, spec-template, source-adaptation; A `skills/skill-creator/SKILL.md` | Adopt precision passes, smallest shape, direct routing, material-change SPEC, revision-pinned refresh. Preserve qualitative default; reject wholesale reference-tree/evaluator import |
| find-skills | workflow-process / inline | V `skills/find-skills/SKILL.md`; installed lock confirms source | Adopt `find --owner`; add content inspection and narrower trigger. Preserve install approval; reject unverified `skills init` recommendation and popularity-as-safety |
| tdd | workflow-process / reference-backed | M `skills/engineering/tdd/SKILL.md` (strong text match; ancestry not recorded) | Adopt agreed seams, independent expected values, domain/ADR context. Preserve local red-green-refactor; reject upstream removal of refactoring from loop |
| grill-me | workflow-process / inline rounds | M `skills/productivity/grill-me/SKILL.md` now delegates to `grilling/SKILL.md` | Adopt rounds of independent decisions and stop/handoff criteria; do not require missing Skill tool or install grilling |
| to-prd | workflow-process / inline + examples | M `skills/engineering/to-spec/SKILL.md`; P `skills/to-spec/SKILL.md` (candidates); M history `aaf3050857a8d00c710c382c87a29b81341370aa` confirms write-a-prd → to-prd rename | Adopt existing test seams/domain vocabulary; preserve `.prd/`, no fresh broad interview; reject auto tracker publication and padded stories |
| prd-to-todos | workflow-process / inline + examples | M `skills/engineering/to-tickets/SKILL.md`; P `skills/to-tickets/SKILL.md` (candidates) | Adopt real blocking edges, expand–contract exception. Preserve local todo tool; remove fictional tags/body/persistence APIs; reject tracker/file publication defaults |
| create-plan | workflow-process / staged workflow | Local history; S authoring patterns as secondary guidance; exact original unestablished | Add denied-worker fallback and unambiguous implementation approval; preserve phase order and design-doc destination |
| commit | workflow-process / inline | Local history; S `skills/commit/SKILL.md` is comparison candidate, not proven original | Add whole-index review, hook failure handling, privacy; preserve title-only local format; reject conventional-commit/body/footer and automatic branch creation |
| debug | workflow-process / inline | Local history; P `skills/diagnosing-bugs/SKILL.md` is pattern reference | Adopt exact symptom signal and discriminating hypotheses; preserve read-only mode; reject forced instrumentation, harness creation, and automatic fixes |
| prod-debug | workflow-process / handoff | Local history; diagnostic pattern reference above | Clarify permanent no-production-execution rule, environment bounds, redaction, clipboard fallback; no production tool execution or replay |
| deslop | workflow-process / reference-backed | Explicit Grug attribution; local history, no identified upstream skill | Preserve fence/selection gates; replace auto commit/reset with scoped verification; correct nil/boolean, splat, async, and validation false positives |
| for-real | workflow-process / inline | Local history; exact original unestablished | Replace hostile repetition with skeptical evidence loop, actual check results, blocked checks, and authority-aware repairs |
| code-review | security-review + workflow / inline with optional workers | Recorded P `skills/code-review/SKILL.md`; current `skills/deep-review/SKILL.md`; Google/OWASP | Adopt pinned shared input, evidence-based dedupe, incomplete coverage. Preserve spec/standards axes and calibrated severity |
| thermos | security-review + workflow / two workers | Recorded P old `skills/thermos/SKILL.md` and agents; removal commit is P revision | Adopt deep-review's evidence/unchecked concepts and root-cause/remedy merge; keep names/two workers; reject four-judge presumptive-blocker legal framing |
| thermo-nuclear-review | security-review / single pass | Recorded P old skill via thermos SOURCES; current deep-review orchestration | Add reachable exploit evidence, counterevidence, pinned input, explicit coverage; preserve independent audit before PR comments |
| thermo-nuclear-code-quality-review | workflow-process / single pass | Recorded P old skill via thermos SOURCES; current deep-review orchestration | Add concrete maintenance cost and safe-boundary guard; line count remains heuristic, not automatic blocker |
| pi-docs | workflow-process / documentation router | Local skill plus installed Pi 0.87.1 | Verify executable/package/version rather than hardcoded Node path; bound cross-references; preserve intentional legacy import conventions |

## Coverage matrix

Selected profiles: skill-writer's workflow-process and security-review examples. Pi-docs is a lookup router, not an API guide; integration API-reference quotas do not apply. Skill-writer has concrete transformed authoring examples and a maintenance contract.

| Dimension | Status | Evidence / remaining limit |
| --- | --- | --- |
| Preconditions and scope | complete | Preserve targets, modes, approval boundaries; resolve refs/package roots/tool schema |
| Ordered flow | complete | Research → compare → targeted update → validate; runtime steps remain explicit |
| Safety boundaries | complete | No installs, implicit commits, production execution, or worker permission bypass |
| Failure / retry handling | complete | Denied workers, partial todo creation, missing docs, hooks, blocked tests |
| Outputs / handoff | complete | Actual IDs/checks/paths; incomplete review cannot become clean verdict |
| Security evidence / false positives / remedies | complete for existing scope | Traced source/sink, guards and counterevidence, concrete fix direction; no new language-specific security module claimed |
| Trigger boundaries | complete by desk review | Positive/near-miss matrix below; manual-only flags unchanged |
| Exact original ancestry | partial | Several skills lack source metadata; retrieve original links from owner if exact lineage is needed |
| Runtime evaluation | partial | Static checks/desk review only; run isolated behavior cases when model evaluation is requested |

## Qualitative trigger and behavior checks

These are static before/after expectations, not measured agent benchmarks.

| Skill | Should route / manual invocation task | Should not route or must stop |
| --- | --- | --- |
| commit | "Draft a commit message for this diff" → draft only | No staging/commit unless requested |
| create-plan | "Design the permission model before coding" | "Review complete" does not authorize implementation |
| debug | "Investigate this local failure without edits" | Production access or write-producing repro stays blocked |
| prod-debug | "Investigate this incident from pasted logs" | "Run this on prod" → user-run handoff, never assistant execution |
| deslop | "Trim chaff in this diff" → numbered proposals | "Looks good" is not explicit finding selection |
| find-skills | "Find an installable React testing skill" | Ordinary "How do I write this test?" is not a search trigger |
| for-real | "Verify this fix for real" | Missing test runtime is blocked, not green; no implied commit |
| grill-me | "Grill my rollout design" | A request to summarize agreed decisions is not an interview |
| prd-to-todos | "Break this PRD into todos" → propose first | No approval/tool → draft only, no issue publication |
| to-prd | "Turn this conversation into a PRD" | Unsettled retention stays an open question, not invented scope |
| tdd | "Implement the retry behavior test-first" | Test review/read-only diagnosis alone does not authorize TDD edits |
| code-review | "Review this patch" | Plain implementation request should not invoke reviewer-only mode |
| thermos | "Thermos review this branch" | Missing pass cannot yield unqualified No findings |
| thermo-nuclear-review | "Audit this diff for tenant leaks" | Scoped lookup with verified protection is not a vulnerability |
| thermo-nuclear-code-quality-review | "Audit maintainability of this branch" | A 1001-line file alone is not a finding |
| pi-docs | "How do Pi skills load?" | Non-Pi SDK question; missing package path → resolve, not guess |
| skill-writer | "Refresh our derived skills from upstream" | "Find a new skill to install" belongs to discovery workflow |

Expected improvements: fewer tool-schema hallucinations, false-positive simplifications, approval bypasses, and unsupported clean-review claims. Unchanged: local names, title-only commits, read-only debugging, `.prd/`, manual invocation settings, and two-pass thermos default.

## Stopping rationale

Current trees, moved-path history, known source notes, canonical format/runtime docs, and concrete failure patterns cover the relevant changes. More generic search is low-yield. Missing lineage is labeled rather than inferred as fact; retrieving owner-provided original links is the next targeted step. No blanket promise that every historical upstream change was recovered.

## Follow-up: primary automated code review

User subsequently requested exhaustive code review without assumed human review, including relevant docs, rules/best practices, edge cases, recent deployed patterns, and confirmed facts rather than guesses. `code-review` now supersedes its initial lightweight default with required coverage/evidence and a scoped readiness verdict. Read `dot-agents/skills/code-review/SOURCES.md` for the additional public-source comparison, decisions, metrics and validation; `SPEC.md` records the new contract. Other review-family entry points remain unchanged. Initial batch results below describe the earlier refresh, not the follow-up's runtime effectiveness.

## Validation and registration

- No registration edits required: existing Stow trees remain canonical; live symlinks untouched.
- Strict validator unavailable: system Python lacks its declared PyYAML dependency. User explicitly chose no installs and structural checks only.
- `git diff --check -- skills pi/dot-pi/agent/skills`: passed, no output.
- Dependency-free `python3 -c` structural check over `git ls-files` skill roots: **17 tracked skills, 29 unique local links/routes, 0 errors**. Manual-invocation flags match HEAD. Checked scalar frontmatter delimiters/fields, name-directory match, name/description limits, invocation booleans, body length, provenance presence, routed files, and host-specific paths. This is not a general YAML parser or strict-depth validator.
- First structural run caught angle brackets in the create-plan description (fixed) and an ignored/untracked pr-description directory (excluded without edits).
- Manual desk review checked representative happy/failure/negative cases above. No quantitative model benchmark or end-to-end production action performed.
- Precision result: narrowed triggers/authorization; replaced fictional todo metadata and hostile verification prose; added focused authoring/example references and source/contract records; retained local customizations instead of wholesale upstream import.

## Open gaps

- Exact original source/revision for create-plan, debug, prod-debug, deslop implementation, for-real, and commit remains unknown; ask owner for original URLs before claiming a source-sync baseline.
- Matt Pocock planning/TDD/interview content is a strong current match but not backed by local installation metadata; preserve inferred ancestry label.
- Re-run the existing strict validator in an approved Python/PyYAML environment when available.
- Runtime adherence, automatic trigger precision, and model latency/cost require separate isolated evaluations.
