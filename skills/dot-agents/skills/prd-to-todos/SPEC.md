# PRD to Todos Contract

- Intent: convert a PRD into approved, testable implementation slices.
- Input: full PRD and relevant architecture. Output: proposed slices, then actual created IDs and dependencies only after approval.
- Shape: ordered inline workflow with example reference.
- Runtime API: inspect the available tool; current Pi contract is list/add(text)/toggle(id)/clear. Grouping and dependency data live in text, not unsupported metadata fields.
- Boundaries: no clearing/toggling existing work, no parent PRD changes, no issue publication/file fallback without a new request, no implementation.
- Recovery: list/reconcile after partial failures; no duplicate retries or invented IDs/persistence guarantees.
- Acceptance: user approval precedes creates, criteria are observable, blocker graph is acyclic, returned IDs are reported honestly.
- Evidence/limits: current upstream to-tickets patterns and local schema recorded in SOURCES.md; runtime storage durability is not guaranteed by this skill.
