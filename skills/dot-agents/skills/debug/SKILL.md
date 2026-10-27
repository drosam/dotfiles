---
name: debug
description: Read-only local debugging workflow for failing tests, local errors, Rails runner investigations, logs, stack traces, and confusing app behavior. Use when asked to debug, investigate, find, explain, reproduce, or verify a local development issue. Runs only read-only commands by default. A local mutating Rails command may run only when the user explicitly asks to run that specific mutation; permission is one-shot and immediately returns to read-only.
---

# Debug

Use this skill for local development debugging where the agent may run commands, inspect runtime behavior, and gather evidence, but must not modify code or persistent state before implementation is authorized.

Default stance: run local read-only investigation commands yourself when useful. Do not edit files, change configuration, migrate databases, seed data, enqueue jobs, or mutate persistent local state until the user explicitly says to start implementing. Implementation approval does not authorize a state-mutating command.

## Hard Safety Rules

- Read-only task until user explicitly says code changes or implementation are allowed.
- Run or generate only read-only commands by default.
- Do not edit code, config, migrations, seeds, scripts, docs, tests, lockfiles, or generated files.
- Do not run formatters, autofixers, code generators, migrations, seeds, backfills, destructive rake tasks, or cleanup tasks.
- Do not run commands that create/edit/delete persistent DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, or trigger side effects, except for the one-shot local Rails exception below.
- Do not use Rails/ActiveRecord mutators such as `save`, `update`, `create`, `destroy`, `delete`, `insert`, `upsert`, `touch`, `increment!`, `deliver_now`, or `perform_later`, except for the one-shot local Rails exception below.
- Treat indirect writes as writes. Avoid callbacks, tracking, audit logs, counters, timestamps, network writes, and job enqueues.
- Do not start long-running servers, workers, watchers, or interactive consoles unless the user explicitly asks.
- If unsure whether a command mutates state, do not run it. Ask or choose a safer command.

### One-shot local Rails mutation exception

Apply this exception only when the user explicitly asks the assistant to run a specific Rails command that changes local state.

- Do not infer authorization from “fix it,” implementation approval, prior mutation approval, or a request to investigate.
- Require a concrete target and intended change. If scope or side effects are unclear, ask before running anything.
- State the exact mutation and environment before execution. Run only that requested Rails command, once.
- Do not broaden it into migrations, rake tasks, shell commands, retries, cleanup, follow-up mutations, or additional records.
- After that single execution attempt, immediately restore the read-only command boundary. Verification must be read-only.
- Require a new explicit user request for every additional mutating command.
- Never apply this exception to production or staging.

## Allowed Local Actions

Allowed before implementation approval:

- Read and search local code/docs/logs.
- Inspect git status, diff, log, and blame.
- Run bounded read-only shell commands.
- Run focused diagnostics that do not alter source files or persistent data.
- Run Rails runner with query-only snippets only after verifying the local environment and boot/initializer behavior. A read-looking snippet does not make application startup side-effect-free.
- Run read-only database queries through app APIs when bounded by IDs/time ranges/limits.

Ask first when a command may alter persistent state, depend on external services, take a long time, or produce large output. Tests/builds may write caches, coverage, fixtures, or databases; do not assume they are read-only. Redact secrets and personal data from commands, logs, and reported results.

## Goal

Find likely cause from local error/symptom, explain evidence, and propose a fix plan. Do not implement the fix until user says it is OK to code.

## Work context

Read relevant work artifacts under the target repo's `.agent-work/`: `work/<work-id>/spec.md` (requirements), `work/<work-id>/plan.md` (design), shared `context/` (glossaries) and `decisions/` (ADRs). Read selected spec/plan status, acceptance criteria, non-goals and testing decisions; verify reciprocal links and Work-ID. Use only an explicit user path, current-session confirmation, or validated reciprocal link for selection. Otherwise shortlist titles/statuses/summaries and ask via question tool, even with one candidate, including Other / None—standalone work. Never select by filename, slug, branch, or recency; if asking is unavailable, report the blocker. Clarify broken links or conflicting requirements. No documents is valid for ordinary diagnosis; do not create them or modify artifacts in this read-only workflow. Pass confirmed paths/constraints to workers; missing identity returns a clarification request, not a guess. Selection does not authorize implementation.

