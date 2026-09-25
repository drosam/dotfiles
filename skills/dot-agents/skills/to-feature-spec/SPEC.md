# Feature Spec Synthesis Contract

- Intent: capture agreed behavior from conversation/codebase understanding, not interview anew or implement.
- Input: current decisions, selected existing spec/plan when relevant, local code and domain/ADR evidence.
- Output: `.agent-work/work/<work-id>/spec.md`, or chat draft for read-only requests; Work-ID, Status, Spec and Plan header fields.
- Identity: explicit user path/session confirmation or validated reciprocal link. Otherwise ask even with one candidate; never infer from names, branch, slug or recency. Clear standalone creation is valid.
- Pairing: confirmed relationship, stable shared Work-ID matching the work directory, real relative links (`./spec.md`, `./plan.md`) in both documents. Multiple docs use user-approved in-work subdirectories and actual links; no automatic reorganization. Absent counterpart is `Not created`; blocked backlink is incomplete pairing, not success. No mutation in draft mode.
- Safety: inspect existing destinations, preserve unrelated work, no automatic migration, publishing, requirement invention or implementation. Clarify conflicts.
- Acceptance: scoped nonduplicative user stories and observable acceptance, agreed design/testing decisions, non-goals/open decisions, verified paths reported. Examples cover happy, robust, and anti-pattern cases.
- Limits: selected documents may still be drafts; identity does not establish approval. Static checks do not prove model adherence.
