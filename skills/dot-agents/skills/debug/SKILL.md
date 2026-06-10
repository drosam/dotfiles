---
name: debug
description: Read-only local debugging workflow for failing tests, local errors, Rails runner investigations, logs, stack traces, and confusing app behavior. Use when asked to debug, investigate, find, explain, reproduce, or verify a local development issue. Allows local read-only commands, including Rails runner, but forbids edits and persistent mutation until the user explicitly says to start implementing.
---

# Debug

Use this skill for local development debugging where the agent may run commands, inspect runtime behavior, and gather evidence, but must not modify code or persistent state before implementation is authorized.

Default stance: run local read-only investigation commands yourself when useful. Do not edit files, change configuration, migrate databases, seed data, enqueue jobs, or mutate persistent local state until the user explicitly says to start implementing.

## Hard Safety Rules

- Read-only task until user explicitly says code changes or implementation are allowed.
- Do not edit code, config, migrations, seeds, scripts, docs, tests, lockfiles, or generated files.
- Do not run formatters, autofixers, code generators, migrations, seeds, backfills, destructive rake tasks, or cleanup tasks.
- Do not run commands that create/edit/delete persistent DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, or trigger side effects.
- Do not use Rails/ActiveRecord mutators: `save`, `save!`, `update`, `update!`, `create`, `create!`, `destroy`, `destroy!`, `delete`, `delete_all`, `update_all`, `insert`, `upsert`, `touch`, `increment!`, `decrement!`, `deliver_now`, `deliver_later`, `perform_later`, or similar.
- Treat indirect writes as writes. Avoid callbacks, tracking, audit logs, counters, timestamps, network writes, and job enqueues.
- Do not start long-running servers, workers, watchers, or interactive consoles unless the user explicitly asks.
- If unsure whether a command mutates state, do not run it. Ask or choose a safer command.

## Allowed Local Actions

Allowed before implementation approval:

- Read and search local code/docs/logs.
- Inspect git status, diff, log, and blame.
- Run bounded read-only shell commands.
- Run focused diagnostics that do not alter source files or persistent data.
- Run Rails runner with query-only snippets.
- Run read-only database queries through app APIs when bounded by IDs/time ranges/limits.

Ask first when a command may alter persistent state, depend on external services, take a long time, or produce large output.

## Goal

Find likely cause from local error/symptom, explain evidence, and propose a fix plan. Do not implement the fix until user says it is OK to code.

## Workflow

1. Restate boundary: read-only local investigation, no implementation yet.
2. Collect inputs:
   - Error message/stack trace
   - Command/test that failed
   - Relevant IDs, params, fixture names, or timestamps
   - Expected vs actual behavior
   - Recent diff/commit if relevant
3. Inspect code read-only:
   - Search relevant classes, controllers, jobs, serializers, services, models, scopes, callbacks, tests, and logs.
   - Check recent git diff/log only if useful.
4. Reproduce or observe locally with safe commands:
   - Prefer the smallest focused command.
   - Bound runtime and output.
   - Avoid commands that write source/generated files or persistent data.
5. Form hypotheses:
   - Map stack trace to code path.
   - Identify data assumptions and edge cases.
   - List evidence for/against each hypothesis.
6. Use Rails runner when app state inspection helps:
   - Run it yourself only against local development/test environment.
   - Keep snippet query-only and bounded.
   - Prefer primitive output via `pluck`, `pick`, `ids`, `count`, `exists?`, `where`, `select`, `limit`, `order`, `find_by`, and `readonly`.
7. Final output:
   - `bug:` concise likely root cause.
   - `evidence:` bullets with commands/files.
   - `verify:` read-only checks already run or still useful.
   - `fix plan:` implementation options.
   - `next:` ask user if ready to start implementing.

## Rails Runner Rules

When needing local Rails data, generate and run snippets that:

- Only read data.
- Avoid callbacks and app methods with possible side effects.
- Prefer direct ActiveRecord query methods and primitive columns.
- Avoid loading huge records. Always bound with IDs/time ranges/limits.
- Avoid `inspect` on large objects or objects with expensive methods. Prefer hashes of primitive values.
- Avoid external service clients.
- Avoid writes even inside transactions. Rollback is not enough if code has non-DB side effects.

Example:

```bash
bin/rails runner '# READ ONLY: local debug. Query-only; no writes, no jobs, no external calls.
rows = Order.where(id: [123, 456]).limit(10).pluck(:id, :status, :created_at)
puts rows.map { |id, status, created_at| { id: id, status: status, created_at: created_at }.inspect }
nil'
```

If app supports read replica roles locally, prefer:

```bash
bin/rails runner '# READ ONLY: local debug. No writes, no jobs, no external calls.
ActiveRecord::Base.connected_to(role: :reading) do
  rows = Order.where(id: [123, 456]).limit(10).pluck(:id, :status, :created_at)
  puts rows.map { |id, status, created_at| { id: id, status: status, created_at: created_at }.inspect }
end
nil'
```

## Prohibited Output

Do not present a mutation command as a quick fix during investigation. If a data repair, migration, code change, or test update may be needed, describe it conceptually and ask before implementing.
