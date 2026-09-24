# Skill Writer Maintenance Contract

- Intent: create, synthesize, update, and evaluate portable skills with relevant depth and minimal runtime overhead.
- Shape: reference-backed router; optional validation script. Do not replicate an entire upstream documentation tree.
- Inputs: requested task, observed repo layout, existing skill and provenance, relevant sources/examples.
- Outputs: runtime skill and necessary support files; source decisions/coverage; validation results and explicit gaps.
- Boundaries: no dependency installs, upstream script execution, registration changes, or bulk overwrites without authorization. Preserve local policies over upstream defaults.
- Evidence: pin retrieved upstream revisions; label inferred lineage and desk checks accurately. Never store secrets or customer data in examples.
- Acceptance: valid frontmatter, reachable references, explicit class/shape, positive/negative trigger checks, concrete generator examples, and no unreported high-impact gap.
- Limits: static validation cannot prove runtime compliance; automatic class inference is heuristic. Quantitative benchmarks remain opt-in.
- Maintenance: update this contract when scope, outputs, safety, or validation changes; keep retrieval history in `SOURCES.md`.
