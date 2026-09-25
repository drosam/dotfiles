---
name: commit
description: Create focused git commits from current working tree changes. Use when the user asks to commit changes, make a git commit, write a commit message, split changes into commits, organize commits, group changes into commits, or prepare local changes for commit.
---

Create minimal, cohesive commits from current changes.

## Preconditions

- A message-only request authorizes drafting, not staging or committing.
- Never commit without reviewing the diff and confirming the intended scope.
- Stop on unresolved merge conflicts. Preserve existing staged work; ask if it conflicts with the requested commit.
- Never stage unrelated changes without user confirmation.
- Never use `git add -A` or `git add .`.
- `.agent-work/` contains local specs, plans, domain context and ADRs, not automatic commit content. Do not stage these files unless explicitly requested. If already staged, stop and ask rather than silently committing or unstaging them.
- When using work docs to establish commit intent, inspect `.agent-work/work/<work-id>/spec.md` and `plan.md`, follow reciprocal Spec/Plan links and Work-ID, and read acceptance criteria/non-goals. Use only an explicit user path, current-session confirmation, or validated reciprocal link. Otherwise shortlist titles/statuses/summaries and ask via question tool (even for one candidate), offering Other / None—standalone work; never guess from names, slugs, branch, or recency. If asking is unavailable, report the blocker. Missing docs need not be created. Selection does not authorize staging or commits.
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

4. Stage explicit files only. If a file mixes intended changes with unrelated hunks, ask before staging it; do not stage the whole file:

   ```bash
   git add -- path/to/file another/file
   ```

5. Write commit message:
   - Use one concise sentence for the title.
   - Prefer imperative mood.
   - Do not include a ticket or issue number unless the user explicitly requests it.
   - No trailers.
   - No body.

6. Read the entire staged diff (`git diff --cached`) and run `git diff --cached --check`. A commit includes the whole index, not just the paths most recently staged. Confirm every hunk belongs to this commit; keep secrets and personal/customer data out of both diff and message. Then commit:

   ```bash
   git commit -m "Commit title"
   ```

7. Report commit hash and title.

## Failure handling

- If tests/lint are relevant and not run, mention that clearly.
- If `git status --short` shows unrelated changes, stop and ask for scope.
- If commit or a hook fails, report the redacted error and inspect status/diff for hook changes. Do not bypass hooks, blindly retry, or amend; propose the smallest fix.

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
   - Read `git diff --cached` and run `git diff --cached --check` before each commit; verify the entire index belongs to that group.
   - Use title-only commit messages.
   - Repeat until intended changes are committed.

6. Finish with `git status --short` and list commit hashes/titles created.
