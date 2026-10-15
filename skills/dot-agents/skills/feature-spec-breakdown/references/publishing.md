# Publishing Accepted Tickets

Read before creating todos or tracker issues. Only `accepted` tickets publish. Create blockers first so dependents reference real IDs.

## Before any create

1. Re-read `tickets/index.md` and each accepted ticket file.
2. Skip tickets whose `Published` line already has the target ID; list existing items in the target to catch duplicates from earlier runs (match Work-ID, ticket number, title).
3. Inventory every relative link or plain ticket-number reference in a body section. Each target must already have a tracker URL or be included in this publish set; otherwise ask whether to publish the target or stop with the unresolved reference.
4. Show the mapping (ticket → target fields) for the first ticket, the full creation order, and the final link-resolution update pass; get explicit approval.

## Todos

Use the todo tool actually exposed; do not assume tags, body fields, or persistence.

Pi compatibility: when the API is `list`, `add(text)`, `toggle(id)`, `clear`, encode everything in `text`:

```text
spec:<work-id> #NN <title>
Ticket: .agent-work/work/<work-id>/tickets/NN-<slug>.md
Blocked by: <returned todo ID> #NN | None
```

Keep details in the ticket file; the todo points to it. Never clear, toggle, or replace existing todos. Record each returned ID in the ticket's `Published` line and `index.md`.

## Tracker

Ask for what is not already given:

- App and destination (team/project/repo/board), parent issue or epic.
- Fields: destination state, labels, priority, assignee (default: none), estimate. These come from explicit publishing choices, never from the ticket's local `Status` header.
- Images: upload as attachments if supported, else keep links and list what could not be uploaded.

Use the tool the user names (MCP, CLI such as `gh`, or API) and inspect its actual parameters first. If no permitted tool exists, stop and hand over the ticket text for manual creation.

Issue body: only the ticket's Context, Description, Steps to reproduce, and Acceptance criteria. Never publish or map the local `Status`, `Blocked by`, `Source`, or `Published` headers to Linear/Jira. Do not add spec, plan, or ADR citations. Never publish local `.agent-work/` paths.

Resolve every body link or plain reference to another ticket as a Markdown hyperlink to that ticket's destination issue URL. If a target URL exists, replace the reference before creation. For forward references within the same publish batch, create the issues first, record all URLs, then update the affected bodies in the approved final pass. Completion requires no local ticket links, plain unresolved ticket references, or inaccessible placeholders in published bodies.

## Partial failure

Record each created ID immediately. On failure, report `created: <IDs>; pending: <ticket numbers>`. Before retrying, list/search the target to catch items created despite a lost response; retry only missing ones. Do not delete, close, or edit created items unless asked, except for the explicitly approved final link-resolution pass.
