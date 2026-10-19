# Production Debug Skill Contract

## Intent and scope

Guide production diagnosis with strictly read-only assistant execution. Permit one narrowly scoped exception: prepare and copy one specific mutating Rails command/snippet only when the user explicitly requests that production copy/paste handoff. The assistant never executes production Rails commands.

## Inputs and outputs

Inputs: incident evidence, production identifiers and bounds, inspected local code, approved read-only tool results, and any explicit user authorization. Outputs: evidence-backed diagnosis, read-only observations, fix options, and—only under the exception—one clipboard handoff for the exact requested Rails mutation.

## Safety invariants

- Commands are read-only by default. Investigation, urgency, “fix it,” implementation approval, repair planning, and earlier mutation approval do not authorize a mutation handoff.
- Mutation authorization must explicitly request a specific production Rails command/snippet to copy and paste, with a concrete target and intended effect.
- Authorization covers one generated Rails payload and one handoff only. It excludes execution, retries, follow-up records, migrations, rake/shell tasks, cleanup, and inferred changes.
- Label the payload as mutating production; disclose intended effect and known side effects; use placeholders rather than secrets.
- Restore the read-only command boundary immediately after handoff. Every additional mutating payload requires a new explicit request.
- Never execute or test the payload against production. The user remains the executor.
- Code-edit authorization remains separate from production mutation-handoff authorization.

## Evidence and acceptance checks

1. Ordinary production debug prompts produce only read-only commands and conceptual repair options.
2. “Fix it,” “repair this,” or implementation approval never produces a mutating command.
3. An explicit request for a specific production Rails mutation produces at most one clipboard payload and no assistant execution.
4. After handoff, verification commands are read-only; a second mutation requires a new explicit request.
5. Ambiguous environment, target, or side effects trigger clarification before payload creation.
6. Non-Rails mutation commands remain prohibited.

## Limitations

Rails callbacks and application methods can hide side effects. The user must verify environment and payload before execution. Clipboard synchronization/history may expose contents, so secrets must not be embedded. Skill wording cannot enforce permissions in the production runtime.
