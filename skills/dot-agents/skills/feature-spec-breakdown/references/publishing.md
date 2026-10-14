# Publishing Accepted Tickets

Read before creating todos or tracker issues. Only `accepted` tickets publish. Create blockers first so dependents reference real IDs.

## Before any create

1. Re-read `tickets/index.md` and each accepted ticket file.
2. Skip tickets whose `Published` line already has the target ID; list existing items in the target to catch duplicates from earlier runs (match Work-ID, ticket number, title).
3. Show the mapping (ticket → target fields) for the first ticket and the full creation order; get explicit approval.

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
- Fields: state, labels, priority, assignee (default: none), estimate.
- Blockers: native relation if the tool supports it, else a "Blocked by" line.
- Images: upload as attachments if supported, else keep links and list what could not be uploaded.

Use the tool the user names (MCP, CLI such as `gh`, or API) and inspect its actual parameters first. If no permitted tool exists, stop and hand over the ticket text for manual creation.

Issue body: the ticket's Context, Description, Steps to reproduce, and Acceptance criteria. Replace `.agent-work/` paths and relative ticket links with real issue IDs or inline text, since others cannot open local files. Never include secrets or customer data.

## Partial failure

Record each created ID immediately. On failure, report `created: <IDs>; pending: <ticket numbers>`. Before retrying, list/search the target to catch items created despite a lost response; retry only missing ones. Do not delete, close, or edit created items unless asked.
