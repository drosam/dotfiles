# Ticket File Templates

Paths are relative to the target repo's `.agent-work/work/<work-id>/`. Write straight to the point: every needed fact, no filler, no restating the spec.

## `tickets/index.md`

```markdown
# <Feature> — Tickets

**Work-ID:** <work-id>
**Spec:** [spec](../spec.md)
**Plan:** [plan](../plan.md) | Not created
**Breakdown:** proposed | agreed | reviewed

| # | Title | Summary | Blocked by | Status | Published |
| --- | --- | --- | --- | --- | --- |
| 01 | [Filter by one collection](./01-filter-one-collection.md) | Pick one collection; list shows only its items | — | accepted | — |
| 02 | [Combine collections](./02-combine-collections.md) | Several collections narrow the list together | 01 | draft | — |

## Coverage

| Source item | Ticket(s) | Note |
| --- | --- | --- |
| Spec: "Filter by collection" | 01 | |
| Plan: Query scope | 01, 02 | |
| Spec: "Saved filters" | — | deferred: not in plan |

## Open questions

- <question> — affects <ticket numbers>
```

## `tickets/NN-<slug>.md`

```markdown
# NN: <Title>

Status: draft | accepted | rejected | deferred | merged into NN
Blocked by: None | NN
Source: [spec](../spec.md) <story/heading>; [plan](../plan.md) <section>
Published: — | todo <ID> | <tracker key/URL>

## Context

Why this ticket exists and what it builds on. Links: [Figma <frame>](<url with node-id>), ![<what it shows>](./assets/NN-<name>.png), docs/threads.

## Description

What to build as end-to-end behavior, in glossary terms. Include scope limits ("not X; see NN") and, when useful, code starting points as `path` — `symbol` (read at <commit SHA>).

## Steps to reproduce

Only for bugs or regressions:
1. <step>
2. <step>
Expected: <behavior>. Actual: <behavior>.

## Acceptance criteria

- [ ] <observable, testable outcome>
- [ ] <edge or error outcome>
```

Omit `Steps to reproduce` when not a bug. Keep header lines short. Record review decisions in the index or chat, not as extra ticket sections.
