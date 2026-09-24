# Review Triage Contract

## Scope

Shared, provider-neutral skill for evaluating existing review comments or bug lists and deciding whether each merits action. Not a fresh review, automatic repair loop, PR approval or deployment workflow.

Inputs: original feedback and order, target/current code, relevant rules/docs/tests, available evidence and user decisions. Outputs: one evidence-backed assessment and fix/skip/defer recommendation at a time, followed by an explicit decision and truthful action status.

## Invariants

- Preserve item order/identity; no silent merging, skipping, reordering or edits.
- Confirm factual claims with scoped evidence before presenting them; unknowns stay explicit. Separate confirmed validity, frequency and impact from proposed repairs, estimates and recommendations, which remain labeled judgments.
- Flag confirmed very rare low-impact cases as not necessary to fix when repair cost exceeds benefit. Do not use rarity to waive serious risks or mandatory requirements.
- Approval is item-scoped unless the user explicitly authorizes broader work. No remote publication, dependency installation, production access or git mutation implied.
- Denied tools and missing evidence result in a stated gap, not guessed findings or speculative fixes.
- After approved fixes, distinguish implementation from passing validation; skipped/deferred blockers remain unresolved.
- Pi SYSTEM.md retains a short router and approval fallback independent of skill loading. The skill itself has no Pi-only API or runtime dependency.

## Acceptance

1. Existing comments trigger triage; a fresh “review this PR” routes to code-review instead.
2. Each point includes original message, location, context, meaning, evidence, fix, likelihood, impact, worth-fixing assessment, recommendation and question.
3. Synthetic low-impact/rare, serious/unknown-frequency, unreachable, stale and inaccessible-evidence cases produce distinct recommendations without guessing.
4. Fix/skip/defer/discuss decisions advance or hold the queue correctly; a failed validation does not become fixed/verified.
5. Detailed workflow moves out of the global prompt; no unrelated settings or review skill changes.

## Limitations

Qualitative labels depend on available evidence, not a statistical model. Descriptions and routing instructions cannot guarantee model adherence. Structural checks and desk cases do not measure runtime precision. See SOURCES.md for provenance, registration and validation results.
