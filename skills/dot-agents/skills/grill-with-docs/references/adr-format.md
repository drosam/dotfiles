# ADR Format

Save in `.agent-work/decisions/`, sequential `NNNN-slug.md`. Scan that directory for the highest number and increment; inspect the destination to avoid overwrites. Existing project ADRs elsewhere remain reference material; writing outside `.agent-work/` requires an explicit user request.

## Template

```md
# {Short title of the decision}

**Work-ID:** <confirmed work slug, or Standalone>
**Spec:** <relative link to confirmed spec, or Not created>
**Plan:** <relative link to confirmed plan, or Not created>

{1-3 sentences: context, what was decided, and why.}
```

From `.agent-work/decisions/`, confirmed work links use `[Spec](../work/<work-id>/spec.md)` and `[Plan](../work/<work-id>/plan.md)`. Use actual paths for user-approved multi-document layouts; do not link to absent artifacts.

A single decision paragraph plus the work header is a complete ADR. Optional sections, only when they add value:

- `status:` frontmatter (`proposed | accepted | deprecated | superseded by NNNN`) when decisions get revisited
- **Considered options** when rejected alternatives are worth remembering
- **Consequences** when downstream effects are non-obvious

## Gate: offer only when all three hold

1. **Hard to reverse** - changing course later costs real effort.
2. **Surprising without context** - a future reader would ask "why this way?"
3. **Real trade-off** - genuine alternatives existed and one was chosen for stated reasons.

Missing any one: no ADR. Most sessions produce zero; that is expected.

## Typically qualifies

- Architectural shape (monorepo, event-sourced write model)
- Integration patterns between contexts (events vs synchronous calls)
- Technology with lock-in (database, message bus, auth provider)
- Boundary and ownership rules, including explicit "no"s
- Deliberate deviations from the obvious path
- Constraints invisible in code (compliance, partner SLAs)
- Non-obvious rejected alternatives that would otherwise be re-proposed

## Does not qualify

Naming, easily reversible library picks, local refactors, anything a reader would find unsurprising.
