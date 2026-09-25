# Feature Spec Synthesis Examples

## Happy path

Input: conversation agrees on saved-search creation, retrieval, and deletion.

Output excerpt:

```markdown
## User Stories
1. As a signed-in user, I want to save a search so I can rerun it.
2. As its owner, I want to delete a saved search so obsolete searches disappear.

## Testing Decisions
Test the existing saved-search service boundary: owner can create/read/delete;
a different account cannot read or delete the saved search.

## Out of Scope
Sharing searches between accounts.
```

Save to `.agent-work/work/saved-searches/spec.md` and report it; do not create tracker issues. Header when no plan exists:

```markdown
**Work-ID:** saved-searches
**Status:** Draft
**Spec:** [Saved searches](./spec.md)
**Plan:** Not created
```

Plan-first variant: the user confirms `.agent-work/work/search-management/plan.md` (Work-ID `search-management`) as the source. Create its counterpart at `.agent-work/work/search-management/spec.md`, reusing that Work-ID—not a new folder inferred from the feature title. Add `[Search management plan](./plan.md)` to the spec and `[Saved searches spec](./spec.md)` to the plan. Verify both targets and reciprocal links. Titles may differ; confirmation and links establish the relationship, not directory proximity.

## Robust variant

Input: same conversation, but retention is undecided and the destination exists.

Inspect the existing file, preserve unrelated content, and ask before replacement. Record `Open decision: retention policy` rather than silently choosing thirty days. For read-only mode, return the draft in chat.

## Anti-pattern → correction

Bad: invent sharing, notifications, analytics, and ten repetitive user stories to make the spec extensive.

Correct: cover agreed behavior and meaningful edge cases once; label unresolved scope explicitly. Confirm only the unsettled test boundary instead of restarting the whole interview.

## Cross-session identity and denied links

Input: “Capture the spec for the current feature”; one plausible plan exists, but the user has not identified it. Ask: “Use `.agent-work/work/search-management/plan.md` (Draft, saved-search lifecycle), another document, or create a standalone spec?” Do not assume the branch name establishes identity.

After confirmation, a denied plan backlink edit means report `spec saved; pairing incomplete: plan backlink not updated`. Do not mark the pair complete or silently retry. A draft-only request writes neither document.
