# Grill With Docs Contract

- Intent: the single design-interview entry point, replacing `grill-me`, with a paper trail: glossary terms in `CONTEXT.md` as they resolve, ADRs for gated decisions.
- Triggers: manual invocation for "grill me", design challenges, grooming, or domain-language documentation; no automatic implementation or mandatory document scaffolding.
- Shape: self-contained inline rounds plus two format references; no dependency on other skills loading (upstream's most reported failure).
- Inputs: explicitly selected spec/plan, codebase, work-area and existing project glossaries/maps/ADRs. Outputs: settled decisions, glossary edits under `.agent-work/context/`, approved ADRs under `.agent-work/decisions/`, closing summary with handoff request.
- Identity: explicit path/session confirmation or verified reciprocal link; otherwise ask even for one candidate. No filename/branch/recency inference. Standalone discussion is valid; absent question capability is a blocker, not permission to guess.
- Storage: existing docs outside `.agent-work/` are evidence only; no silent migration. ADRs carry confirmed work links; changed requirements require explicit reconciliation before handoff.
- Writes: a settled term is written immediately (user's answer is the approval); ADRs only after an explicit yes; every write passes normal file permissions and is announced in one line. Nothing scaffolded up front.
- Boundaries: `CONTEXT.md` is glossary only; ADR gate requires hard-to-reverse + surprising + real trade-off; facts discovered locally, decisions owned by user; blocked tools stay blocked; no implementation without explicit handoff.
- Acceptance: glossary changes during the session, not in one lump; code-answerable questions are not asked; conflicting user vocabulary is challenged against the glossary; few or no ADRs; closing names decisions that live only in the conversation.
- Limitations: static review does not measure interview quality or glossary usefulness; multi-context inference may need user confirmation.
