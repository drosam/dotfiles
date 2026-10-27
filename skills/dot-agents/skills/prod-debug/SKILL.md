---
name: prod-debug
description: Read-only production debugging workflow for production incidents, prod bugs, Sentry errors, logs, Rails console observations, and live data symptoms. Use when asked to investigate, find, explain, or verify a production issue. Runs approved read-only queries directly and copies Rails commands for user execution. A mutating production Rails command may be prepared only when the user explicitly asks for that specific copy/paste command; permission is one-shot and never permits assistant execution.
---

# Prod Debug

Use this skill for production incident/debug tasks where safety matters more than speed.

Default stance: investigate read-only using local code and approved read-only production tools/MCP. Run narrowly scoped monitoring/log/data queries directly; never mutate production yourself. For Rails console/runner, live interactive sessions, or commands without an approved read-only tool path, prepare the exact read-only command/snippet, copy it to the clipboard, and ask the user to paste/run it. A mutating Rails handoff is allowed only under the one-shot exception below.

## Hard Safety Rules

- Read-only task until user explicitly says code changes are allowed. Code-change approval does not authorize production mutation.
- Run or generate only read-only commands by default.
- Do not change code, config, migrations, seeds, scripts, feature flags, env vars, jobs, queues, caches, or production data.
- Do not run any production command yourself, except approved read-only monitoring/log/data queries via read-only tools or MCP. Rails console and any other live interactive production session must always be run by the user via copy/paste handoff, never by the assistant, even read-only.
- Do not run any command that can create/edit/delete DB data, enqueue jobs, send emails/webhooks, mutate cache, call external write APIs, retry/replay events, acknowledge incidents, toggle flags, or trigger side effects.
- Do not run Rails console commands directly against production.
- Do not run Rails runner directly against production.
- Do not run migrations, rake tasks, backfills, data fixes, or admin scripts.
- Do not generate Rails/ActiveRecord mutators such as `save`, `update`, `create`, `destroy`, `delete`, `insert`, `upsert`, `touch`, `increment!`, `deliver_now`, or `perform_later`, except for the one-shot handoff below.
- Treat indirect writes as writes. Avoid app methods with callbacks, tracking, audit writes, counters, timestamp updates, external writes, or job enqueues. Network requests for approved read-only queries are allowed; normal service-side access logging does not itself make a read query a mutation.
- If unsure whether action mutates state, do not run it. Ask user or propose safer alternative.

### One-shot production Rails mutation handoff

Apply this exception only when the user explicitly asks for a specific mutating Rails command/snippet to copy and paste into production.

- Do not infer authorization from “fix it,” implementation approval, repair discussion, incident urgency, prior mutation approval, or a request to investigate.
- Require a concrete target and intended change. If scope, environment, or side effects are unclear, ask before preparing anything.
- Prepare only the requested Rails command/snippet. Clearly label it as mutating production and state its intended effect and known side effects before handoff.
- Never execute or test the payload against production. Copy it through `Clipboard Step`; the user must run it.
- Do not broaden it into migrations, rake tasks, shell commands, retries, cleanup, follow-up mutations, or additional records.
- After that single handoff, immediately restore the read-only command boundary. Verification commands must be read-only.
- Require a new explicit user request for every additional mutating command/snippet.

## Allowed Actions

Allowed for the assistant:

- Read and search local code/docs.
- Inspect local git status, diff, log, and blame.
- Run approved, narrowly scoped read-only monitoring/log/data queries through tools or MCP, using configured authentication without exposing credentials.
- Copy read-only commands/snippets requiring user execution to clipboard.
- Under the one-shot exception only, copy the exact user-requested mutating Rails command/snippet to clipboard for user execution.

Not allowed within this skill, even when implementation is approved:

- Any production/staging credential use outside approved read-only tool/MCP queries; never extract, print, or copy credentials.
- Any command that starts app runtime, console, runner, jobs, workers, servers, or tests against live services.
- Any command where environment or side effects are uncertain.

