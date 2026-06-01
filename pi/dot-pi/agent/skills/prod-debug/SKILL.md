---
name: prod-debug
description: Read-only production debugging workflow for investigating production errors, logs, Rails console observations, and live data symptoms. Use when asked to find or explain a production bug. Strictly forbids DB writes and code changes until user explicitly says coding is allowed.
---

# Prod Debug

Use this skill for production incident/debug tasks where safety matters more than speed.

## Hard Safety Rules

- Read-only task until user explicitly says code changes are allowed.
- Do not change code, config, migrations, seeds, scripts, feature flags, env vars, jobs, queues, caches, or production data.
- Do not run any command that can create/edit/delete DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, or trigger side effects.
- Do not run Rails console commands directly against production.
- Do not run Rails runner directly against production.
- Do not run migrations, rake tasks, backfills, data fixes, or admin scripts.
- Do not use `save`, `save!`, `update`, `update!`, `create`, `create!`, `destroy`, `destroy!`, `delete`, `delete_all`, `update_all`, `insert`, `upsert`, `touch`, `increment!`, `decrement!`, `deliver_now`, `deliver_later`, `perform_later`, or similar mutators.
- Treat indirect writes as writes. Avoid methods with callbacks, tracking, audit logs, counters, timestamps, network calls, or job enqueues.
- If unsure whether action mutates state, do not run it. Ask user or propose safer alternative.

## Goal

Find likely bug from production error/symptom, explain cause, impact, evidence, and propose fixes. Do not implement fixes until user says it is OK to code.

## Workflow

1. Restate safety boundary: read-only investigation, no prod mutation.
2. Collect inputs:
   - Error message/stack trace
   - Request/job/user/order IDs
   - Timestamp/time zone
   - Recent deploy/commit
   - Logs/monitoring links or pasted output
   - Expected vs actual behavior
3. Inspect code read-only:
   - Search relevant classes, controllers, jobs, serializers, services, models, scopes, callbacks.
   - Check recent git diff/log only if useful.
4. Form hypotheses:
   - Map stack trace to code path.
   - Identify data assumptions and edge cases.
   - List evidence for/against each hypothesis.
5. Request production observations only when needed.
6. For Rails console needs:
   - Do not run console yourself.
   - Propose one read-only snippet.
   - Copy snippet to clipboard with `pbcopy` so user can paste it.
   - Wait for user to paste result.
7. Final output:
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

After proposing a Rails console snippet, copy exactly that snippet to clipboard using local shell:

```bash
cat <<'RUBY' | pbcopy
# snippet here
RUBY
```

Then say: `snippet copied to clipboard. Paste into Rails console, then paste output here.`

## Prohibited Output

Do not provide production mutation commands as a suggested quick fix. If a data repair might be needed, describe it conceptually and wait until user explicitly authorizes coding/repair planning.
