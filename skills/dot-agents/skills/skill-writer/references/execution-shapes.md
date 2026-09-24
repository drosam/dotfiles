# Execution Shape and Reference Placement

Choose one primary shape before choosing files.

| Need | Shape | Required contract |
| --- | --- | --- |
| One policy or short sequence | Inline guidance | Preconditions, actions, output, stop/failure behavior |
| Optional deep domain knowledge | Reference-backed expert | Explicit condition → reference routing |
| Repeated fragile parsing/validation | Script-backed workflow | Arguments, dependencies, structured results, failure fallback |
| Distinct inputs need different procedures | Router | Route criteria, default, recovery from a wrong route |
| Independent specialist checks | Parallel workers | Pinned shared input, bounded task, worker return schema, merge rule, missing-worker handling |

Do not add advanced mechanics solely to be more thorough. If tools are unavailable or denied, use a permitted simpler fallback or report blocked; delegation does not bypass permissions.

## Placement

- Put every-run decisions in `SKILL.md`.
- Put branch-specific depth in a focused reference, with a direct "read when" entry in `SKILL.md`.
- Put maintenance scope, invariants, and acceptance criteria in `SPEC.md` when contracts change materially.
- Put provenance, adopted/rejected choices, and gaps in `SOURCES.md`.
- Add scripts only for repeated deterministic work, not to mechanize subjective quality judgments.
- Prefer flat filenames for new references. Preserve working legacy paths unless a migration has concrete value.

A documentation **router** that locates installed docs is a workflow, not a vendored API guide. Do not create six artificial use cases and eight generic troubleshooting entries just because its description mentions an SDK. Integration-documentation depth gates apply when the skill itself teaches that API.
