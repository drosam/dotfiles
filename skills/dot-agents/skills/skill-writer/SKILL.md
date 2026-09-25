---
name: skill-writer
description: Create, synthesize, and iteratively improve agent skills following the Agent Skills specification. Use when asked to "create a skill", "write a skill", "synthesize sources into a skill", "improve a skill from positive/negative examples", "update a skill", or "maintain skill docs and registration". Handles source capture, depth gates, authoring, registration, and validation.
disable-model-invocation: true
---

# Skill Writer

Use this as the single canonical workflow for skill creation and improvement.
Primary success condition: cover high-impact behavior without wasting runtime context. Choose the simplest adequate execution shape; replace or narrow existing guidance before adding more.

Load only the path(s) required for the task:

| Task | Read |
|------|------|
| Set skill class and required dimensions | `references/mode-selection.md` |
| Choose execution shape and reference placement | `references/execution-shapes.md` |
| Refresh upstream-derived skills without overwriting local policy | `references/upstream-refresh.md` |
| Apply writing constraints for depth vs concision | `references/design-principles.md` |
| Select structure pattern for this skill | `references/skill-patterns.md` |
| Select workflow orchestration pattern for process-heavy skills | `references/workflow-patterns.md` |
| Select output format pattern for deterministic quality | `references/output-patterns.md` |
| Check documentation-depth coverage | `references/examples/documentation-skill.md` |
| Check security-review evidence and false positives | `references/examples/security-review-skill.md` |
| Check process failure/recovery coverage | `references/examples/workflow-process-skill.md` |
| Model concrete authoring, safe refresh, and corrections | `references/authoring-examples.md` |
| Use Claude-only metadata or invocation features | `references/claude-code-extensions.md` |
| Synthesize external/local sources with depth gates | `references/synthesis-path.md` |
| Author or update SKILL.md and supporting files | `references/authoring-path.md` |
| Optimize skill description and trigger precision | `references/description-optimization.md` |
| Iterate using positive/negative/fix examples | `references/iteration-path.md` |
| Evaluate behavior and compare baseline vs with-skill (opt-in quantitative) | `references/evaluation-path.md` |
| Register and validate skill changes | `references/registration-validation.md` |

## Work context

Skill source files belong in their installed/canonical skill directories, not `.agent-work/`. Working feature requirements/designs live in the target repo's `.agent-work/work/<work-id>/spec.md` and `plan.md`; shared domain glossary/ADRs live in `.agent-work/context/` and `.agent-work/decisions/`. Before using them as requirements, resolve selection from explicit user paths, current-session confirmation, or validated reciprocal Spec/Plan links and Work-ID. Otherwise shortlist titles/statuses/summaries and ask via question tool, even with one candidate; include Other / None—standalone work. Never infer from names, branch, slug or recency. Read selected status, acceptance, non-goals and testing decisions; clarify conflicts/broken links. If unable to ask, report the blocker. Ordinary skill maintenance needs no forced artifacts. Pass exact confirmed context to workers, who return missing-identity questions rather than guess.

## Step 1: Resolve target and path

1. Resolve target skill root and intended operation (`create`, `update`, `synthesize`, `iterate`).
2. Distinguish skill-internal paths from repo registration paths:
   - inside a skill, reference bundled files relative to that skill root (for example `references/foo.md`, `scripts/check.py`)
   - for repository registration edits, use the repository's actual canonical files/locations after inspecting the workspace
3. Read `references/mode-selection.md` and select the required path(s).
4. Classify the skill (`workflow-process`, `integration-documentation`, `security-review`, `skill-authoring`, `generic`).
5. Choose the simplest shape with `references/execution-shapes.md`; record why any delegation, script, or new reference is needed.
6. Ask one direct question if class or depth requirements are ambiguous; otherwise state explicit assumptions.
7. For upstream refreshes, follow `references/upstream-refresh.md` before authoring.

## Step 2: Run synthesis when needed

Read `references/synthesis-path.md`.

1. Collect and score relevant sources with provenance.
2. Apply trust and safety rules when ingesting external content.
3. Produce source-backed decisions and coverage/gap status.
4. Load one or more profiles from `references/examples/*.md` when the skill is hybrid.
5. Enforce baseline source pack for skill-authoring workflows.
6. Enforce depth gates before moving to authoring.

## Step 3: Run iteration first when improving from outcomes/examples

Read `references/iteration-path.md` first when selected path includes `iteration` (for example operation `iterate`).

1. Capture and anonymize examples with provenance.
2. Re-evaluate skill behavior against working and holdout slices.
3. Propose improvements from positive/negative/fix evidence.
4. Carry concrete behavior deltas into authoring.

Skip this step when selected path does not include `iteration`.

## Step 4: Author or update skill artifacts

Read `references/authoring-path.md`.

1. Write or update `SKILL.md` in imperative voice with trigger-rich description.
2. Before adding guidance, name the behavior delta, existing rule to replace, and reason for any new artifact. Route every new runtime reference directly from `SKILL.md`.
3. For new skills or material contract changes, create/update a concise `SPEC.md`: scope, inputs/outputs, safety, evidence, acceptance checks, and limitations. Keep provenance in `SOURCES.md`.
4. Follow `references/skill-patterns.md`, `references/workflow-patterns.md`, and `references/output-patterns.md` only where the chosen shape needs them.
5. For authoring/generator skills, include transformed examples in references:
   - happy-path
   - secure/robust variant
   - anti-pattern + corrected version
6. Re-read changed runtime guidance; remove redundant rules and maintenance-only prose. Record whether guidance was replaced, narrowed, moved, deleted, or added with reason.

## Step 5: Optimize description quality

Read `references/description-optimization.md`.

1. Validate should-trigger and should-not-trigger query sets.
2. Reduce false positives and false negatives with targeted description edits.
3. Keep trigger language generic across providers unless the skill is intentionally provider-specific.

## Step 6: Evaluate outcomes

Read `references/evaluation-path.md`.

1. Run a lightweight qualitative check by default (recommended).
2. For integration/documentation and skill-authoring skills, include the concise depth rubric from `references/evaluation-path.md`.
3. Run deeper eval playbook and quantitative baseline-vs-with-skill only when requested or risk warrants it.
4. Record outcomes and unresolved risks.

## Step 7: Register and validate

Read `references/registration-validation.md`.

1. Apply repository registration steps for the active layout you verified in the workspace.
2. Run quick validation with strict depth gates.
3. Reject shallow outputs that fail depth gates or required artifact checks.

## Output format

Return:

1. `Summary`
2. `Changes Made`
3. `Validation Results`
4. `Open Gaps`
