# Feature Spec to Todos Contract

- Intent: convert a feature spec into approved, testable implementation slices.
- Input: selected full spec and linked plan, relevant domain/architecture context. Output: proposed slices, then actual created IDs and dependencies only after approval.
- Identity: explicit user path/session confirmation or validated reciprocal link; otherwise ask even with one candidate. Never infer from names, slugs, branch, or recency. Clarify missing/conflicting links, report blocked questions.
- Storage: `.agent-work/work/<work-id>/{spec.md,plan.md}`, shared `.agent-work/context/` and `.agent-work/decisions/`. Todos remain tool-backed with `spec:<Work-ID>`, actual parent and plan paths (or absent-plan marker); no invented files or automatic migration.
- Shape: ordered inline workflow with example reference.
- Runtime API: inspect the available tool; current Pi contract is list/add(text)/toggle(id)/clear. Grouping and dependency data live in text, not unsupported metadata fields.
- Boundaries: no clearing/toggling existing work, no parent spec/plan changes, no issue publication/file fallback without a new request, no implementation.
- Recovery: list/reconcile after partial failures; no duplicate retries or invented IDs/persistence guarantees.
- Acceptance: user approval precedes creates, criteria are observable, blocker graph is acyclic, returned IDs are reported honestly.
- Evidence/limits: current upstream to-tickets patterns and local schema recorded in SOURCES.md; runtime storage durability is not guaranteed by this skill.
