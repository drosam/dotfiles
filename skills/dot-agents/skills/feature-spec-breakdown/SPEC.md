# Feature Spec Breakdown Contract

- Intent: split a feature spec (and plan) into small, independent vertical-slice tickets saved as files, agreed as a list, reviewed one by one, then optionally turned into todos or tracker issues.
- Inputs: selected spec, linked plan (or explicit spec-only choice), relevant glossary/ADRs, optional user-provided links/images, optional bounded code exploration.
- Outputs: `.agent-work/work/<work-id>/tickets/index.md` (outline, statuses, coverage, publication IDs), `tickets/NN-<slug>.md` (Context, Description, optional Steps to reproduce, Acceptance criteria), optional `tickets/assets/`; after handoff, todos and/or tracker issues with IDs recorded back in files.
- Identity: explicit path, session confirmation, or validated reciprocal link; otherwise ask even with one candidate. Never infer from names/branch/recency.
- Plan gate: missing plan → ask (create-plan / spec-only / stop); draft plan or conflicting spec/plan → ask. Never write a plan.
- Gates: list + order agreed before ticket files; full ticket accepted individually; publication only for accepted tickets after explicit target and approval.
- Boundaries: no parent spec/plan edits, no implementation, no staging `.agent-work/`, no secrets/customer data, no tracker-specific default.
- Recovery: resume from `index.md` without overwriting reviewed tickets; partial publish records created IDs and reconciles before retry.
- Acceptance: acyclic real blockers; coverage maps every spec story/criterion and plan section or explains deferral; tickets terse but complete; IDs never renumbered.
- Limits: todo persistence depends on runtime; tracker field mapping depends on the user-named tool; runtime behavior verified by desk checks only.
