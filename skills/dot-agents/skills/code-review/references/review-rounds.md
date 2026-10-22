# Review Rounds

Read this file immediately before dispatching review workers. A round is an independent sample of the existing review dimensions, not a new review dimension or a refinement of an earlier result.

## 1. Select the round count

- An explicit `rounds=N` or equivalent request wins. Accept only integers from 1 through 3. For an invalid explicit value, stop and ask for a valid value; never clamp it silently.
- A quick full-dimension review or an explicitly narrowed review uses 1 round unless the user supplies another valid count.
- Every other review uses 2 rounds by default. Do not ask for confirmation.
- Use 3 rounds only when explicitly requested. Diff size changes scope partitioning, not the sample count.

Before dispatch, print the selected count and cost. For a full review use this shape:

```text
Review rounds: <N>
Discovery workers: <4N+2>
- <N> x 4 review dimensions
- 1 intent-blind worker
- 1 whole-change simplicity worker
Single-run work: spec mapping, docs/history, checks, verification
```

A quick full-dimension review still includes the intent-blind and simplicity workers. For an explicitly narrowed review, replace `4 review dimensions` and the total with the applicable dimension count, name excluded dimensions, and exclude blind/simplicity unless the user explicitly includes them. Start after printing; do not request another confirmation.

## 2. Prepare shared inputs once

The coordinator owns scope, requirements, rules, documentation, history, deployment context and validation inventory. Resolve them once, then give every sampled worker the same immutable target and relevant evidence packet. Do not repeat spec discovery, documentation/history collection, static checks or deployment lookup per round.

Use these four dimensions in every full round:

| Dimension | Preferred agent if available | Required focus |
| --- | --- | --- |
| Behavior/spec/edge cases | `general` | Requirements, wiring, state transitions, callers and input-dependent failures |
| Security/data/rollout | `code-review-security` | Reachable threats, tenant boundaries, persistence, migration, deployed-version coexistence, devex and feature-gate leaks |
| Tests/reliability/performance | `general` | Behavioral test validity, failure handling, concurrency, resource limits and operational evidence |
| Rules/docs/patterns/code health | `code-review-code-health` | Scoped rules, best practices, doc consistency, recent precedents, ownership, invariants and structural simplification |

Tag every task with its round and dimension, for example `R1 behavior` or `R2 security`. General workers receive the complete analytical rubric, not only the dimension name. Specialized workers cover their entire row. Pass the resolved skill path and relevant contract/rubric text, but state that shared validation execution remains coordinator-owned. Sampled workers inspect test code and CI evidence and propose discriminating checks; they do not run repository test/lint/typecheck/build commands or browser flows during discovery. Workers never spawn nested workers.

Each sampled worker receives the exact target/commit IDs, local-change inventory when applicable, confirmed Work-ID and selected documents, relevant rules/spec/docs, comparison sources and this return contract:

```text
Read-only review; no nested workers. This is independent sample <round>/<total>,
<dimension>. Do not inspect another worker's findings. Inspect beyond the diff
when necessary. Return all supported findings with path:line, trigger, impact,
evidence, counterevidence, fix direction, and regression-check suggestion.
Return checked/not-applicable/unchecked coverage with reasons and sources.
Do not assume another worker covers an omitted risk. Identify tool failures.
Do not execute shared validation commands or browser flows; propose checks for
coordinator verification after claim deduplication.
```

Launch all round workers plus the applicable blind and simplicity workers in parallel in one tool turn when capacity permits. Otherwise use bounded waves without exposing completed findings to workers that have not started. Independent sampling is lost if a later round receives earlier findings or is asked merely to confirm them.

## 3. Run one intent-blind worker

Run one `code-review-blind` worker outside the rounds for every full review, including a quick full-dimension review. Exclude it from an explicitly narrowed review unless the user explicitly includes it. Give it the pinned diff/content scope, applicable repository rules, safety/evidence/severity contract and output schema. Filter selected spec/plan/ticket paths and other intent documents out of the supplied diff/content command before launch; if reliable filtering is impossible, mark blind coverage unchecked instead of exposing them. Pass the minimum work identity required by the active harness: Work-ID, status and selected document paths labeled `identity only - do not read`. Withhold document contents, user requirements, decisions, tickets, PR description/discussion, commit-message rationale, coordinator interpretation and all other findings. Tell it not to inspect those sources.

The blind worker judges implementation behavior without author intent. It does not replace requirement fidelity and cannot decide whether unspecified behavior violates the spec. Reconcile its findings against requirements only after it returns. If `code-review-blind` is unavailable, mark blind coverage unchecked; a general worker whose standing instructions require reading selected work documents is not a valid fallback.

## 4. Run one whole-change simplicity worker

Run one `code-review-simplicity` worker outside the rounds for every full review, including a quick full-dimension review. Exclude it from an explicitly narrowed review unless the user explicitly includes it. Launch it alongside the rounds after the shared scope/requirements packet is ready.

Give it the pinned target, confirmed Work-ID and selected requirements/design context, explicit user decisions, scope/non-goals, relevant business/domain harms and the dedicated simplicity return contract. It asks whether optional capability/variation/generality can be removed or deferred, or an existing proven approach can eliminate a substantial new subsystem, while preserving confirmed requirements and safety. It reviews the whole change, not line-level style or internal ownership/lifecycle redesign, and proposes checks without executing shared validation.

Requirement-preserving simplicity proposals are candidates, not findings or votes. Tag them `simplicity`, verify the requirement and code evidence once, check user/business cost and strongest counterevidence, then classify only supported actionable proposals through the normal severity/gate rules. A proposal contradicting a confirmed requirement is an `optional scope challenge`, never a finding or readiness input; present it only for an explicit user decision. `No significant simplicity cut` completes the pass without inventing a finding. If `code-review-simplicity` is unavailable, use `general` with the same focused packet and explicit instruction not to perform the four dimension passes.

## 5. Handle failures without bias

A denied or failed sampled dimension worker gets one permitted sequential fallback using the same round/dimension packet. A missing dimension specialist falls back to `general`. A failed simplicity worker gets one `general` fallback with the focused simplicity packet. Do not use `general` for the blind role, retry through broader permissions or tell another sample what the failed worker found.

If fallback cannot complete, mark that round/dimension or simplicity coverage `unchecked` with the reason and next action. A failed sample is not a clean vote and cannot disappear because another round completed. Required unchecked round, simplicity or applicable blind coverage prevents `READY` unless the user explicitly narrowed it out before dispatch.

## 6. Build and verify the claim ledger

After every worker returns:

1. Record each candidate with source tags such as `R1 behavior`, `R2 code health`, `blind` or `simplicity`.
2. Merge only findings with the same trigger, failed behavior, root cause and remedy. Preserve distinct failures at the same location.
3. Record support by distinct round: `found by 1/2 rounds` or `found by 2/2 rounds`. Multiple dimensions in one round still count as one supporting round. Blind support and simplicity proposals are listed separately, never counted as round agreement.
4. Treat agreement only as a confidence/tie-breaking signal. It is not evidence, does not establish correctness and never raises severity.
5. Validate every unique candidate once through the normal synthesis procedure: inspect the full path, strongest counterevidence, requirements and safe checks. Drop disproven candidates; retain consequential uncertainty as a gap.
6. Preserve every supported actionable finding. No vote threshold and no top-N cap.

Report round completion, blind coverage, simplicity coverage and worker failures. Perform static checks, final scope/worktree stability checks, artifact persistence and readiness synthesis once against the pinned target.
