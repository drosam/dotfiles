---
name: prod-debug
description: Read-only production debugging workflow for production incidents, prod bugs, Sentry errors, logs, Rails console observations, and live data symptoms. Use when asked to investigate, find, explain, or verify a production issue. Strictly forbids production mutation and copies required production commands/snippets to clipboard for the user to run.
---

# Prod Debug

Use this skill for production incident/debug tasks where safety matters more than speed.

Default stance: inspect local code read-only, but do not run anything against production. When production data, logs, console output, or operational command output is needed, prepare the exact read-only command/snippet, copy it to the clipboard, and ask the user to paste/run it.

## Hard Safety Rules

- Read-only task until user explicitly says code changes are allowed.
- Do not change code, config, migrations, seeds, scripts, feature flags, env vars, jobs, queues, caches, or production data.
- Do not run any production command yourself. The user runs all production commands.
- Do not run any command that can create/edit/delete DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, retry/replay events, acknowledge incidents, toggle flags, or trigger side effects.
- Do not run Rails console commands directly against production.
- Do not run Rails runner directly against production.
- Do not run migrations, rake tasks, backfills, data fixes, or admin scripts.
- Do not use `save`, `save!`, `update`, `update!`, `create`, `create!`, `destroy`, `destroy!`, `delete`, `delete_all`, `update_all`, `insert`, `upsert`, `touch`, `increment!`, `decrement!`, `deliver_now`, `deliver_later`, `perform_later`, or similar mutators.
- Treat indirect writes as writes. Avoid methods with callbacks, tracking, audit logs, counters, timestamps, network calls, or job enqueues.
- If unsure whether action mutates state, do not run it. Ask user or propose safer alternative.

## Allowed Local Actions

Allowed for the assistant:

- Read and search local code/docs.
- Inspect local git status, diff, log, and blame.
- Copy read-only commands/snippets to clipboard.

Not allowed within this skill, even when implementation is approved:

- Any command using production/staging credentials.
- Any command that starts app runtime, console, runner, jobs, workers, servers, or tests against live services.
- Any command where environment or side effects are uncertain.

The no-production-execution boundary also covers remote monitoring/log queries through tools or MCP. Analyze supplied observations locally instead. Code-change approval does not authorize production access.

## Goal

Find likely bug from production error/symptom, explain cause, impact, evidence, and propose fixes. Do not implement fixes until user says it is OK to code.

## Workflow

1. Restate safety boundary: read-only investigation, no prod mutation.
2. Collect inputs:
   - Error message/stack trace
   - Request/job/user/order IDs
   - Timestamp/time zone and affected release/environment
   - Recent deploy/commit
   - Logs/monitoring links or pasted output
   - Expected vs actual behavior
3. Inspect code read-only:
   - Search relevant classes, controllers, jobs, serializers, services, models, scopes, callbacks.
   - Check recent git diff/log only if useful.
4. Form hypotheses:
   - Map stack trace to code path.
   - Identify data assumptions and edge cases.
   - Rank hypotheses with evidence for/against and one discriminating observation each.
   - Mark unverified causes as hypotheses, not confirmed root causes.
5. Request production observations only when needed.
6. For any production command/snippet/log query:
   - Do not run it yourself.
   - Make it read-only and narrowly scoped, with result/time bounds; ask the user to verify environment and read-role support first.
   - Minimize sensitive fields; request redacted results, never credentials or whole customer records.
   - Immediately execute a local `pbcopy` handoff command that copies the literal payload; do not merely display the handoff command or ask the user to copy manually. Never execute the embedded payload.
   - If clipboard access is unavailable or denied, show the payload once in a fenced block as fallback.
   - Wait for the user to paste the result before continuing.
7. For Rails console needs:
   - Do not run console yourself.
   - Generate one read-only snippet and immediately copy it through the same local clipboard handoff.
   - On successful copy, do not print or repeat the snippet in the response; return only the terse confirmation from `Clipboard Step`.
   - Wait for user to paste result.
8. Final output:
   - `bug:` concise root cause.
   - `evidence:` bullets.
   - `impact:` affected users/data/path.
   - `verify:` read-only checks.
   - `fix options:` safe implementation choices.
   - `next:` ask user if ready to code.

## Rails Console Snippet Rules

When needing production data, generate snippets that:

- Only read data.
- Avoid callbacks and app methods with possible side effects.
- Prefer `pluck`, `pick`, `ids`, `count`, `exists?`, `where`, `select`, `limit`, `order`, `find_by`, `readonly`.
- Avoid loading huge records. Always bound with IDs/time ranges/limits.
- Avoid `inspect` on objects if it may trigger expensive or side-effect methods. Prefer hashes of primitive columns.
- Avoid external service clients.
- Avoid writes even inside transactions. Rollback is not enough if code has non-DB side effects.

### Snippet Format

Make snippet self-contained and clearly read-only. Example:

```ruby
# READ ONLY: production debug. No writes, no jobs, no external calls.
ActiveRecord::Base.connected_to(role: :reading) do
  rows = Order.where(id: [123, 456]).limit(10).pluck(:id, :status, :created_at)
  puts rows.map { |id, status, created_at| { id: id, status: status, created_at: created_at }.inspect }
end
nil
```

If app has no replica/role support, omit `connected_to` and keep query-only:

```ruby
# READ ONLY: production debug. Query-only; no writes, no jobs, no external calls.
rows = Order.where(id: [123, 456]).limit(10).pluck(:id, :status, :created_at)
puts rows.map { |id, status, created_at| { id: id, status: status, created_at: created_at }.inspect }
nil
```

## Clipboard Step

Perform this step automatically whenever a production observation payload is ready. Execute the local clipboard command through the shell; never give the clipboard command to the user as an instruction. Copy exactly the payload, without Markdown fences or commentary. Clipboard contents may sync or enter history, so use placeholders rather than secrets. The quoted heredoc prevents shell expansion and must never execute its contents.

For Rails snippets, execute locally:

```bash
cat <<'RUBY' | pbcopy
# snippet here
RUBY
```

For shell/log commands, execute locally:

```bash
cat <<'COMMAND' | pbcopy
# command here
COMMAND
```

After a successful copy, do not include the payload or clipboard shell command in the assistant response. Say only one of:

- `snippet copied to clipboard. Paste into Rails console, then paste output here.`
- `command copied to clipboard. Run it, then paste output here.`

If clipboard execution fails or is unavailable, show the payload exactly once in a fenced block and state that it was not copied.

## Prohibited Output

Do not provide production mutation commands as a suggested quick fix. If a data repair might be needed, describe it conceptually and wait until user explicitly authorizes coding/repair planning.
