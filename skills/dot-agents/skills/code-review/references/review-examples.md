# Review Evidence Examples

Synthetic calibration cases, not findings about the current repository or executed tests. Confirm the stated prerequisites in real target code before using an analogous conclusion.

## Contents

- [1. Complete review](#1-happy-path-complete-review-without-invented-issues)
- [2. Tenant regression](#2-true-positive-tenant-lookup-regression)
- [3. Equivalent guard](#3-false-positive-equivalent-guard-confirmed-elsewhere)
- [4. Deployment evidence](#4-recent-code-is-not-necessarily-deployed-or-correct)
- [5. Documentation contracts](#5-relevant-docs-version-and-stale-contract-checks)
- [6. Failure recovery](#6-failure-recovery-denied-worker-and-blocked-tests)
- [7. Retry side effects](#7-edge-case-timeout-after-an-external-side-effect)
- [8. Requirement provenance](#8-completed-fix-verification-requirement-provenance)
- [9. Pattern false positives](#9-anti-pattern-guessed-pattern-violation)
- [10. Repeated repair obligations](#10-structural-finding-repeated-repairs-reveal-ownership-cost)
- [11. Mode and contract boundaries](#11-safe-boundaries-mode-splits-and-required-inputs)
- [12. Lifecycle and UI composition](#12-cross-path-check-cleanup-and-responsive-capabilities)
- [13. Independent review rounds](#13-independent-review-rounds-and-claim-verification)
- [14. Whole-change simplicity](#14-whole-change-simplicity-without-deleting-required-behavior)
- [15. Reuse and consumer contracts](#15-reuse-and-consumer-contracts-beyond-pattern-consistency)
- [16. Same-identity events](#16-repeated-action-with-unchanged-record-identity)
- [17. Repair closure](#17-repair-closure-without-revision-confusion)

## 1. Happy path: complete review without invented issues

Input: whitespace-only source formatting with no runtime contract change. All diff lines and callers inspected; applicable style/doc rules and recent comparable changes checked; focused tests and required lint pass on the exact target. Deployment compatibility is inapplicable because no executable behavior changes.

Output: `No actionable findings in reviewed scope.` Include checked dimensions, specific doc/precedent paths, exact command results, deployment inapplicability, and scoped READY. Do not require an invented security issue or human sign-off.

## 2. True positive: tenant lookup regression

Synthetic change:

```ruby
# Before
invoice = current_account.invoices.find(params[:id])
# After
invoice = Invoice.find(params[:id])
```

Evidence required: the reachable route accepts an invoice ID; the caller authenticates but does not authorize that invoice; `Invoice` has no equivalent mandatory tenant scope; the response exposes invoice data. A recent same-endpoint protection or incident fix strengthens the history explanation, not severity by itself.

Finding: P1 blocking - an authenticated user supplying another tenant's valid invoice ID can read that invoice. Cite changed lookup and the verified controller/policy/model path. State static confirmation unless reproduced in an isolated test.

Remediation: restore the verified tenant scope and applicable object-level policy. Regression check: authorized invoice succeeds; another tenant's invoice and insufficient-role access fail without exposing content. Do not run the exploit against production.

## 3. False positive: equivalent guard confirmed elsewhere

Same-looking global lookup, but a policy is unconditionally enforced before data exposure. Inspect its implementation: it verifies both tenant membership and the required role for this exact object; all relevant callers invoke it. Inspect denial tests and any alternate response paths.

Result: do not report IDOR just because the lookup lacks an inline tenant condition. If policy source cannot be read, this is an unresolved boundary, not proof of either vulnerability or safety. Do not propose duplicate guards without a concrete benefit or applicable rule.

## 4. Recent code is not necessarily deployed or correct

Input: the target branch recently introduced a new event format; this PR removes the old decoder. A nearby implementation already uses only the new decoder.

Check: trace event producers, deployment records per service, retained/queued old payloads, migration docs, and rollback consumers. A merged producer PR does not prove every producer is live or old messages are drained.

- Confirmed live old producer or queued old payload plus traced decoding failure: report the compatibility regression and recommend an expand-contract transition with old/new payload tests.
- Only merge evidence available and live compatibility is required: report recent merged precedent, deployment unverified, exact missing revision/queue-contract evidence, INCOMPLETE.
- Confirmed old producer retired, old data migrated, rollback contract compatible: do not invent a regression merely because the old decoder was removed.

## 5. Relevant docs: version and stale-contract checks

Input: a configuration variable is renamed; implementation and new tests agree. The deployment runbook still sets the old variable, and the application no longer accepts it.

Verify the startup lookup/default and the actual documented deployment command. Report the concrete misconfiguration and cite both locations. Recommend updating the runbook and preserving a compatibility alias when the rollout contract requires it; test both configurations through the documented transition.

For an uncertain framework default, resolve the locked version and its official docs/source. A current web page describing a newer major version is not confirmation. If matching behavior cannot be established, record the exact unresolved default and required lookup rather than guessing.

## 6. Failure recovery: denied worker and blocked tests

Input: parallel security worker denied; focused tests cannot load a missing dependency.

Allowed recovery: inspect the security paths sequentially with permitted tools. Record whether that pass actually completed. Do not retry the denied agent through another privilege path or install the dependency automatically.

If required tests remain unrun, report the exact command/error and prerequisite; verdict INCOMPLETE if no proven blocker, BLOCKED if a blocking defect was independently confirmed. Never claim failed infrastructure proves a product bug or that successful static review means tests passed.

## 7. Edge case: timeout after an external side effect

Input: a worker retries a charge request on timeout. The remote service may commit before the response is lost.

Confirm the provider's version-matched idempotency contract, key construction, persistence, retry behavior and error handling. If each retry demonstrably uses a new key and the provider treats keys independently, trace the duplicate-charge path and recommend a stable operation-scoped key with a timeout-after-success regression test.

If a verified wrapper already persists and reuses the key, suppress the duplicate-charge finding. If provider semantics are unknown, investigate official docs; do not assert financial loss or invent an amount.

## 8. Completed-fix verification: requirement provenance

Input: the user agreed that an expired invitation must be rejected without creating membership. The referenced PRD's "Invitation expiry" section confirms this; the changed implementation and its new test both accept expired invitations.

Map the requirement to that conversation decision and PRD section, then trace the expiry guard and membership creation. A passing new test is not proof of intended behavior: report the traced violation, the appropriate severity/blocking rationale and a regression check using an independently chosen expired timestamp. Mark the evidence static unless the path was actually exercised. Do not fix it merely because implementation was authorized earlier; await the required finding decision.

If the conversation is unavailable and the PRD does not settle expiry semantics, do not infer acceptance from the implementation or invent rejection as a requirement. Ask for the decision and mark that requirement unverified. A clean lint run cannot settle it. If the contract additionally requires browser verification and browser access is unavailable, report that check separately as blocked; no whole-change READY until required evidence exists.

## 9. Anti-pattern: guessed pattern violation

Bad: "All recent services use helper X, so this implementation is wrong."

Correct: inspect independent recent examples and their rationale. If X enforces a mandatory ownership check omitted here, cite that concrete invariant and reachable failure. If the implementations have different contracts or the departure is sound, record justified departure with no finding. Popularity, recency and deployment alone cannot prove correctness.

## 10. Structural finding: repeated repairs reveal ownership cost

Input: a catalog panel caches availability. Six mutation paths manually invoke refresh; history contains separate fixes for omitted refresh after deleting an item and deleting a group. All six currently refresh correctly.

Bad: report the repaired stale-data bugs as still present, or declare the architecture sound because those regressions now pass.

Correct: produce an ownership trace with real source locations: persisted allocations -> cached availability; list mutation writers and callback propagation; link the two inspected fixes. Establish whether callers are independent domain operations or mere adapters to an existing canonical mutation owner.

If freshness demonstrably depends on distributed caller bookkeeping, report the remaining coordination cost separately from the resolved bugs. Propose ownership at a canonical mutation boundary or a dependency-aware derived-state owner, not another forwarding wrapper. State blocking status from actual impact/rules; no invented current outage.

Check before prescribing: removal needs previous dependency IDs; grouped changes affect nested items; some availability changes may not modify visible lines; stale responses and redundant refreshes need handling. A subscription to an incomplete dependency set is not a sound fix. Regression checks: add, remove, grouped remove and alternate writers; verify response ordering and bounded requests.

Counterexample: a shared mutation layer already performs complete invalidation and callers supply distinct required inputs. Record that owner and suppress the distributed-repair claim. Likewise, a deliberate editable draft is not redundant authority merely because it resembles saved state. Compare synchronization obligations, not variable names.

## 11. Safe boundaries: mode splits and required inputs

Input: a chip component's mode flag switches between live records and a fetched snapshot, affecting effects, reset logic and rendering. A parent already knows the mode. Separately, two views implement similar record-selection predicates and internal callbacks are typed optional.

Investigate three independent contracts:

- Enumerate each mode's data/lifecycle and required continuity. A parent-selected split is useful if it removes coordination without losing pending operations or focus. Loading/error fallback inside the fetched mode may still be necessary; do not claim splitting removes it. A flag that only changes styling does not justify separate components.
- Compare selector rules for ownership, nesting, archival and record types. Share a proven common predicate, retaining deliberate view-specific filters. A textual predicate difference alone is not proof of different visible results; trace feasible records before asserting a user-facing bug.
- Search actual production callers before marking inputs required or removing guards. If every internal caller guarantees an entity/callback, encode that contract at its owner. If a shared overlay has a valid caller without the callback, preserve optionality there. Runtime type annotations alone do not enforce an invariant; retain necessary trust-boundary validation.

Expected finding: cite the specific coordination burden and reduced design, with mode-toggle, loading/error, in-flight-operation, selector and caller-boundary checks as applicable. Suppress findings where the split adds more complexity or breaks an intentional snapshot/draft lifecycle.

## 12. Cross-path check: cleanup and responsive capabilities

Input: a quantity control now flushes a deferred write on unmount so opening a panel does not discard edits. The same control also unmounts when its record is deleted; production debounce is 300ms, while test mode bypasses it.

Trace edit -> pending timer -> deletion/ORM removal -> unmount -> flush -> request target. Check whether deletion finishes before cleanup, whether the request helper already suppresses missing records, and whether failures surface. A proven request against a deleted record supports a finding; unknown ordering remains a specific race hypothesis, not a claimed reproduction. Exercise deletion and navigation as well as panel opening with realistic or controlled timing. Do not globally cancel cleanup writes if valid navigation must still persist edits.

UI variant: opening the panel unmounts the original summary; a replacement column is hidden below a breakpoint. Cross mounting with responsive visibility to identify which contents/actions remain reachable. Compare the loss against acceptance criteria or established behavior; if intent is unavailable, ask the design question instead of inventing a requirement. Check nested overlays similarly: trace which layer owns Escape, without assuming multiple listeners are inherently broken.

## 13. Independent review rounds and claim verification

Happy path: a normal review announces 2 rounds and 10 discovery workers, then launches two independent samples of each existing dimension plus one intent-blind worker and one whole-change simplicity worker. `R1 behavior` and `R2 tests` report the same retry defect. The coordinator merges them because trigger, failed behavior, root cause and remedy match, records `found by 2/2 rounds`, and verifies the unique claim once against code and counterevidence. Agreement supports confidence only; traced behavior determines validity and impact. Simplicity proposals are attributed separately.

Robust variant: `R2 security` fails to start. Retry once with a permitted sequential general-worker fallback and the same pinned packet. If fallback remains blocked, record `R2 security: unchecked`; do not count it as a clean sample or hide it behind `R1 security`. Required missing coverage prevents READY. The blind worker receives code/rules, the output contract and minimum work identity metadata, but never reads selected document contents, requirements, PR rationale, commit-message rationale or earlier findings. If that isolated role is unavailable, blind coverage stays unchecked; a general worker with standing work-document requirements is not a valid fallback.

Anti-pattern: run round 1, summarize its findings into round 2's prompt, then promote issues found twice or raise their severity. Correction: launch rounds independently against identical pinned inputs, preserve distinct failures, validate every unique candidate once, and use `found by x/N rounds` only as attribution and a confidence/tie-breaking signal. One supported finding remains reportable even when only one round found it.

## 14. Whole-change simplicity without deleting required behavior

Happy path: confirmed acceptance requires one provider integration, but the change adds a generic provider registry, adapter lifecycle and configuration DSL without another supported provider. An established direct integration already exists nearby. The simplicity worker proposes reusing it, names the subsystem removed, cites requirements/code and gives migration/regression checks. The coordinator reports the proposal only after verifying the direct path satisfies every confirmed requirement.

Robust variant: removing an old decoder would simplify the code, but deployment evidence shows old queued payloads and rollback consumers remain. The simplicity worker records that counterevidence and returns no cut. Required security, tenancy, money, data integrity, availability and rollback behavior are never deleted merely because they add states or branches. If a confirmed requirement itself could be dropped, record an optional scope challenge for user decision, not a finding.

Anti-pattern: redesign internal state ownership or lifecycle logic already assigned to code health, report every helper/conditional/long file as a simplicity defect, or assign P1 because a cut removes many lines. Correction: ask one whole-change scope/approach question, propose at most three requirement-preserving material cuts, quantify subsystem removed and user/business cost, then let the coordinator independently verify and classify. A sound intentional design may produce `No significant simplicity cut.`

## 15. Reuse and consumer contracts beyond pattern consistency

Input: a new exact-code lookup duplicates an existing scanner lookup's endpoint and association loading. The new request wraps the code in an array to preserve punctuation; the scanner sends a string. A booking function also returns a success boolean that only its tests consume.

Bad: label the requests consistent because both use the same action, recommend a third generic wrapper, or assume every similar request can be merged.

Correct: cite both request paths and callers; compare filter scope, encoding, associations, errors and normalization. Verify whether the consumer already excludes irrelevant records and whether the broader response is complete within pagination/limit rules. Recommend reuse only if the existing lookup preserves the required match set and effects, with punctuation, mixed-record and scanner regression checks. Trace all booking callers before proposing removal of an unread result; preserve promise settlement, error reporting and pending-state cleanup, and make tests assert the required effects.

Robust counterexample: the new lookup's narrower server filter prevents unrelated records consuming a page limit, or the shared request has different permissions/side effects. Record the concrete separation; do not force reuse. A return value used by an external integration is not dead merely because local production callers ignore it. Unknown callers remain a search gap. Required-prop annotations also do not prove runtime enforcement; check the installed framework before claiming a missing warning or prevented crash.

## 16. Repeated action with unchanged record identity

Input: adding an item must reveal its section and scroll its row into view each time. A producer stores `{ id, at }` but returns only `id`; the consumer effect depends on that ID. After one add, the user collapses the section or scrolls away, then adds to the same row again before the marker clears.

Trace: first add changes ID and runs reveal/scroll; second add updates the timestamp but not the exposed ID, so neither operation reruns. Contrast another-row add and same-row add after marker expiry. Report the reachable repeated-action failure and propose exposing an operation change to the consumer, preserving state that must survive updates. A discriminating check performs both adds with the same ID, hides the row between them and asserts the second reveal/scroll before expiry; an assertion that the timer restarted alone cannot detect the failure.

Safe variant: a payment retry must reuse one operation's idempotency identity and must not repeat the charge. Do not create a fresh payment operation merely to force notification. Separate required per-action UI work from domain operations that intentionally deduplicate; trace pending and settled behavior independently.

## 17. Repair closure without revision confusion

Input: a review catches an incorrect root-cause claim in both code documentation and the PR description. The repair corrects only the code comment. Another repair introduces a migration safety bypass whose applicable rule requires a safety explanation.

Correct: pin the repair revision and map each prior finding to affected code, callers, tests, docs/PR claims and newly activated rules. Report the still-stale PR claim as incomplete repair of an already-caught issue. Report the missing safety explanation as introduced by the later repair, not a defect missed before the bypass existed. Check that the explanation matches actual operations rather than accepting suggested prose. Recheck contract simplifications for leftover props, return values, fallback branches and tests that no longer exercise production behavior.

Robust variant: prior code/review evidence is unavailable. Mark attribution unknown and name the missing revision/artifact; independently assess current behavior without inventing a historical miss. If a guard's rationale alleges duplicate records, inspect the backend lock and inference path before adding another guard; a verified serialized path can disprove that premise while leaving an inaccurate comment actionable. If source or locking semantics remain unavailable, retain the precise uncertainty, not a safety claim. Review authority permits neither application edits nor PR-description changes.
