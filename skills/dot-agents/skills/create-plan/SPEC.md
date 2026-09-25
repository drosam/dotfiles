# Create Plan Contract

- Intent: research and agree technical design before separately authorized implementation.
- Inputs: explicit problem, code evidence, selected spec/plan and relevant domain/ADR context.
- Output: `.agent-work/work/<work-id>/plan.md` after findings/approach approval; guided walkthrough and locked design. No automatic coding.
- Identity: explicit user path/session confirmation or validated reciprocal link; otherwise ask even with one candidate. Never infer from names, branch, slug or recency. Standalone planning needs no forced spec creation.
- Pairing: Work-ID, Status, Spec and Plan fields; same confirmed Work-ID matching the work directory, reciprocal relative links (`./spec.md`, `./plan.md`), `Not created` for absent counterpart. Verify both files; report denied counterpart writes as incomplete. Read-only drafts do not mutate files. Multiple docs use user-approved in-work subdirectories and actual links; no automatic reorganization.
- Sequence: research with citations → findings reply → user direction → draft → walkthrough → reconcile → lock → wait for explicit implementation approval.
- Safety: inspect destinations, preserve unrelated files, no silent legacy migration or requirement conflict resolution. Tool failures permit bounded fallback or explicit gap, not bypass.
- Acceptance: no doc before findings approval; uncertain work prompts selection; spec/plan links resolve both ways; accepted refinements reach the doc; design approval alone does not start code.
- Limits: static examples/validation do not prove runtime research quality or agent adherence.
