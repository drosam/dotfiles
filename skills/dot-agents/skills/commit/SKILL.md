---
name: commit
description: Create focused git commits from current working tree changes. Use when the user asks to commit changes, make a git commit, write a commit message, split changes into commits, organize commits, group changes into commits, or prepare local changes for commit.
---

Create minimal, cohesive commits from current changes.

## Preconditions

- Never commit without reviewing the diff.
- Never stage unrelated changes without user confirmation.
- Never use `git add -A` or `git add .`.
- Never add `Co-Authored-By` trailers.
- Never amend, rebase, reset, stash, or push unless explicitly asked.

## Workflow

1. Inspect state:

   ```bash
   git status --short
   git diff --stat
   ```

2. Read relevant diffs before deciding scope:

   ```bash
   git diff -- <path>
   git diff --cached -- <path>
   ```

3. Decide commit scope:
   - If all changes are one cohesive unit, commit them together.
   - If changes are unrelated, ask which files/hunks to include.
   - If generated or incidental files appear, call them out before staging.

4. Stage explicit files only:

   ```bash
   git add -- path/to/file another/file
   ```

5. Write title-only commit message:
   - Use one concise sentence.
   - Prefer imperative mood.
   - No body.
   - No trailers.

6. Commit:

   ```bash
   git commit -m "Commit title"
   ```

7. Report commit hash and title.

## Failure handling

- If tests/lint are relevant and not run, mention that clearly.
- If `git status --short` shows unrelated changes, stop and ask for scope.
- If commit fails, quote the exact error and suggest the smallest fix.

## Organize multiple commits

Use this branch when the user asks to organize commits, split changes into commits, or group staged/unstaged changes.

1. Inspect all changes:

   ```bash
   git status --short
   git diff --stat
   git diff --cached --stat
   ```

2. Read diffs before grouping:

   ```bash
   git diff
   git diff --cached
   ```

3. Propose commit groups before staging:
   - Group feature code with matching tests.
   - Keep docs/config/chore changes separate when they are independent.
   - Keep refactors separate from behavior changes when possible.
   - Call out unrelated or ambiguous files.

4. Ask for confirmation when:
   - More than one reasonable grouping exists.
   - Existing staged changes conflict with the proposed grouping.
   - Any file appears unrelated to the main work.

5. Create commits one group at a time:
   - Stage explicit files or hunks only.
   - Run `git diff --cached --stat` before each commit.
   - Use title-only commit messages.
   - Repeat until intended changes are committed.

6. Finish with `git status --short` and list commit hashes/titles created.
