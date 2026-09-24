# Skill Writer Eval Prompts

Use these prompts when deeper evaluation matters (high-risk, regression tracking, or explicit request).
These are optional guidance artifacts, not required outputs for every skill.

## Integration/Documentation Depth Eval

```text
Use `skill-writer` to synthesize a new skill named `pi-agent-integration-eval` for working with the resolved, version-pinned Pi agent-core package as a consumer in downstream libraries.

Primary objective: produce a non-surface-level integration skill that covers API surface, known issues/workarounds, and common real-world use cases.

Scope:
- Source root: `<pi-mono-root>/packages/agent`
- This is for USING Pi in another library, not editing Pi internals.

Mandatory source retrieval:
- README, CHANGELOG
- `src/index.ts`, `src/agent.ts`, `src/agent-loop.ts`, `src/types.ts`, `src/proxy.ts`
- `test/agent.test.ts`, `test/agent-loop.test.ts`
- In-repo usage scan for key APIs (for example Agent, agentLoop, streamProxy, convertToLlm, transformContext, steer, followUp, continue)

Required depth artifacts:
- `references/api-surface.md`
- `references/common-use-cases.md` (at least 6 concrete downstream use cases)
- `references/troubleshooting-workarounds.md` (at least 8 failure modes with fixes/workarounds)
- `references/integration-patterns.md` (happy path, robust variant, anti-pattern + correction)

Depth gates (hard fail if missing):
- Coverage matrix includes: API surface, options/config, runtime lifecycle, event semantics, queue semantics, failure modes, version variance, downstream usage patterns.
- Any partial coverage includes explicit next retrieval actions.
- Qualitative depth rubric includes pass/fail for API/workaround/use-case/gap handling.
- Run validator and report output.

Output sections:
1) Summary
2) Changes Made
3) Validation Results
4) Open Gaps
```

## Pass/Fail Rubric

Pass only if all required artifacts exist and have the requested depth.
Fail if API mapping is partial, workaround guidance is shallow, or use cases are generic and not actionable.
Fail if completion is claimed with unresolved high-impact gaps and no next retrieval actions.

## Optional Deep-Eval Pattern

When you need stronger confidence, run this sequence:

1. Use a fixed prompt set (positives + negatives).
2. Capture deterministic traces (`codex exec --json`).
3. Apply rubric/schema checks where practical (`--output-schema`).
4. Compare baseline vs candidate and report deltas.

## Isolated Eval Runbook

Only run after explicit evaluation approval. Create a fresh isolated workspace using available, permitted tooling; never delete/reuse a fixed temporary path or copy credentials, customer data, or unrelated WIP into it.

1. Save the original skill as the unchanged baseline before editing.
2. Run the same prompt and permitted inputs against baseline and candidate in separate workspaces. Use the available agent runner; do not assume Codex, Claude, a browser viewer, or a particular subprocess API exists.
3. Keep working cases distinct from holdout cases. Capture outputs, command failures, and cost/timing when available; do not invent unavailable metrics.
4. Compare against the rubric and report whether evidence came from static review or actual execution.

Validate generated output using the existing validator from its actual skill root:

```bash
python3 <skill-dir>/scripts/quick_validate.py <generated-skill-dir> --skill-class integration-documentation --strict-depth
```

Requires Python 3.12+ and PyYAML. Use an existing environment; installing dependencies or provisioning through `uv run` needs approval. If blocked, report the missing dependency and any limited fallback checks separately from strict-depth validation.
