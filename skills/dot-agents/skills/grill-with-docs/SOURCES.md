# Grill With Docs Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: self-contained inline rounds + format references. Manual invocation (`disable-model-invocation: true`) matches upstream and local `grill-me`.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/grill-with-docs/SKILL.md | canonical upstream | high | One-line delegation to `grilling` + `domain-modeling`; MIT (Matt Pocock 2026) |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/productivity/grilling/SKILL.md | canonical upstream | high | Design tree, frontier rounds, recommended answers, facts via lookup |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/domain-modeling/SKILL.md (+ `CONTEXT-FORMAT.md`, `ADR-FORMAT.md`) | canonical upstream | high | Glossary challenge, scenario probing, code cross-check, inline `CONTEXT.md` writes, three-gate ADR rule; formats re-expressed locally, not vendored |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/docs/engineering/grill-with-docs.md | canonical upstream docs | high | Known failures: dependency skills not loading, silent no-write inside orchestration wrappers, decisions lost to conversation; naming discontent |
| Local `grill-me/SKILL.md`, `SPEC.md` | canonical local | high | Interview steps, one-at-a-time pace, blocked-tool rule, explicit handoff |
| GitHub repository search `grill-with-docs` | secondary discovery | medium | Several derivatives credit mattpocock/skills (MIT); confirms lineage, not quality |

Pin: mattpocock/skills main `c55ee46073ed923f86ce59a5eb3b6d895095d1b7` (2026-09-18T10:12:29Z). skills.sh search UI returned no parsable results; websearch tool failed (`fetch failed`).

## Adopted / changed

- Adopted: frontier rounds with recommendations; facts vs decisions split; inline glossary writes; sparse three-gate ADRs; glossary-only `CONTEXT.md`; multi-context via `CONTEXT-MAP.md`; lazy file creation; closing note that most decisions live only in the conversation.
- Changed: self-contained instead of two-skill delegation (upstream's most reported failure). Reused local `grill-me` interview steps and question-tool preference instead of upstream's emoji round format. Added: one-line write announcements, honor existing ADR conventions, denied writes reported not retried, explicit handoff approval.
- Rejected: sub-agent dispatch as mandatory; upstream chain (`to-spec → to-tickets`) as required next step - local equivalents (`to-prd`, `create-plan`) are suggested generically.

## Desk cases

Term conflict challenged before proceeding; "account" resolved to Customer written immediately with `_Avoid_`; Postgres write-model decision earns ADR offer, helper naming does not; no `CONTEXT.md` yet → created on first term; finished interview does not implement.

## Validation

- Links: `~/.agents/skills/grill-with-docs`, `~/.claude/skills/grill-with-docs` → canonical dir; resolved.
- Dependency-free structural check: PASS (5 files, 39-line body, 352-char description, references resolve, no host paths, fences/whitespace).
- `quick_validate.py --skill-class workflow-process --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`; not installed by policy.
- Interview quality and inline-write behavior not exercised at runtime.
