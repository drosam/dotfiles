# Breakdown Examples

## Happy path

Input: user selects `.agent-work/work/inventory-collection-filter/spec.md` (Work-ID `inventory-collection-filter`); its Plan link points to a reciprocal `./plan.md` with status Approved.

1. Read spec, plan, glossary. Plan non-goal: "no saved filters".
2. Outline in chat and `tickets/index.md` (`Breakdown: proposed`):
   - 01 Filter by one collection — pick one collection; list shows only its items — no blockers
   - 02 Combine collections — several collections narrow the list together — blocked by 01
   - 03 Filter survives pagination and export — blocked by 01
   - Coverage: spec "Saved filters" → deferred (plan non-goal).
3. User: "merge 03 into 01". Update outline; user agrees → `Breakdown: agreed`.
4. Write `01-filter-one-collection.md`, `02-combine-collections.md`, all `draft`; user gave a Figma URL, linked in 01's Context.
5. Turn per ticket: show full 01 → user edits one criterion → apply, `accepted`. Then 02 → `accepted`.
6. Consistency check passes → `Breakdown: reviewed`. Ask: todos, tracker, both, or stop.

## Missing plan

Spec header says `Plan: Not created`. Ask: run `create-plan` first, slice from the spec alone, or stop. User picks spec-only → `index.md` records `Plan: Not created`; coverage lists spec items only. Do not draft design decisions inside tickets.

## Resume after a lost session

`tickets/index.md` shows `Breakdown: agreed`, 01 accepted, 02–04 draft. Report that state, then continue review at 02. Do not rewrite 01 or regenerate the outline.

## Robust: partial tracker publish

User: "publish to Linear, team INV, project 'Collections filter', Backlog, no assignee". Mapping approved. 01 → `INV-41`, recorded. 02 fails with a timeout.

Report `created: INV-41 (#01); pending: #02`. Search the project for "#02"/title before retrying; it was created as `INV-42` despite the timeout → record it, do not create again. Then create 03 after its prerequisite; do not copy local header metadata into the tracker. If 03's body refers to 01 or 02, publish those references as hyperlinks to `INV-41` or `INV-42`, using the approved final update pass when needed.

## Anti-pattern → correction

Bad outline:
- 01 Add collection_ids param to API
- 02 Add filter query scope
- 03 Build filter dropdown UI
- 04 Write tests

Each is a layer; none is testable alone; 04 has no behavior.

Correct: 01 "Filter by one collection" covers param, scope, UI, and tests for one collection; 02 adds multiple collections end to end.

Bad ticket: three paragraphs restating the spec, acceptance criterion "filter works well".

Correct: two-line Context, short prose Description, criteria like "Selecting collection A shows only A's products" and "Clearing the filter restores the full list". Use Description bullets only when genuinely separate constraints are easier to scan; do not format each sentence as its own bullet.

Bad ticket: prescribe a new `CollectionFilterService`, endpoint parameters, database indexes, and an ordered file-by-file coding sequence when the approved plan does not require them.

Correct: describe the observable filtering behavior and constraints. Include a schema, API, or code pointer only when an approved plan/ADR mandates it or compatibility, security, migration, or material ambiguity makes it necessary. Include only that detail; keep spec, plan, and ADR citations in the `Source` header or index, never the body.

## Customer data in a screenshot

User pastes a production screenshot showing customer names. Ask to crop/redact or use a Figma link instead before saving to `tickets/assets/`.
