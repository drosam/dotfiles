# Simplify Code — Sources and Decisions

Research/authoring: 2026-09-24. Class: workflow-process. Canonical shared root: `skills/dot-agents/skills/simplify-code/`. User selected `simplify-code`; scope explicitly includes branches before any PR exists.

## Behavior delta and chosen shape

User requested whole-branch architectural simplification, removal of unjustified edge-case complexity, readability and better decomposition, with facts confirmed before claims. Existing deslop is a narrow recent-code cleanup with catalog matches; review-triage evaluates already supplied findings. Neither is replaced or broadened. New workflow discovers structural simplifications and presents concrete proposals before edits.

Sequential workflow with one directly routed calibration reference. No new scripts, dependencies, worker architecture, automatic hook or repo-wide policy changes. Runtime contract in SKILL.md; acceptance in SPEC.md; examples separated so architecture/edge-case calibration loads when needed. Defaults to current branch and confirmed base; PR metadata is optional.

## Discovery and source inventory

Checked [skills.sh](https://skills.sh/) first. Public websearch failed (`fetch failed`); direct listing, GitHub and author-site fetches succeeded. A delegated research attempt could not obtain interactive webfetch approval and retrieved nothing; the main session subsequently fetched all pinned content/licenses below. No upstream package installed.

| Source | Trust / confidence | Inspected contribution and constraints |
| --- | --- | --- |
| User requirements; local `review-triage/SKILL.md` | canonical local / high | Confirm facts; separate rarity/impact/value; explicit decisions and no implied edits. User clarification makes no-PR branch operation mandatory |
| Local `deslop/SKILL.md` scope/process sections | canonical local / high | Semantic-equivalence guard, history/caller context and proposed-change authority. Different scope; no catalog or whole skill copied |
| [Sentry code-simplifier](https://github.com/getsentry/skills/blob/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills/code-simplifier/SKILL.md) | canonical publisher / high for inspected text | Complete pinned skill and root LICENSE read. Clarity over compactness, preserve behavior, balance extraction/consolidation. Apache-2.0 root license, Functional Software/Sentry 2025. Independently expressed principles only; no substantial upstream text/examples vendored |
| [Anthropic code-simplifier agent](https://github.com/anthropics/claude-code/blob/d78be9481b889e11186ec4578b4f5e9301396e25/plugins/pr-review-toolkit/agents/code-simplifier.md) | canonical publisher / high for inspected text | Complete pinned agent and LICENSE.md read. Clarity and oversimplification guard. License reserves rights under Commercial Terms; comparison only, no file/text reuse or auto-activation imported |
| [Matt Pocock codebase-design](https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/codebase-design/SKILL.md) and [DEEPENING.md](https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/codebase-design/DEEPENING.md) | canonical publisher / high for inspected text | Both complete pinned files and root LICENSE read. Small useful interfaces, localized knowledge, cohesive consolidation, observable testing boundaries. MIT, Matt Pocock 2026. Independently formulated concepts; no substantial source text/examples copied; DESIGN-IT-TWICE.md not inspected or adopted |
| [Martin Fowler — Yagni](https://martinfowler.com/bliki/Yagni.html) | canonical author guidance / high | Full live article, dated 2015-05-26. Avoid speculative capability/abstraction carrying costs; YAGNI does not reject tests/refactoring/maintainability. Unpinned live page; no quoted numerical feature-failure estimate generalized to this repository |
| [skills.sh Sentry listing](https://skills.sh/getsentry/skills/code-simplifier) and leaderboard | secondary discovery / medium | Observed 8.0K installs and 1.0K repository stars for Sentry listing; leaderboard displayed 671.0K installs for Matt codebase-design. Popularity is not effectiveness or safety evidence; badges not used as verification |
| Local skill-writer core and required authoring/synthesis/evaluation/registration paths | canonical local / high | Shared root, minimal shape, source coverage, trigger checks, strict validation with honest fallback |

Pins independently resolved through GitHub main commit endpoints:

| Repository | Revision | Commit timestamp returned |
| --- | --- | --- |
| getsentry/skills | `c2f99a5b04b4cd992ec3022d7c2c3e23e938d241` | 2026-08-25T14:33:48Z |
| mattpocock/skills | `c55ee46073ed923f86ce59a5eb3b6d895095d1b7` | 2026-09-18T10:12:29Z |
| anthropics/claude-code | `d78be9481b889e11186ec4578b4f5e9301396e25` | 2026-09-23T19:18:58Z |

Commit timestamps are not latest repository push timestamps. Exact current GitHub star counts/push activity were not independently requested; Anthropic install count unknown. Sentry source comment credits a different Anthropic repository (`claude-plugins-official`); skills.sh labels the listing originally from simonwong/skills. Neither establishes complete ancestry. This is a new local synthesis, not a verified lineage migration.

## Adopted, narrowed, rejected

- **Adopt:** Sentry/Anthropic distinction between readability and code golf, and warning against combining unrelated concerns. Reject automatic implementation, last-session-only default scope, provider-specific agents and hardcoded JS/React conventions.
- **Adopt:** Matt's small meaningful interfaces and localizing complexity; expand into concrete file ownership/dependency sketches. Reject forced terminology and the absolute rule that a single adapter implies a bad boundary.
- **Narrow:** DEEPENING's consolidation/testing ideas. Pure code is not automatically safe to merge; old unit tests are not automatically waste. Require behavior/coupling analysis and scenario coverage mapping before test deletion. No new local database emulator or adapter framework automatically introduced.
- **Adopt:** Fowler's cost of speculative capability and future-generalization caution. Reject “YAGNI means no refactoring/tests” and any guessed rarity probability.
- **Add from local policy/user need:** exact branch/merge-base scope, no-PR path, WIP separation, stale-input recovery, explicit approvals, and optional scope reduction distinguished from equivalence.
- **Retain:** rare-path safeguards with high consequences; unknown frequency is not grounds for removal. Prefer simpler preservation before accepting behavior loss.
- **Reject:** mechanical line/file count scoring, arbitrary decomposition, compulsory findings, mandatory delegation or a redesign unrelated to the branch.

## Coverage and stopping rationale

Selected profile: skill-writer `references/examples/workflow-process-skill.md`.

| Dimension / retrieval pass | Coverage | Artifact/evidence |
| --- | --- | --- |
| Preconditions/context, happy path | complete | Pinned full branch scope, optional PR, instructions and requirements; example 1 |
| Ordered flow, architecture, decomposition | complete | Discover → compare → propose → decide → implement → verify; concrete boundary proposals; examples 1–3 |
| Safety/permissions and serious edge cases | complete | Proposal-only default, equivalent versus changed behavior, scope-loss approval; examples 4–6 |
| Output/acceptance | complete | Coverage/design/proposal template and no-justified-change result; example 9; SPEC.md |
| Failures/recovery | complete | Missing/stacked base, moving head/WIP, denied metadata, failed build, blocked checks; examples 7–8 |
| Handoff/escalation | complete | Explicit selection/revised scope/missing evidence, no publication/merge authority |
| Negative examples and corrected alternatives | complete | Overfragmentation, one-adapter heuristic, rare financial failure, false/null semantic trap |
| Platform/version variance | complete for generic workflow | Inspect actual supported runtimes/config/contracts; no language/provider assumptions; syntax example conditional on target |

Stopped after inspected sources covered local readability, architecture/decomposition, speculative complexity and negative controls. Further generic code-review checklists would not address a new high-impact dimension. No empirical comprehension or refactoring-effectiveness claim made.

## Trigger precision and desk evaluation

Should trigger: “simplify this PR”, “simplify my branch before opening a PR”, “this feature branch feels overengineered”, “propose a simpler architecture for these branch changes”, “split the changed code more coherently”, “which rare-case machinery can this PR avoid?”.

Should not trigger: “review this PR for bugs”, “walk through these review comments”, “format this file”, “write a new feature”, “redesign the entire repository”, or automatic completion of ordinary coding tasks. Description narrowed to branch/PR proposals rather than generic autonomous code cleanup; explicitly includes no-PR operation.

Static before/after comparison against inspected local deslop and upstream simplifiers—not observed model runs:

| Desk prompt | Guidance delta / expected result |
| --- | --- |
| Simplify whole branch, no PR | Improved explicit local-ref scope; do not require hosting metadata |
| Parent feature branch is the intended base | Improved stacked-branch clarification; don't attribute parent work to this change |
| Collapse private generic routing | Improved architectural before/after and scoped caller proof, not only expression cleanup |
| Split giant mixed-purpose module | Improved ownership/dependency/test-boundary proposal; reject tiny-wrapper scattering |
| Delete rare cosmetic recovery | Improved exact scope-loss disclosure and separate approval |
| Delete idempotency due to rarity | Preserved serious-risk guard; investigate simpler invariant enforcement |
| One production adapter | Improved counterexample to upstream absolute seam rule |
| Move modules and drop old tests | Improved scenario mapping before test deletion |
| Unknown external usage / telemetry | Preserved unknown labeling; no unverified unused/rare claim |
| Approved split fails build | Preserved scoped repair/stop; no false success |
| Already simple branch | Preserved no-op outcome, no obligatory refactor |

Future iterations: add the actual failing/working prompt with anonymized evidence, classify observed versus desk results, and change the smallest relevant rule. Do not infer measured gains from the table.

## Registration and validation

User approved canonical-source live links in `~/.agents/skills/simplify-code` and `~/.claude/skills/simplify-code`, plus local Python checks; no dependency installation. Renamed the canonical directory and replaced only the verified old-name links, after checking new-name destinations did not exist. No Pi-only copy or global routing change required.

- Read-only independent document audit found no substantive issues in the four skill artifacts before the metadata/path rename.
- Dependency-free Python structural check: PASS for four files, scalar frontmatter, 101-line body, routed local reference, fences/whitespace, portable runtime paths, evidence/approval contract markers and both canonical links. Old-name directory/links absent. Not full YAML/depth or runtime validation.
- `git diff --check -- skills/dot-agents/skills/simplify-code`: passed, no output. New untracked Markdown whitespace was checked by Python above.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/simplify-code --skill-class workflow-process --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`. Same dependency blocker before rename; nothing installed.

## Open gaps

- Run strict workflow-process validation when a compatible environment with PyYAML is available; structural fallback is not a strict pass.
- Interactive discovery and runtime instruction-following are not yet exercised; filesystem link targets are verified.
- No real branch was simplified during skill authoring; examples are synthetic, and application correctness remains target-specific.
