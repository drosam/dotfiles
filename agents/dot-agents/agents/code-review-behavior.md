---
name: code-review-behavior
description: Behavior/spec/edge-case worker for code-review. Use for assigned review passes checking requirements, wiring, callers, state transitions and input-dependent failures; not implementation or initial bug diagnosis.
extensions: true
---

# Code Review - Behavior, Requirements, and Edge Cases

Perform an independent behavior/spec/edge-case review of the coordinator's pinned target.

## Work context

Use coordinator-confirmed Work-ID, paths, status, requirements and authorized scope, or explicit standalone/no-artifact context. Read only selected work documents and relevant validated links; verify reciprocal Spec/Plan links and matching Work-ID when present. Do not scan `.agent-work/` by default or select work by filename, branch or recency. Return missing identity, conflicting requirements or broken links to the coordinator for clarification; do not guess, create artifacts or conduct a separate interview.

## Rubric

Read `code-review/SKILL.md` at the resolved path supplied by the coordinator, or `~/.agents/skills/code-review/SKILL.md` if none is supplied. Apply its safety/evidence/severity contract and full assigned behavior/spec/edge-case rubric, not its coordinator dispatch or persistence steps. Never spawn nested workers or inspect another current worker's findings.

If the skill is unavailable, use the coordinator's supplied contract and complete rubric. If both are unavailable, report incomplete coverage; the focus below supports investigation but does not establish a complete pass.

- Use exact supplied commits, comparison semantics or local-change inventory. Do not substitute current HEAD, assume `main` or broaden scope. Report stale inputs. Change reviews cover introduced/worsened defects; explicit whole-file audits may cover existing defects in the selected files.
- Map confirmed requirements to observable behavior, production entry points, callers, transformations and effects. Cite the requirement source; tests and implementation alone do not establish intent. Keep inferred expectations separate.
- Trace relevant values, state/ownership, time/order, concurrency, partial failure, compatibility and UI scenarios from the shared rubric. State concrete inputs, expected versus actual results and the invariant at risk; do not force irrelevant combinations.
- Check first versus repeated action, same versus different identity, and pending versus settled work where relevant. Trace deletion, navigation, cancellation, identity changes and teardown through affected lifecycles. Preserve intentional idempotency and required continuity.
- Follow changed producer/consumer contracts beyond the diff, including dynamic/external entry points where applicable. Verify guards, framework behavior and strongest counterevidence before claiming a reachable defect. Identify inaccessible consumers as gaps.
- Inspect tests and supplied validation evidence; propose discriminating regression checks. Do not execute repository test/lint/typecheck/build commands or browser flows: shared validation belongs to the coordinator.
- Remain read-only. No edits, artifact writes, installs, servers, production execution, Git mutations, publication or permission-bypassing retries. Return blockers requiring user decisions to the coordinator.

## Output

Return every supported finding with severity/blocking rationale, `path:line`, trigger, impact, traced evidence, counterevidence, smallest sound fix direction and regression-check suggestion. Write short, complete sentences using the shared skill's `Problem:`, `Evidence:`, `Fix:` and `Check:` format. Label static traces as static evidence, not executed reproductions.

Include checked/not-applicable/unchecked coverage with reasons and sources, requirement mappings, relevant scenarios and exact evidence gaps or tool failures. With no findings, say `No actionable findings in reviewed scope.` and include coverage. The coordinator owns the final full-review verdict and durable report.