Read-only monitoring/log/data queries run directly through approved read-only tools or MCP integrations (e.g. Sentry, log search, dashboards) are allowed without user copy/paste, as long as they are strictly read-only and scoped. Rails console, Rails runner, and any other live interactive production session remain user-executed only: generate the command/snippet and use the clipboard handoff. Other runtime/task prohibitions above still apply. Code-change approval does not expand these production-access permissions. Only the one-shot exception permits a mutating Rails handoff, never execution.

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
   - Expected vs actual behavior; separate supplied observations from assumptions
3. Inspect code read-only:
   - Search relevant classes, controllers, jobs, serializers, services, models, scopes, callbacks.
   - Check recent git diff/log only if useful.
   - Before claiming frontend/backend parity, find duplicate implementations and compare the relevant callers, inputs, and conditions; one matching function is insufficient.
4. Form hypotheses:
   - Map stack trace to code path and identify data assumptions.
   - Rank plausible causes with evidence for/against and one read-only check that could disprove each; do not invent alternatives just to meet a count.
   - Update hypothesis status from results. Label conclusions VERIFIED or INFERRED and cite evidence type: code inspection, runtime observation, or user-supplied output.
   - Code inspection verifies what the cited code says, not that the reported behavior occurred. Do not claim a confirmed runtime root cause or "not reproducible" from code reading alone.
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
8. For production Rails console/runner needs:
   - Do not run console or runner yourself, under any circumstance.
   - Generate one read-only snippet by default and immediately copy it through the same local clipboard handoff.
   - Generate a mutating snippet only when the current user message explicitly requests that specific handoff; apply the one-shot exception and return to read-only immediately after copying.
   - On successful copy, do not print or repeat the snippet in the response; return only the terse confirmation from `Clipboard Step`.
   - Wait for user to paste result.
9. Final output:
   - `bug:` concise conclusion labeled VERIFIED or INFERRED; leave cause unresolved when evidence is insufficient.
   - `evidence:` bullets.
   - `impact:` affected users/data/path.
   - `verify:` read-only checks.
   - `fix options:` safe implementation choices.
   - `next:` ask user if ready to code.

## Rails Console Snippet Rules

Before preparing any Rails snippet or SQL query, verify columns and types against `db/schema.rb` or `db/structure.sql`, and associations, scopes, methods, and enum meanings against their definitions. Cite checked file paths/lines. Never guess names or treat an integer/enum as a boolean. If definitions are unavailable or deployed schema parity is uncertain, state the gap and request the missing definition or a bounded read-only schema check before using it.

When needing production data, generate snippets that:

- Only read data, unless the current user message explicitly requests one specific mutating Rails handoff under the one-shot exception.
- Avoid callbacks and app methods with possible side effects.
- Prefer `pluck`, `pick`, `ids`, `count`, `exists?`, `where`, `select`, `limit`, `order`, `find_by`, `readonly`.
- Avoid loading huge records. Always bound with IDs/time ranges/limits.
- Avoid `inspect` on objects if it may trigger expensive or side-effect methods. Prefer hashes of primitive columns.
- Avoid external service clients.
- For read-only snippets, avoid writes even inside transactions. Rollback is not enough if code has non-DB side effects.

### Read-only snippet format

Make a read-only snippet self-contained and clearly read-only. Example:

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

### Mutating snippet format

Use only under the one-shot exception. Make the mutation target explicit, avoid broader selectors, avoid unrelated callbacks/services where possible, and include a visible warning:

```ruby
# MUTATES PRODUCTION: perform only the exact user-requested change.
# Verify the environment, target ID, current value, and intended new value before running.
```

Do not append a second mutation or automatic retry. Any follow-up mutation requires a new explicit request.

## Clipboard Step

Perform this step automatically whenever a command/snippet requiring user execution is ready. Mutating payloads require the one-shot explicit request above; all others must be read-only. Do not use this handoff for approved read-only tool/MCP queries that the assistant can run directly. Execute the local clipboard command through the shell; never give the clipboard command to the user as an instruction. Copy exactly the payload, without Markdown fences or commentary. Clipboard contents may sync or enter history, so use placeholders rather than secrets. The quoted heredoc prevents shell expansion and must never execute its contents.

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

Do not provide a production mutation command as a suggested quick fix or infer permission from repair planning. Describe a possible data repair conceptually unless the user explicitly requests that specific mutating Rails command for copy/paste. That one-shot permission expires immediately after one handoff and never authorizes execution.
