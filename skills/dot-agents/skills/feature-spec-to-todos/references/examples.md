# Todo Decomposition Examples

## Happy path

Input: explicitly selected, approved `.agent-work/work/saved-searches/spec.md`, Work-ID `saved-searches`, with a verified reciprocal link to `.agent-work/work/saved-searches/plan.md`. Read both before decomposition.

Draft:
1. Save and reopen one search end to end; criteria: valid search round-trips, invalid input rejected; no blockers.
2. Delete an owned saved search; criteria: deleted search disappears, other account cannot delete; blocked by 1.

After explicit approval, list current items, add item 1 as text, then use its actual returned ID in item 2. Summarize returned IDs; never invent native `tags`, `body`, or dependency parameters.

## Robust variant: partial creation

Item 1 returns ID 12; item 2 fails. Report `created: 12; pending: delete owned search`. List again before retrying, reconcile whether item 2 was created despite a lost response, and retry only missing work. Do not clear the todo list or create replacement issues elsewhere.

## Anti-pattern → correction

Bad: create separate database, API, and UI todos immediately with fictional tag fields.

Correct: propose one thin save/reopen path, receive approval, then encode title, `spec:<Work-ID>`, source, criteria, and blockers in the available `text` field.

## Cross-session identity

Input: “Create todos for this feature”; `.agent-work/work/saved-searches/spec.md` is the only candidate. Ask which spec applies (show path/title/status/scope; offer Other / None) before decomposition. A matching branch name is not confirmation. If the user selects it but the Plan link is broken or points to a conflicting Work-ID, ask for the correct pairing; do not repair the parent during this workflow.

Created item text includes `Parent: .agent-work/work/saved-searches/spec.md` and `Plan: .agent-work/work/saved-searches/plan.md`, or `Plan: Not created` when none exists. No plan creation is required for simple work. Pasted specs use `Parent: user-pasted spec` rather than an invented file.

Wide-refactor exception: add a compatible new field, migrate bounded caller groups, then remove the old field only after all migration blockers complete. Mark shared integration validation explicitly if individual batches cannot stay green.