## Workflow

1. Restate boundary: read-only local investigation, no implementation yet.
2. Collect inputs:
   - Error message/stack trace
   - Command/test that failed
   - Relevant IDs, params, fixture names, or timestamps
   - Expected vs actual behavior; separate supplied observations from assumptions
   - Recent diff/commit if relevant
3. Inspect code read-only:
   - Search relevant classes, controllers, jobs, serializers, services, models, scopes, callbacks, tests, and logs.
   - Check recent git diff/log only if useful.
   - Before claiming frontend/backend parity, find duplicate implementations and compare the relevant callers, inputs, and conditions; one matching function is insufficient.
4. Form hypotheses:
   - Map stack trace to code path and identify data assumptions.
   - Rank plausible causes with evidence for/against and one read-only check that could disprove each; do not invent alternatives just to meet a count.
5. Reproduce or observe locally with safe commands:
   - Seek a fast, repeatable signal for the exact reported symptom, not merely successful startup.
   - Prefer the smallest safe command; record invocation, observed result, and expected result.
   - Bound runtime and output. Minimize inputs one at a time without changing persistent state.
   - If no safe reproduction exists, report that limit and request a redacted artifact; do not add instrumentation or fabricate verification.
   - Update hypothesis status from results. Label conclusions VERIFIED or INFERRED and cite evidence type: code inspection, runtime observation, or user-supplied output.
   - Code inspection verifies what the cited code says, not that the reported behavior occurred. Do not claim a confirmed runtime root cause or "not reproducible" from code reading alone.
6. Use Rails runner when app state inspection helps:
   - Run it yourself only against local development/test environment.
   - Keep snippet query-only and bounded unless the current user message explicitly authorizes one specific local Rails mutation under the one-shot exception.
   - Prefer primitive output via `pluck`, `pick`, `ids`, `count`, `exists?`, `where`, `select`, `limit`, `order`, `find_by`, and `readonly`.
7. If the user explicitly requests a local Rails mutation:
   - Apply only the one-shot exception above.
   - Report whether that one execution succeeded, failed, or was not attempted.
   - Return to read-only checks immediately.
8. Final output:
   - `bug:` concise conclusion labeled VERIFIED or INFERRED; leave cause unresolved when evidence is insufficient.
   - `evidence:` bullets with commands/files.
   - `verify:` read-only checks already run or still useful.
   - `fix plan:` implementation options.
   - `next:` ask user if ready to start implementing.

## Rails Runner Rules

Before preparing any Rails snippet or SQL query, verify columns and types against `db/schema.rb` or `db/structure.sql`, and associations, scopes, methods, and enum meanings against their definitions. Cite checked file paths/lines. Never guess names or treat an integer/enum as a boolean. If definitions are unavailable or deployed schema parity is uncertain, state the gap and request the missing definition or a bounded read-only schema check before using it.

When needing local Rails data, generate and run snippets that:

- Only read data, unless the current user message explicitly requests one specific local mutation under the one-shot exception.
- Avoid callbacks and app methods with possible side effects.
- Prefer direct ActiveRecord query methods and primitive columns.
- Avoid loading huge records. Bound by IDs/time ranges and result limits; a small result does not guarantee a cheap query (especially `count` or sorting).
- Treat `readonly` and reading roles as defense in depth, not a sandbox for arbitrary app methods.
- Avoid `inspect` on large objects or objects with expensive methods. Prefer hashes of primitive values.
- Avoid external service clients.
- For read-only snippets, avoid writes even inside transactions. Rollback is not enough if code has non-DB side effects.

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

Do not present or run a mutation command as a quick fix during investigation. If a data repair, migration, code change, or test update may be needed, describe it conceptually. Only run a local mutating Rails command after the user explicitly requests that specific execution; that permission expires after one attempt.
