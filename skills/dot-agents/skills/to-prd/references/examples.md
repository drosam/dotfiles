# PRD Synthesis Examples

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

Save to the requested `.prd/` path and report it; do not create tracker issues.

## Robust variant

Input: same conversation, but retention is undecided and the destination exists.

Inspect the existing file, preserve unrelated content, and ask before replacement. Record `Open decision: retention policy` rather than silently choosing thirty days. For read-only mode, return the draft in chat.

## Anti-pattern → correction

Bad: invent sharing, notifications, analytics, and ten repetitive user stories to make the PRD extensive.

Correct: cover agreed behavior and meaningful edge cases once; label unresolved scope explicitly. Confirm only the unsettled test boundary instead of restarting the whole interview.
