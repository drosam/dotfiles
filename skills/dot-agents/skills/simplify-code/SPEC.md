# Simplify Code Contract

## Intent and boundaries

Shared/provider-neutral workflow for discovering and proposing simplifications across a feature branch or PR, then implementing only approved changes. A PR is optional; current/local branch and confirmed base suffice. Architecture, unnecessary edge-case machinery, clarity and cohesive decomposition are first-class; line reduction is not the goal.

Not a full defect/security review, automatic post-edit hook, whole-repository redesign, feature implementation, or triage of supplied review comments. Existing `code-review` and `review-triage` remain unchanged. Absorbs `deslop` catalogs and local-idiom checks into the whole-branch/PR workflow; no separate recent-changes mode.

## Inputs and outputs

Inputs: branch/PR or current branch, confirmed base/range, local worktree inventory, requirements/rules/docs, code/callers/tests, available evidence and explicit user decisions.

Outputs: pinned scope/coverage, current versus proposed design, numbered evidence-backed proposals with affected files and behavior/validation contracts, retained protections, unknowns and approval request. After authorized implementation: precise changes, accepted behavior losses, actual validation results and gaps.

## Invariants

- No PR or hosting integration prerequisite. Resolve ambiguity rather than guess base or silently include WIP; confirm stacked-branch target.
- Inspect full branch change and affected paths; disclose coverage gaps and revalidate stale approvals.
- Confirm facts before asserting; proposed benefits/effort remain judgments. No fabricated rarity, deployment, equivalence or test results.
- Distinguish behavior-preserving refactoring from explicit scope reduction. Rare reachable behavior is still behavior; generic simplification approval does not authorize its removal.
- Rarity alone cannot justify removing serious-risk or mandatory-contract protections. Check consumers/invariants and simpler ways to retain protection.
- Split for cohesion and ownership; consolidate wasteful layers. No universal file-size, adapter-count, purity or minimum-finding rule.
- Preserve WIP and test scenarios. No dependencies, installs, production actions, external publication or git mutation implied.
- Default proposal-only; implementation requires explicit item/bundle authorization. Broader scope or changed behavior requires a revised decision.

## Acceptance checks

1. “Simplify this branch before opening a PR” works with local refs and confirmed base; missing base or empty diff asks rather than invents scope.
2. A redundant private routing framework produces a concrete before/after architecture proposal with caller and contract evidence.
3. A mixed-responsibility file produces a cohesive ownership/test-boundary proposal, not arbitrary fragments.
4. A useful one-adapter boundary and high-consequence rare-path protection are retained unless a proven equivalent is available.
5. A proven low-value cosmetic case can be proposed for removal only with exact behavior loss and explicit scope-change approval; unknown frequency stays unknown.
6. Semantic traps, unmapped deleted tests, stale worktree/head, denied evidence and failing build do not become successful simplifications.
7. No justified simplification is an acceptable outcome; partial review does not imply branch/merge readiness.
8. “Deslop” uses the same stated whole-branch/PR scope. Requests limited to recent edits require clarification, not a silent scope change.
9. Cleanup candidates carry a local-idiom/novel/ambiguous neighbor check; catalogs guide discovery but cannot override verified contracts. A novel boolean fallback remains when nil would violate the return contract.
10. Generic and relevant language catalogs load for cleanup; a local convention alone does not justify a stylistic rewrite. “Looks good” does not authorize edits without an explicit item/bundle decision.

## Evaluation limits

Structural validation and synthetic desk cases establish instruction coverage, not model adherence, refactoring correctness or measured comprehension gains. Runtime behavior and validation depend on the target repository and permissions. See SOURCES.md for evidence and remaining checks.
