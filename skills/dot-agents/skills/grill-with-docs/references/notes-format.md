# Recovery Notes Format

Use `.agent-work/work/<work-id>/notes.md` as the compact, current recovery ledger for one grill. Keep it useful after the conversation has been compacted away.

```md
# <Topic> — grill notes

Work-ID: <confirmed-work-id>
Status: Grilling (working notes, not a spec or plan)
Spec: <actual relative link, or Not created>
Plan: <actual relative link, or Not created>

> Recovery: after compaction, resume, branch switch, or suspected context loss, re-read this file fully before continuing.
> Update after every answered round and material research batch, before asking the next round.

## Objective and boundaries

## Sources and evidence
- [verified | user-reported | assumption] <concise fact and source pointer>

## Decisions log
- <decision, rationale, and important rejected alternative>

## Conflicts and risks

## Open questions

## Next round

## Handoff state
- Recommended next action: <spec | plan | implementation | more research>
- Blocking gaps: <items or None>
```

## Update rules

- Populate the initial file from relevant information already in the active session before substantive interviewing. Include prior research and links; do not redo work merely to fill the file.
- Record provenance and confidence. Never turn an assumption into a fact or silently resolve conflicting sources.
- Keep the current truth easy to recover. When an answer supersedes an earlier item, mark or replace the stale item and retain only the rejected alternative needed to explain the decision.
- Update `Decisions log`, `Open questions`, and `Next round` after each answer round. Update evidence after each material research batch.
- Link only confirmed existing spec/plan paths. Use `Not created` otherwise; notes do not establish a spec/plan relationship.
- Summarize sensitive evidence without copying secrets, customer data, full transcripts, or large command/tool output.
- Before handoff, reconcile contradictions across sections and make `Handoff state` match the final recommendation. Keep the notes file after handoff unless the user explicitly requests deletion.
