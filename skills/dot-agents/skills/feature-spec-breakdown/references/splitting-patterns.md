# Splitting Patterns

Read when a slice is too big, too small, or resists splitting.

## Check the input first

A slice that cannot be split is usually a task or component pretending to be behavior. Combine it with the work that makes it observable, then split again.

## Too big — try in order

1. **Workflow steps**: build the simplest end-to-end path first (start and end), then add middle steps. Never split one step per ticket from start to finish.
2. **Operations**: "manage X" → create / edit / delete / list.
3. **Business-rule variations**: one ticket per rule ("by one collection", "by several collections", "excluding collection").
4. **Data variations**: simplest data shape first; add types, locales, or edge data later.
5. **Entry methods / UI**: plain input first, richer UI (picker, drag-and-drop) later.
6. **Major effort**: "support one of A/B/C" then "support the rest", when the first carries the infrastructure.
7. **Simple / complex**: capture the simplest version; move each "what about…?" into its own ticket.
8. **Defer non-functional**: make it work, then make it fast/scalable/secure. Never defer security a user-facing slice needs to be safe.
9. **Spike** (last resort): time-boxed investigation whose acceptance criteria are the questions to answer; follow with the build ticket.

Meta-pattern: find the core complexity, list its variations, reduce to one complete slice through it.

## Choosing between splits

- Prefer the split that exposes low-value work you can defer or drop.
- Prefer the split that yields similarly sized tickets.

## Too small — merge when

- It has no observable behavior or cannot be tested alone (a migration, a type, a component without a caller).
- It only exists because of a layer boundary (API without UI that uses it, unless the API is the product).
- Two tickets always ship together and share every acceptance criterion.

## Size signals

- Big: covers several stories or rules, more than a handful of acceptance criteria, "and" in the title, needs more than one fresh implementation context or one reviewable change.
- Uncertain domain: slice only the first one or two tickets that teach something; list the rest as open questions rather than inventing them.

Source: Humanizing Work story-splitting guide (see SOURCES.md).
