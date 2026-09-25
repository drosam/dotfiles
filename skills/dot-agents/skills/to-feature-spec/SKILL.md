---
name: to-feature-spec
description: Turns the current conversation and codebase understanding into a feature spec. Use when asked to capture agreed requirements, write a feature spec, or turn the current context into a PRD; not to start a new requirements interview or implementation.
disable-model-invocation: true
---

# To Feature Spec

Synthesize what is already known. Do not restart the requirements interview or invent scope.

## Resolve work context

Use the target repository's `.agent-work/`: `work/<work-id>/spec.md` for requirements, `work/<work-id>/plan.md` for technical designs, shared `context/` for domain glossaries and `decisions/` for ADRs. Read relevant glossary/decisions and the selected spec/plan before drafting.

An explicit user path, confirmation in this session, or validated reciprocal link from an already-selected document identifies existing work. Otherwise inspect candidate titles, statuses, and summaries; use the question tool to offer likely candidates plus Other / None—new standalone work. Ask even if only one candidate exists. Never select by name, matching slug, branch, or recency. This identity checkpoint is not a requirements interview. A clear request for a new standalone spec needs no existing-document selection. If asking is unavailable, report the blocker rather than guess.

## Process

1. Inspect relevant code, domain vocabulary, and ADRs. Separate agreed decisions from assumptions. If selected spec and plan disagree, ask which is authoritative; do not silently resolve the conflict.
2. Sketch modules to build or modify. Prefer deep modules and existing public test seams. Confirm only material unsettled module/testing choices; record missing requirements as open decisions.
3. Save to `.agent-work/work/<work-id>/spec.md`. Inspect the destination before editing; ask before replacing existing work. Do not automatically migrate legacy `.prd/` or `docs/design/` documents. For draft-only/read-only requests, return a draft without any writes.
4. Include the work header below. Use the same stable kebab-case Work-ID as the work directory name for a confirmed spec/plan pair, with relative Markdown links (`./spec.md`, `./plan.md`) in both documents. Reuse the confirmed work directory for its counterpart; directory proximity alone is not selection. When creating the counterpart, update both headers through normal permissions and verify that targets exist and links agree. Do not infer a relationship merely from matching IDs or filenames. Use `Not created` when a counterpart does not exist, never a dangling link. Multiple documents per work item require explicit user confirmation; use `specs/` and/or `plans/` inside that work directory only when needed, listing actual relative links. Never reorganize existing files automatically. If a counterpart edit is blocked, report incomplete pairing; do not claim linkage complete.
5. Report saved path (or draft status), linked plan, testing boundary, and open decisions. Do not publish issues or implement. Read [examples](references/examples.md) for synthesis and cross-session cases.

## Template

```markdown
# <Feature> — Feature Spec

**Work-ID:** <stable-kebab-slug>
**Status:** Draft
**Spec:** [<Feature>](./spec.md)
**Plan:** Not created

## Problem Statement

Problem from the user's perspective.

## Solution

Solution from the user's perspective.

## User Stories

1. As an <actor>, I want <feature>, so that <benefit>.

Cover agreed behavior, meaningful edge cases, and observable acceptance criteria without padding.

## Implementation Decisions

Agreed modules, interfaces, architecture, schema changes, API contracts, and interactions.
Do not include source-code paths or code snippets; artifact links in the header are required.

## Testing Decisions

External behavior and public test boundaries, modules tested, and relevant prior art.

## Out of Scope

Explicit exclusions.

## Further Notes

Open decisions, assumptions, and relevant links to domain glossary or ADRs.
```

Once a plan exists, replace `Not created` with `[<Feature> plan](./plan.md)` and add the reciprocal spec link in that plan. Selecting or approving a document does not authorize implementation.
