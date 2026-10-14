---
name: grill-with-docs
description: Stress-tests a plan, design, or decision through a dependency-aware repository interview. Persists compaction-safe working notes and records settled domain terms and approved ADRs under .agent-work/. Use when the user says "grill me", "grill me with docs", wants assumptions challenged or a grooming session, or wants to document a repo's domain language.
disable-model-invocation: true
---

# Grill With Docs

Resolve user-owned design decisions through dependency-aware questions and codebase research. Persist the evolving interview state so compaction cannot strand the work. Record settled domain terms during the session and offer ADRs sparingly. Self-contained; do not require other skills to load.

## Work context

Use the target repo's `.agent-work/`: `work/<work-id>/notes.md` for interview recovery, `work/<work-id>/spec.md` for requirements, `work/<work-id>/plan.md` for designs, shared `context/` for glossaries and `decisions/` for ADRs. Read selected spec/plan status, acceptance criteria, non-goals, design and testing decisions. Confirm Work-ID and reciprocal Spec/Plan links. An explicit user path, current-session confirmation, or validated reciprocal link establishes identity. Otherwise shortlist titles/statuses/summaries and ask via question tool, even for one candidate; offer Other / None—standalone discussion. Never choose by names, slugs, branch, or recency. If asking is unavailable, report the blocker. Clarify conflicts and missing links; do not pair or migrate documents automatically. A standalone discussion needs no spec/plan, but it still needs a user-confirmed Work-ID and recovery notes. Pass confirmed paths/constraints to research workers, who return missing-context questions instead of guessing.

## Recovery notes: mandatory preflight

1. Resolve or ask for the Work-ID before the first substantive interview question. This identity question is the only permitted question before recovery notes exist; do not infer the ID.
2. Read `references/notes-format.md`. Inspect `.agent-work/work/<work-id>/notes.md`; create it if absent or merge into it without erasing unrelated history.
3. Before the interview starts, capture all relevant information already present in the active session: objective, scope, constraints, sources, verified findings, user-reported facts, settled decisions, contradictions, open questions, and the next frontier. Summarize; never copy secrets, customer data, full transcripts, or large raw outputs.
4. If the notes write is denied or fails, stop before the interview and report the recovery blocker. Do not rely on conversation-only state.
5. Update notes after every answered question round and every material research batch, before asking the next round. Perform a final sync before closing or handing off to spec, plan, or implementation work.
6. After compaction, resume, branch switch, or suspected context loss, re-read the entire notes file before any other action. If it is missing, stale, or identity-conflicted, stop and reconcile it with the user instead of continuing from memory.

## Interview

1. Read the recovery notes, selected spec/plan, relevant code, `.agent-work/context/CONTEXT.md`, any `.agent-work/context/CONTEXT-MAP.md`, and `.agent-work/decisions/`. Also consult existing project glossaries/ADRs as evidence; do not modify or migrate those outside `.agent-work/` without an explicit request. Identify settled decisions, unresolved branches, factual unknowns, and terms already defined.
2. Ask one round of independent, currently answerable questions. Use the question tool when available; give concrete options and a recommended answer with its tradeoff.
3. Do not ask a dependent question while its prerequisite is unresolved. Wait for answers before the next round.
4. Facts are your job: discover them from the codebase with bounded exploration. Use a worker when useful and available; otherwise inspect directly. Decisions are the user's. Blocked tools are a blocked prerequisite, not permission to guess or retry endlessly.
5. Sync answers and evidence to recovery notes, recompute the frontier, then ask the next round. Honor a one-question-at-a-time pace or timebox.
6. Stop when branches are settled, the user stops, or remaining assumptions are explicitly accepted.

## Domain discipline (during every round)

- **Challenge against the glossary.** If the user's word conflicts with an existing `CONTEXT.md` definition, say so and ask which meaning applies.
- **Sharpen fuzzy terms.** For vague or overloaded words, propose one canonical term and name the alternatives to avoid.
- **Probe with scenarios.** Invent concrete edge cases that force precise boundaries between concepts.
- **Cross-check code.** When the user states how something works and the code disagrees, surface the contradiction with file references.

## Paper trail

| What resolved | Where it lands | When |
| --- | --- | --- |
| Current evidence, decisions, conflicts, open questions, and next frontier | `.agent-work/work/<work-id>/notes.md` (see [notes-format.md](references/notes-format.md)) | Before interviewing, after every round/research batch, and before handoff |
| A project-specific term, settled by the user's answer | `.agent-work/context/CONTEXT.md` (see [context-format.md](references/context-format.md)) | Immediately, inline |
| A decision that is hard to reverse **and** surprising without context **and** a real trade-off | `.agent-work/decisions/NNNN-slug.md` (see [adr-format.md](references/adr-format.md)) | Only after the user accepts the offer |

- Recovery notes are a concise working ledger, not a draft spec, plan, transcript, or substitute glossary. Specs and plans remain `Not created` until an explicitly approved handoff creates them.
- Except for mandatory recovery notes, create files lazily; inspect destinations before editing and preserve unrelated content. For multiple contexts, use `.agent-work/context/CONTEXT-MAP.md` and `.agent-work/context/<context>/CONTEXT.md`; ask which context when unclear. Existing maps outside this folder are evidence, not permission to write elsewhere. New artifacts stay inside `.agent-work/` unless the user explicitly requests otherwise.
- In each ADR, include the confirmed Work-ID and relative Spec/Plan links, or `Not created` for absent artifacts. Do not invent a relationship. If an accepted decision changes a selected spec/plan, flag the affected sections and request approval to reconcile them; report the mismatch until resolved. No silent implementation handoff with conflicting requirements.
- `CONTEXT.md` is a glossary only: no implementation details, spec prose, or scratch notes. Terms must be specific to this domain, not general programming concepts; working detail belongs in recovery notes.
- Offer ADRs sparingly. Most sessions produce none; that is correct.
- Announce each write in one line (`notes: updated decisions and next round`, `glossary: added "Invoice"`, `adr: 0003-...`). Every write goes through normal file permissions; a denied write is reported, not retried silently.

## Closing

Sync recovery notes, then summarize: notes path, settled decisions, glossary entries written, ADRs written or declined, unresolved risks, and next frontier. Recommend the next step (spec, plan, or implement), pass the notes path as required handoff context, and ask for explicit approval. Do not create those artifacts or implement merely because the interview ended.

Example: tenancy model and retention policy may share a round; tenant-index design waits for tenancy. When "account" resolves to Customer, write the `Customer` entry with `_Avoid_: account` right then. "Postgres for the write model" earns an ADR offer; "name the helper `parseOrder`" does not.
