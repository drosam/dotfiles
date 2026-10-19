# Debug Skill Contract

## Intent and scope

Guide local development diagnosis with read-only commands and no code edits until separately authorized. Permit one narrowly scoped exception: run one specific local mutating Rails command only when the user explicitly requests that execution.

## Inputs and outputs

Inputs: local symptom, errors, relevant identifiers, expected behavior, inspected code/logs, and any explicit user authorization. Outputs: evidence-backed diagnosis, read-only checks, fix plan, and—only under the exception—the result of one requested local Rails mutation attempt.

## Safety invariants

- Commands are read-only by default. Investigation, urgency, “fix it,” implementation approval, and earlier mutation approval do not authorize runtime mutation.
- Mutation authorization must explicitly request running a specific Rails change against local development/test state, with a concrete target and intended effect.
- Authorization covers one command and one execution attempt only. It excludes retries, follow-up records, migrations, rake/shell tasks, cleanup, and inferred changes.
- Restore the read-only command boundary immediately after the attempt. Every additional mutation requires a new explicit request.
- Never apply the exception to production or staging. Never use uncertain or external side effects without clarification.
- Code-edit authorization remains separate from command-mutation authorization.

## Evidence and acceptance checks

1. Ordinary debug prompts produce only read-only commands and conceptual repair options.
2. “Fix it” or “start implementing” never causes a mutating Rails command.
3. An explicit local Rails mutation request states environment, target, and effect; executes at most once; reports the result; then uses read-only verification.
4. A second mutation is refused or held until a new explicit request.
5. Ambiguous environment, target, or side effects trigger clarification instead of execution.
6. Production mutation is never run under this skill.

## Limitations

Rails callbacks and application methods can hide side effects. Static inspection cannot guarantee runtime safety; uncertainty requires clarification. Skill wording reduces surprise but cannot enforce external runtime permissions.
