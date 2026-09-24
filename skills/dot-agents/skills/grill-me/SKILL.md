---
name: grill-me
description: Stress-tests a plan, design, or decision through a dependency-aware interview. Use when the user asks to "grill me", wants a grooming session, or wants assumptions challenged before implementation.
disable-model-invocation: true
---

# Grill Me

Map the design as decisions and their prerequisites. Resolve choices with the user; discover facts from the codebase yourself.

1. Read the plan and relevant code. Identify settled decisions, unresolved branches, and factual unknowns.
2. Ask one round of independent, currently answerable questions. Use the question tool when available; give concrete options and a recommended answer with its tradeoff.
3. Do not ask a dependent question while its prerequisite remains unresolved. Wait for answers before the next round.
4. Research factual unknowns with bounded exploration; use a worker when useful and available, otherwise inspect directly. Permission/tool failure is a blocked prerequisite, not permission to guess or retry endlessly.
5. Record decisions and recompute the next round. Respect a requested one-question-at-a-time pace or timebox.
6. Stop when the relevant branches are settled, the user stops, or remaining assumptions are explicitly accepted. Summarize decisions, unresolved risks, and the proposed next action.

Do not implement merely because the interview is finished. Ask for explicit handoff approval.

Example: tenancy model and retention policy can be asked together if independent; ask tenant-index design only after tenancy is settled. Do not ask which database is used when the repo answers it.
