# Skill Writer Sources

Retrieved: 2026-09-24. Older source notes referenced a `plugins/sentry-skills/` layout that is not present here; canonical local root is this skill directory.

## Source inventory

| Source | Trust tier | Confidence | Contribution | Usage constraints |
| --- | --- | --- | --- | --- |
| Local pre-refresh skill and references | canonical local | high | Depth gates, qualitative evaluation, portable paths | Preserve local policy and existing invocation |
| https://github.com/getsentry/skills/tree/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills/skill-writer | canonical upstream | high | SKILL, authoring-path, execution-shapes, reference-architecture, spec-template, source-adaptation | Transform patterns; do not import full tree or Sentry registration |
| https://github.com/anthropics/skills/blob/34040c9c568585f6929bedeaad110ad08f079624/skills/skill-creator/SKILL.md | canonical pattern source | high | Baseline vs changed skill, independent cases, lean prompts | No evaluator scripts copied; no automatic model runs/viewer servers |
| https://agentskills.io/specification | canonical spec | high | Frontmatter, relative references, progressive disclosure | Live page read; format does not grant runtime authority |
| Repo README and observed Stow layout | canonical local | high | Actual registration paths | No assumed AGENTS file or README skill table |

## Decisions

- Adopt simplest-shape selection, direct reference routes, pre/post precision checks, and material-change `SPEC.md`.
- Add a bounded upstream-refresh reference because this repository maintains adaptations rather than pristine packages.
- Preserve existing example paths rather than perform a cosmetic flattening migration.
- Preserve qualitative evaluation by default; label desk checks versus observed runs. Quantitative evaluation remains opt-in.
- Reject bulk upstream replacement and wholesale evaluator/reference-tree import.

## Coverage matrix

Statuses describe documentation coverage by desk inspection, not successful validator or runtime execution.

| Dimension | Status | Evidence |
| --- | --- | --- |
| Source provenance | complete | Revision-pinned sources and inferred-lineage rule |
| Depth gates | complete | Existing synthesis/class guidance retained |
| Transformed examples | complete | references/authoring-examples.md: happy path, guarded refresh, anti-pattern correction |
| Registration / validation | complete guidance | Actual repo paths; explicit class; missing-dependency fallback |
| Shape / maintenance contract | complete | execution-shapes.md and SPEC.md |
| Runtime evaluation | partial | Retrieve isolated run traces if quantitative evidence is requested |

## Profile and qualitative evaluation

Selected workflow-process profile: preconditions, ordered steps, permission boundaries, deterministic output, denied-fetch fallback, and handoff are covered. API/known-issue/use-case/gap depth rubric: pass for this authoring workflow's documented contracts, failure cases, concrete examples, and explicit next checks; not a claim of API integration coverage or runtime measurement.

Should trigger: "create a skill", "refresh our upstream-derived skills", "improve this skill from examples".
Should not trigger: "find a skill to install", "write application code", "review this PR".
Desk-check improvement: source-refresh no longer assumes Sentry paths or blindly copies source tool APIs. No model benchmark run.

## Stopping rationale

Local workflow, current upstream authoring/adaptation guidance, a second canonical authoring reference, and the format specification cover the material changes. More generic guides would duplicate these decisions.

## Open gaps

- Run strict validation in an approved Python/PyYAML environment; dependency absent and installs declined during this refresh.
- Run isolated behavior/trigger cases if measured evaluation is requested.

## Changelog

- 2026-09-24: Replace stale source/layout assumptions; add precision, shape, contract, and upstream-refresh patterns with concrete examples.
