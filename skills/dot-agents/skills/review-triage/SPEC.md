# Review Triage Contract

## Scope

Shared, provider-neutral skill for evaluating existing review comments or bug lists and deciding whether each merits action. Not a fresh review, automatic repair loop, PR approval or deployment workflow.

Inputs: original feedback and order, target/current code, relevant rules/docs/tests, available evidence and user decisions. Outputs: immutable full source review at `.agent-work/work/<work-id>/reviews/<branch-key>/<review-id>/review.md`, append-only sibling `triage.md`, ordered work/branch indexes with per-branch Latest review and Active triage pointers, and one evidence-backed assessment and fix/skip/defer recommendation at a time followed by an explicit decision and truthful action status.

## Invariants

- Preserve item order/identity; no silent merging, skipping, reordering or edits. Preserve `review.md` immutably and record triage transitions append-only.
- Select Work-ID explicitly or by validated current-session/document context; propose and confirm a new Work-ID when absent. Select a review by exact/current-session path or the verified current branch index: resume follows Active triage, while latest follows Latest review. Never select by timestamp order. Pin triage to that review for the session and preserve older indexed reviews.
- Confirm factual claims with scoped evidence before presenting them; unknowns stay explicit. Separate confirmed validity, frequency and impact from proposed repairs, estimates and recommendations, which remain labeled judgments.
- Flag confirmed very rare low-impact cases as not necessary to fix when repair cost exceeds benefit. Do not use rarity to waive serious risks or mandatory requirements.
- Approval is item-scoped unless the user explicitly authorizes broader work. Choosing Fix authorizes the smallest agreed repair and one focused local commit after successful validation; no remote publication, dependency installation, production access or other git mutation is implied.
- Denied tools and missing evidence result in a stated gap, not guessed findings or speculative fixes. Failed artifact persistence requires an explicit continue-without-state decision.
- `.agent-work/` artifacts are never staged, committed, ignored, overwritten, or silently unstaged; staged artifacts block mutation pending clarification.
- After approved fixes, distinguish implementation, passing validation and successful commit; append and verify each transition before investigating the next item. Skipped/deferred blockers remain unresolved.
- Pi SYSTEM.md retains a short router and approval fallback independent of skill loading. The skill itself has no Pi-only API or runtime dependency.

## Acceptance

1. Existing comments trigger triage; a fresh “review this PR” routes to code-review instead.
2. Each point shows its identifier and full original message, preserving formatting and embedded code without truncation (secrets redacted explicitly), then one short context sentence with verified location and one short fix/skip/defer verdict sentence. Allow a second verdict sentence for material risk or uncertainty. Ask Fix / Skip / Defer / Discuss through the available question tool, or plain text if unavailable; no duplicate question or mandatory field checklist.
   - Supported false positives/redundant defenses/needless abstractions are flagged as AI slop with a concrete reason, not an authorship claim. Verified very rare low-impact cases are flagged as not worth fixing only when benefit fails to justify cost; unknown rarity and serious risks are not dismissed.
   - Discuss expands only the requested details, keeps the current item active and asks for a decision again; discussion alone never authorizes fixing or skipping.
3. Synthetic low-impact/rare, serious/unknown-frequency, unreachable, stale and inaccessible-evidence cases produce distinct recommendations without guessing.
4. Fix/skip/defer/discuss decisions advance or hold the queue correctly; a failed validation or commit does not become fixed/verified, and each validated fix is committed through the `commit` skill before the next item is investigated.
5. Detailed workflow moves out of the global prompt; the fallback router preserves approval and per-fix commit gates, with no unrelated settings changes.
6. New feedback is saved once under the confirmed Work-ID and exact branch series using a unique timestamp/source/target Review-ID. Existing exact-path/current-session reviews are reused. Branch indexes keep Latest review separate from Active triage; changing Git branches selects another branch index without rewriting any other branch's state.
7. Pre-PR, PR revision, and GitHub feedback reviews share a branch series only when repository/head-branch identity is verified. Different branches remain separate; detached, renamed, colliding, or mismatched identities require clarification. GitHub feedback records a complete verbatim source snapshot: exact overall-review URL/body when present and every comment's stable URL, identity, author/context, unchanged text and source order, plus retrieval time and target SHA. Missing, inaccessible, truncated, secret-redacted, or customer-data-redacted content is explicit.
8. `review.md` retains the complete original review and is never changed after verification. `triage.md` records the source link, pinned branch/target, initial queue, presented assessments, decisions, checks, commits, blockers, corrections, and final summary as append-only events. Starting triage sets only that branch's Active triage; terminal completion clears it.
9. Resume reads and validates both complete files before acting. Broken identity/source links, branch/target mismatch, competing active/latest choices, staged artifacts, or unverified append operations stop advancement rather than guessing state.

## Limitations

Qualitative labels depend on available evidence, not a statistical model. Descriptions and routing instructions cannot guarantee model adherence. Append-only Markdown requires reading the full event log to reconstruct current state; expected review sizes make this simpler and safer than duplicate machine state. Filesystem/index failures remain possible and must be reported. Structural checks and desk cases do not measure runtime precision. See SOURCES.md for provenance, registration and validation results.
