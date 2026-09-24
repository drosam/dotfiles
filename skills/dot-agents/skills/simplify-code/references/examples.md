# Simplification Calibration

Synthetic desk cases, not observed repository findings or executed tests. Each conclusion depends on the stated evidence; substitute actual paths, contracts and results during use.

## 1. Branch without a PR: collapse a private routing framework

Request: “Simplify this feature branch before I open the PR.”

Evidence assumed for this example: user confirms the local base; branch adds a private text-preview pipeline. All registrations and callers have been inspected. Only text preview is required; no public plugin contract, additional configured format, special lifecycle or error translation exists in these layers.

```text
Before: previewEndpoint → previewDispatcher → previewFactory
                        → textStrategy → textRenderer
After:  previewEndpoint → renderTextPreview
```

Proposal: replace private pass-through routing with one domain-named entry point. Keep the rendering implementation and exact input/error contract. Remove associated registration/configuration plumbing, not boundary validation.

- Classification: behavior-preserving refactor, conditional on the stated complete call/registration trace.
- Benefit: caller no longer needs to coordinate three routing concepts for one operation; no claim that a single implementation alone proves redundancy.
- Checks: existing valid/empty/invalid-input outputs and error behavior; all endpoint call sites; repo typecheck/build gates.
- Decision: show affected files and ask before editing. No hosting API or PR creation needed.
- Counterexample: a documented external plugin interface or required variant invalidates the removal argument. Keep the interface or request a separately scoped contract decision.

## 2. Better split, not more fragments

Request: “This changed screen does too much; split it better.”

Evidence assumed: `QuoteScreen` mixes pure quote calculation, network persistence and presentation. Calculation rules change independently of rendering, and tests currently require mounting the screen to exercise arithmetic.

```text
Proposed responsibilities:
  quote-policy.ts  — pure calculation and domain decisions; no UI/network imports
  quote-client.ts  — existing request/response boundary; transport errors retained
  QuoteScreen.tsx  — view state and orchestration using the two modules
```

Keep shared state with its owner; pass explicit inputs/results. Reuse the existing client instead of inventing a repository/provider framework. Verify the extraction preserves rounding, request order, cancellation and stale-response handling where present.

Reject a split into `quoteUtils`, `quoteHelpers`, `quoteManager` and twenty pass-through functions: fewer lines per file without clear ownership can increase navigation and coupling. If calculation and presentation do not actually vary independently, keep them together and improve naming/control flow instead.

## 3. Preserve a useful one-implementation boundary

Candidate: remove `PaymentGateway` because there is one production adapter.

Counterevidence assumed: this interface isolates credentials/network I/O, translates provider errors into the domain contract, and supports existing failure-path tests. Inlining it into callers would distribute that knowledge and side effects.

Recommendation: keep. Adapter count alone is not evidence of unnecessary complexity. Consider simplifying its parameters only if caller evidence supports that change. Do not create another adapter merely to satisfy a numeric design rule.

If tests move behind a consolidated interface, map each old scenario to a retained/new assertion. A test of duplicate-charge handling is not obsolete merely because its original helper disappears.

## 4. Very rare cosmetic behavior: disclose the behavior loss

Evidence assumed: representative telemetry over the supported environments and a stated observation window confirms a very rare transition-only visual artifact. Inspected requirements and behavior show no accessibility, input loss or other functional impact. The PR's extra state machine prevents it; removing that machine would permit the artifact again.

```text
classification: optional scope reduction — not behavior-preserving
proposal: keep the ordinary transition; remove special recovery state
edge-case basis: cite actual trigger, observations/window and impact checks
behavior loss: brief visual artifact under the documented trigger
recommendation: rare edge case — handling not necessary, if user accepts this loss
approval: explicitly approve allowing that artifact; generic refactor approval is insufficient
```

First compare a simple local guard that keeps the behavior: rare handling that costs one clear check may be worth retaining. If telemetry is unavailable or impact uninspected, use unknown/needs evidence; never copy the rarity conclusion from this example.

## 5. Low-frequency failure, high consequence

Candidate: remove retry deduplication because concurrent retries “should almost never happen.”

Counterevidence assumed: the call path permits two charges when a request succeeds remotely but times out locally. Frequency is unknown; the trace establishes potential financial harm.

Recommendation: retain the invariant. Investigate whether existing transactional/uniqueness facilities can implement it with less orchestration, but prove their scope, atomicity and failure behavior first. Never remove the guarantee just to flatten the code. Add/run focused concurrency and timeout checks only after authorization and within safe environments.

## 6. Readability without a semantic shortcut

Illustrative JavaScript condition:

```javascript
// Original contract: missing override uses the account default; false disables it.
const enabled = override == null ? accountDefault : override;

// Wrong simplification: false now selects the account default.
const enabled = override || accountDefault;

// Candidate, if supported by the repo's language target and conventions:
const enabled = override ?? accountDefault;
```

Confirm that `override` is the inspected value, not a getter/effectful expression; verify runtime/language support and null/undefined/false/true cases. Label equivalence here as static reasoning unless checks actually ran. A shorter expression with changed behavior is not a refactor.

For a longer branch chain, a named operation or explicit early returns may be clearer than compact syntax. Explain the reading benefit using the actual local context; no universal one-line preference.

## 7. Missing base or moving target

- No PR and ambiguous base: ask for the intended local base. Do not assume `main`, use the tracking branch as the target, or require creation of a PR.
- Stacked branch: confirm parent-feature versus integration comparison; pin the chosen merge base. Otherwise parent work can be mistaken for this feature's complexity.
- No committed diff but staged/unstaged work exists: offer worktree scope and wait; do not treat the empty branch diff as an audit of local edits.
- Head advances or approved paths acquire WIP: re-read changed evidence and reconcile overlaps before edits. No reset/stash/checkouts to make the approval fit stale code.
- Ref/metadata unavailable and remote retrieval denied: request local refs or the missing diff. State coverage blocked; no alternative tool to bypass the denial.

## 8. Approved change, failed validation

User approves the module split. Focused tests pass, but the production build fails on a circular import introduced by the new exports.

Report both results and exact commands; passing focused tests did not establish completion. Repair the cycle within the approved split if possible, then re-run applicable checks. If repair requires redesigning unrelated module ownership, stop and request a revised scope. Do not delete the failing check, blame a pre-existing cycle without baseline evidence, or declare the branch ready to merge.

## 9. No justified change

Inspected code has a straightforward flow and cohesive boundaries. Proposed helpers merely rename expressions and a proposed split would increase cross-file coordination.

Output: `No justified simplification found in reviewed scope.` State pinned coverage and any missing checks. No quota, fake architecture proposal or automatic formatting churn.
