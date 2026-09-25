# Feature Spec to Todos Sources

## Later local work-area contract

User-directed rename: `prd-to-todos` → `feature-spec-to-todos`. Read selected `.agent-work/work/<work-id>/spec.md` and reciprocal sibling `plan.md` context (user-approved work-first grouping); use `spec:<Work-ID>` and actual source/plan paths in tool-backed todos. Ask before selecting uncertain work, even one candidate. Preserve explicit creation approval, unchanged parents and partial-failure handling. Historical PRD terminology below is provenance, not current naming. Static examples added; no todo creation/runtime benchmark performed.

Retrieved: 2026-09-24. Class: workflow-process; shape: ordered local todo creation after approval.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/to-tickets/SKILL.md | canonical upstream candidate | high content; inferred ancestry | No automatic tracker/filesystem migration |
| https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/to-tickets/SKILL.md | secondary candidate | high | Earlier combined-file output is not local policy |
| Live todo schema plus local skill | canonical local | high | Only list/add(text)/toggle(id)/clear currently supported |

Adopt explicit real blockers and expand–contract exception for wide refactors. Replace fictional file-backed/native tags/body guarantees with plain text and actual returned IDs; add dedupe/partial-failure recovery. Preserve explicit approval and unchanged parent PRD. See SPEC.md.

Coverage/profile: preconditions, slice/approve/create/report order, tool mismatch, partial retry, safety and handoff covered. Concrete happy, robust partial-failure, and bad/corrected examples in references/examples.md. Desk case: missing todo tool returns draft, not surprise tracker issues.

Stop: current source alternatives plus actual schema settle local adaptation. Gap: historical ancestry inferred; runtime persistence cannot be guaranteed. Strict validator blocked by missing PyYAML; no live todos created during maintenance.
