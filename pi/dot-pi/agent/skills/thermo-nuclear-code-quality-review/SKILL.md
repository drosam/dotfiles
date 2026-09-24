---
name: thermo-nuclear-code-quality-review
description: Strict maintainability audit for branch changes. Use for thermo-nuclear code quality review, thermonuclear maintainability review, harsh code quality audit, abstraction review, spaghetti review, 1k-line rule checks, and code-judo simplification.
disable-model-invocation: true
---

# Thermo-Nuclear Code Quality Review

Perform an unusually strict maintainability and architecture review. Be ambitious about structural simplification. Do not settle for “it works” when the implementation makes the codebase worse.

## Scope

- Review only added/modified code and changed integration paths.
- Honor the caller's pinned diff/base. Otherwise resolve the repository default branch, falling back to `main` only if valid. Stop on invalid refs or empty scope.
- Review read-only; do not edit, commit, or spawn nested review agents.
- Do not report untouched pre-existing issues unless this diff newly exposes or worsens them.
- Read enough surrounding code to understand ownership, boundaries, existing helpers, and file/module size.
- Skip cosmetic nits when structural issues exist.

## Approval bar

Do not approve if the diff creates clear structural regression:

- missed “code judo” move that could delete significant complexity
- file growth materially worsens ownership or navigation; ~1000 lines is a heuristic to investigate, not a mechanical blocker
- ad-hoc special cases or conditionals bolted into unrelated flows
- feature logic leaking into shared/general-purpose code
- duplicate logic, repeated condition cascades, or missing domain model/helper
- unnecessary abstraction, wrapper, magical generic mechanism, or pass-through indirection
- cast-heavy, `any`/`unknown`, optionality churn, or vague object shapes hiding invariants
- logic added in the wrong package/module/layer instead of the canonical owner
- needlessly sequential orchestration or non-atomic related updates
- runtime guard/fallback for states the type/schema/model should make impossible
- consumer-side checks compensating for a producer contract problem
- scattered “just in case” checks that obscure the real invariant
- fallback that silently masks corrupt persisted data

## Review questions

Ask for every meaningful change:

- Can this be reframed so fewer concepts, branches, modes, or helpers exist?
- Is there a simpler ownership boundary that makes this behavior natural?
- Is this logic in the canonical layer?
- Did this make an existing flow more tangled?
- Would a stronger type/schema/constructor make bad states unrepresentable?
- Is the fix at the producer/source rather than a symptom-site consumer?
- Does the abstraction earn its keep?
- Is the file/module still navigable?

## Preferred remedies

Prefer suggestions that remove moving pieces:

- delete indirection instead of polishing it
- move logic to the canonical owner/layer
- extract a focused helper/module/component
- replace condition chains with an explicit typed model/dispatcher
- collapse duplicate branches into one flow
- enforce invariant at source, constructor, schema, or type boundary
- fail loudly for corrupted persisted data instead of silently falling back
- reuse canonical helpers instead of bespoke near-duplicates
- parallelize independent work only when it simplifies orchestration
- make related updates atomic when partial state is hard to reason about

## Evidence bar

For each finding, cite the changed path and concrete maintenance cost, then identify a smaller design with a plausible migration boundary. Check local standards and counterexamples before prescribing an abstraction. Do not delete input validation, corruption handling, or `unknown` at trust boundaries merely because it looks defensive. Distinguish a proven internal invariant from untrusted runtime data.

## Tone

Be direct, serious, and high-conviction. Do not be rude. Do not soften major maintainability issues into mild suggestions.

## Output order

Prioritize:

1. Structural code-quality regressions
2. Missed dramatic simplification/code-judo opportunities
3. Spaghetti/branching growth
4. Boundary/abstraction/type-contract problems
5. File-size/decomposition concerns
6. Modularity/canonical-layer issues
7. Invariant erosion and defensive-check accumulation
8. Legibility/maintainability concerns

Output findings only:

```text
- P1 `path:line` — Problem; impact. Fix: concrete direction.
- P2 `path:line` — Problem; impact. Fix: concrete direction.
```

If no findings and requested coverage is complete, output exactly:

```text
No findings.
```

If incomplete, say `No findings in reviewed scope.` and name the unchecked area/reason. When delegated, return a terse checked/inapplicable/unchecked coverage summary even with no findings.
