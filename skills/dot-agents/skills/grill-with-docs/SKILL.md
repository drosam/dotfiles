---
name: grill-with-docs
description: Stress-tests a plan or design through a dependency-aware interview inside a repository, and records the outcome as it settles - resolved terms into a CONTEXT.md glossary and hard-to-reverse decisions as ADRs. Use when the user says "grill me with docs", wants a grooming session that leaves a paper trail, or wants to document a repo's domain language.
disable-model-invocation: true
---

# Grill With Docs

Same interview as `grill-me`, pointed at a repository, and stateful: what resolves lands on disk during the session, not batched at the end. Self-contained; do not require other skills to load.

## Interview

1. Read the plan, relevant code, and existing `CONTEXT.md` / `CONTEXT-MAP.md` / `docs/adr/`. Identify settled decisions, unresolved branches, factual unknowns, and terms already defined.
2. Ask one round of independent, currently answerable questions. Use the question tool when available; give concrete options and a recommended answer with its tradeoff.
3. Do not ask a dependent question while its prerequisite is unresolved. Wait for answers before the next round.
4. Facts are your job: discover them from the codebase with bounded exploration. Decisions are the user's. Blocked tools are a blocked prerequisite, not permission to guess.
5. Record decisions, recompute the frontier, repeat. Honor a one-question-at-a-time pace or timebox.
6. Stop when branches are settled, the user stops, or remaining assumptions are explicitly accepted.

## Domain discipline (during every round)

- **Challenge against the glossary.** If the user's word conflicts with an existing `CONTEXT.md` definition, say so and ask which meaning applies.
- **Sharpen fuzzy terms.** For vague or overloaded words, propose one canonical term and name the alternatives to avoid.
- **Probe with scenarios.** Invent concrete edge cases that force precise boundaries between concepts.
- **Cross-check code.** When the user states how something works and the code disagrees, surface the contradiction with file references.

## Paper trail

| What resolved | Where it lands | When |
| --- | --- | --- |
| A project-specific term, settled by the user's answer | `CONTEXT.md` (see [context-format.md](references/context-format.md)) | Immediately, inline |
| A decision that is hard to reverse **and** surprising without context **and** a real trade-off | `docs/adr/NNNN-slug.md` (see [adr-format.md](references/adr-format.md)) | Only after the user accepts the offer |
| Everything else | The conversation | Never written by this skill |

- Create files lazily; nothing is scaffolded up front. If `CONTEXT-MAP.md` marks multiple contexts, write to the matching context's `CONTEXT.md`; ask when unclear. Honor an existing ADR directory or numbering convention over the default.
- `CONTEXT.md` is a glossary only: no implementation details, spec prose, or scratch notes. Terms must be specific to this domain, not general programming concepts.
- Offer ADRs sparingly. Most sessions produce none; that is correct.
- Announce each write in one line (`glossary: added "Invoice"`, `adr: 0003-...`). Every write goes through normal file permissions; a denied write is reported, not retried silently.

## Closing

Summarize: settled decisions, glossary entries written, ADRs written or declined, unresolved risks, and the many decisions that live only in this conversation. Recommend the next step (spec, plan, or implement) and ask for explicit handoff approval. Do not implement because the interview ended.

Example: tenancy model and retention policy may share a round; tenant-index design waits for tenancy. When "account" resolves to Customer, write the `Customer` entry with `_Avoid_: account` right then. "Postgres for the write model" earns an ADR offer; "name the helper `parseOrder`" does not.
