---
name: grill-with-docs
description: Stress-tests a plan, design, or decision through a dependency-aware interview inside a repository. Records settled domain terms and approved ADRs under .agent-work/. Use when the user says "grill me", "grill me with docs", wants assumptions challenged or a grooming session, or wants to document a repo's domain language.
disable-model-invocation: true
---

# Grill With Docs

Resolve user-owned design decisions through dependency-aware questions and codebase research. Record settled domain terms during the session and offer ADRs sparingly; keep other decisions in the conversation. Self-contained; do not require other skills to load.

## Work context

Use the target repo's `.agent-work/`: `work/<work-id>/spec.md` for requirements, `work/<work-id>/plan.md` for designs, shared `context/` for glossaries and `decisions/` for ADRs. Read selected spec/plan status, acceptance criteria, non-goals, design and testing decisions. Confirm Work-ID and reciprocal Spec/Plan links. An explicit user path, current-session confirmation, or validated reciprocal link establishes identity. Otherwise shortlist titles/statuses/summaries and ask via question tool, even for one candidate; offer Other / None—standalone discussion. Never choose by names, slugs, branch, or recency. If asking is unavailable, report the blocker. Clarify conflicts and missing links; do not pair or migrate documents automatically. A clear standalone discussion needs no spec/plan creation. Pass confirmed paths/constraints to research workers, who return missing-context questions instead of guessing.

## Interview

1. Read the selected spec/plan, relevant code, `.agent-work/context/CONTEXT.md`, any `.agent-work/context/CONTEXT-MAP.md`, and `.agent-work/decisions/`. Also consult existing project glossaries/ADRs as evidence; do not modify or migrate those outside `.agent-work/` without an explicit request. Identify settled decisions, unresolved branches, factual unknowns, and terms already defined.
2. Ask one round of independent, currently answerable questions. Use the question tool when available; give concrete options and a recommended answer with its tradeoff.
3. Do not ask a dependent question while its prerequisite is unresolved. Wait for answers before the next round.
4. Facts are your job: discover them from the codebase with bounded exploration. Use a worker when useful and available; otherwise inspect directly. Decisions are the user's. Blocked tools are a blocked prerequisite, not permission to guess or retry endlessly.
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
| A project-specific term, settled by the user's answer | `.agent-work/context/CONTEXT.md` (see [context-format.md](references/context-format.md)) | Immediately, inline |
| A decision that is hard to reverse **and** surprising without context **and** a real trade-off | `.agent-work/decisions/NNNN-slug.md` (see [adr-format.md](references/adr-format.md)) | Only after the user accepts the offer |
| Everything else | The conversation | Never written by this skill |

- Create files lazily; inspect destinations before editing and preserve unrelated content. For multiple contexts, use `.agent-work/context/CONTEXT-MAP.md` and `.agent-work/context/<context>/CONTEXT.md`; ask which context when unclear. Existing maps outside this folder are evidence, not permission to write elsewhere. New artifacts stay inside `.agent-work/` unless the user explicitly requests otherwise.
- In each ADR, include the confirmed Work-ID and relative Spec/Plan links, or `Not created` for absent artifacts. Do not invent a relationship. If an accepted decision changes a selected spec/plan, flag the affected sections and request approval to reconcile them; report the mismatch until resolved. No silent implementation handoff with conflicting requirements.
- `CONTEXT.md` is a glossary only: no implementation details, spec prose, or scratch notes. Terms must be specific to this domain, not general programming concepts.
- Offer ADRs sparingly. Most sessions produce none; that is correct.
- Announce each write in one line (`glossary: added "Invoice"`, `adr: 0003-...`). Every write goes through normal file permissions; a denied write is reported, not retried silently.

## Closing

Summarize: settled decisions, glossary entries written, ADRs written or declined, unresolved risks, and the many decisions that live only in this conversation. Recommend the next step (spec, plan, or implement) and ask for explicit handoff approval. Do not implement because the interview ended.

Example: tenancy model and retention policy may share a round; tenant-index design waits for tenancy. When "account" resolves to Customer, write the `Customer` entry with `_Avoid_: account` right then. "Postgres for the write model" earns an ADR offer; "name the helper `parseOrder`" does not.
