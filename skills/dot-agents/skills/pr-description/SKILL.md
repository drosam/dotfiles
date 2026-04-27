---
name: pr-description
description: Generate pull request description text from branch history and diff context, especially the "Why" section. Use when asked for PR description, pull request summary, PR motivation, PR why text, or branch rationale for review.
---

Write only the PR "Why" section. Do not create, edit, or update the PR.

## Workflow

1. Find comparison base:
   - Prefer `main` when it exists.
   - Otherwise use the repository default branch.

2. Inspect branch context:

   ```bash
   git log --oneline <base>..HEAD
   git diff <base>..HEAD --stat
   ```

3. Read enough diff to understand motivation:

   ```bash
   git diff <base>..HEAD
   ```

4. Infer why the change exists:
   - What problem existed?
   - What user/developer pain triggered this?
   - What outcome does the branch aim to create?
   - Why is this worth doing now?

5. Output only final prose.

## Output rules

- Write 2-4 sentences.
- Plain English.
- No markdown heading.
- No bullet list.
- No "This PR..." boilerplate unless needed for clarity.
- Focus on motivation, not implementation.
- Do not summarize every changed file.
- Do not mention tests unless testing is central to the motivation.
- When referencing code inline, wrap it in single backticks (for example, `Feature.coupons_improvements?`).
- When including a code block, wrap it in triple backticks.

## Failure handling

- If diff does not reveal clear motivation, say what can be inferred and mark uncertainty in one sentence.
- If branch has no diff from base, output: `No branch changes found to explain yet.`
