---
name: prod-debug
description: Read-only production debugging workflow for production incidents, prod bugs, Sentry errors, logs, Rails console observations, and live data symptoms. Use when asked to investigate, find, explain, or verify a production issue. Strictly forbids production mutation; runs approved read-only monitoring/log/MCP queries directly, but always copies Rails console (and other live-session) commands to clipboard for the user to run.
---

# Prod Debug

Use this skill for production incident/debug tasks where safety matters more than speed.

Default stance: investigate read-only using local code and approved read-only production tools/MCP. Run narrowly scoped monitoring/log/data queries directly; never mutate production. For Rails console/runner, live interactive sessions, or commands without an approved read-only tool path, prepare the exact read-only command/snippet, copy it to the clipboard, and ask the user to paste/run it.

## Hard Safety Rules

- Read-only task until user explicitly says code changes are allowed.
- Do not change code, config, migrations, seeds, scripts, feature flags, env vars, jobs, queues, caches, or production data.
- Do not run any production command yourself, except approved read-only monitoring/log/data queries via read-only tools or MCP. Rails console and any other live interactive production session must always be run by the user via copy/paste handoff, never by the assistant, even read-only.
- Do not run any command that can create/edit/delete DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, retry/replay events, acknowledge incidents, toggle flags, or trigger side effects.
- Do not run Rails console commands directly against production.
- Do not run Rails runner directly against production.
- Do not run migrations, rake tasks, backfills, data fixes, or admin scripts.
- Do not use `save`, `save!`, `update`, `update!`, `create`, `create!`, `destroy`, `destroy!`, `delete`, `delete_all`, `update_all`, `insert`, `upsert`, `touch`, `increment!`, `decrement!`, `deliver_now`, `deliver_later`, `perform_later`, or similar mutators.
- Treat indirect writes as writes. Avoid app methods with callbacks, tracking, audit writes, counters, timestamp updates, external writes, or job enqueues. Network requests for approved read-only queries are allowed; normal service-side access logging does not itself make a read query a mutation.
- If unsure whether action mutates state, do not run it. Ask user or propose safer alternative.

## Allowed Actions

Allowed for the assistant:

- Read and search local code/docs.
- Inspect local git status, diff, log, and blame.
- Run approved, narrowly scoped read-only monitoring/log/data queries through tools or MCP, using configured authentication without exposing credentials.
- Copy read-only commands/snippets requiring user execution to clipboard.

Not allowed within this skill, even when implementation is approved:

- Any production/staging credential use outside approved read-only tool/MCP queries; never extract, print, or copy credentials.
- Any command that starts app runtime, console, runner, jobs, workers, servers, or tests against live services.
- Any command where environment or side effects are uncertain.

Read-only monitoring/log/data queries run directly through approved read-only tools or MCP integrations (e.g. Sentry, log search, dashboards) are allowed without user copy/paste, as long as they are strictly read-only and scoped. Rails console, Rails runner, and any other live interactive production session remain user-executed only, even read-only: generate the command/snippet and use the clipboard handoff. Other runtime/task prohibitions above still apply. Code-change approval does not expand these production-access permissions.

## Goal

Find likely bug from production error/symptom, explain cause, impact, evidence, and propose fixes. Do not implement fixes until user says it is OK to code.

## Work context

Inspect the target repo's local `.agent-work/`: `work/<work-id>/spec.md` defines requirements, `work/<work-id>/plan.md` defines design, shared `context/` contains glossaries and `decisions/` contains ADRs. Read selected spec/plan status, acceptance criteria, non-goals and testing decisions; verify reciprocal links and Work-ID. Use explicit user paths, current-session confirmation, or validated reciprocal links only. Otherwise shortlist titles/statuses/summaries and ask via question tool, even with one candidate, offering Other / None—standalone work. Never select by name, slug, branch, or recency; unavailable questioning is a blocker. Clarify conflicting requirements or broken links. Do not force artifact creation for ordinary diagnosis or write docs in this read-only workflow. Pass selected paths/constraints to workers; missing identity requires a clarification request. Selection never authorizes implementation or production access.

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
6. For production observations via approved read-only tools/MCP (monitoring, log search, dashboards, etc.):
   - Run directly, scoped narrowly (time/result bounds), redacting/minimizing sensitive fields.
   - Never use a write/mutate/ack/replay/toggle capability, even if exposed by the same tool.
   - If the query result is large or sensitive, summarize rather than dumping raw records.
7. For any production shell command/log query without an approved direct read-only tool/MCP path:
   - Do not run it yourself.
   - Make it read-only and narrowly scoped, with result/time bounds; ask the user to verify environment and read-role support first.
   - Minimize sensitive fields; request redacted results, never credentials or whole customer records.
   - Immediately execute a local `pbcopy` handoff command that copies the literal payload; do not merely display the handoff command or ask the user to copy manually. Never execute the embedded payload.
   - If clipboard access is unavailable or denied, show the payload once in a fenced block as fallback.
   - Wait for the user to paste the result before continuing.
8. For production Rails console/runner needs (always, even read-only):
   - Do not run console or runner yourself, under any circumstance.
   - Generate one read-only snippet and immediately copy it through the same local clipboard handoff.
   - On successful copy, do not print or repeat the snippet in the response; return only the terse confirmation from `Clipboard Step`.
   - Wait for user to paste result.
9. Final output:
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

Perform this step automatically whenever a read-only command/snippet requiring user execution is ready. Do not use this handoff for approved read-only tool/MCP queries that the assistant can run directly. Execute the local clipboard command through the shell; never give the clipboard command to the user as an instruction. Copy exactly the payload, without Markdown fences or commentary. Clipboard contents may sync or enter history, so use placeholders rather than secrets. The quoted heredoc prevents shell expansion and must never execute its contents.

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
