# Review Evidence Examples

Synthetic calibration cases, not findings about the current repository or executed tests. Confirm the stated prerequisites in real target code before using an analogous conclusion.

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

Finding: P1 blocking — an authenticated user supplying another tenant's valid invoice ID can read that invoice. Cite changed lookup and the verified controller/policy/model path. State static confirmation unless reproduced in an isolated test.

Remediation: restore the verified tenant scope and applicable object-level policy. Regression check: authorized invoice succeeds; another tenant's invoice and insufficient-role access fail without exposing content. Do not run the exploit against production.

## 3. False positive: equivalent guard confirmed elsewhere

Same-looking global lookup, but a policy is unconditionally enforced before data exposure. Inspect its implementation: it verifies both tenant membership and the required role for this exact object; all relevant callers invoke it. Inspect denial tests and any alternate response paths.

Result: do not report IDOR just because the lookup lacks an inline tenant condition. If policy source cannot be read, this is an unresolved boundary, not proof of either vulnerability or safety. Do not propose duplicate guards without a concrete benefit or applicable rule.

## 4. Recent code is not necessarily deployed or correct

Input: the target branch recently introduced a new event format; this PR removes the old decoder. A nearby implementation already uses only the new decoder.

Check: trace event producers, deployment records per service, retained/queued old payloads, migration docs, and rollback consumers. A merged producer PR does not prove every producer is live or old messages are drained.

- Confirmed live old producer or queued old payload plus traced decoding failure: report the compatibility regression and recommend an expand–contract transition with old/new payload tests.
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

Input: the user agreed that an expired invitation must be rejected without creating membership. The referenced PRD's “Invitation expiry” section confirms this; the changed implementation and its new test both accept expired invitations.

Map the requirement to that conversation decision and PRD section, then trace the expiry guard and membership creation. A passing new test is not proof of intended behavior: report the traced violation, the appropriate severity/blocking rationale and a regression check using an independently chosen expired timestamp. Mark the evidence static unless the path was actually exercised. Do not fix it merely because implementation was authorized earlier; await the required finding decision.

If the conversation is unavailable and the PRD does not settle expiry semantics, do not infer acceptance from the implementation or invent rejection as a requirement. Ask for the decision and mark that requirement unverified. A clean lint run cannot settle it. If the contract additionally requires browser verification and browser access is unavailable, report that check separately as blocked; no whole-change READY until required evidence exists.

## 9. Anti-pattern: guessed pattern violation

Bad: “All recent services use helper X, so this implementation is wrong.”

Correct: inspect independent recent examples and their rationale. If X enforces a mandatory ownership check omitted here, cite that concrete invariant and reachable failure. If the implementations have different contracts or the departure is sound, record justified departure with no finding. Popularity, recency and deployment alone cannot prove correctness.
