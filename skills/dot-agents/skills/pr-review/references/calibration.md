# Feedback calibration

Synthetic examples derived from the selected session's workflow failures. These are writing and decision examples, not verified claims about a current PR.

## Happy path: concise actionable feedback

Internal finding: an older asynchronous lookup can save a flag after the user has selected another location. Static tracing confirms the picker remains enabled and the save lacks the current-request guard.

Draft:

> Switching A -> B -> C quickly can save B's route flag after C's response. Could this skip the save when the request is no longer current?

Keep the full trace/check gap in `review.md` or subsequent revalidation events. Ask Keep/Reword/Omit/Investigate, log the user's decision, and preserve its ID. A separate multi-tab overwrite concern needs its own verified trace; do not append it merely because both involve stale state.

## Robust variant: API-only security issue

A crafted request crosses a verified tenant boundary although the UI never sends it. Do not omit it as "not possible in the app" or assume low frequency. Record the identity, reachable endpoint, missing guard and concrete impact; recommend blocking feedback. With missing guard evidence, investigate rather than accuse. Do not send live exploit requests without permission.

Draft after a complete static trace:

> This lookup accepts an invoice ID from another tenant and returns its details. Scope it to the current tenant before serializing the result.

## Anti-pattern and correction: inflated security claim

Anti-pattern: "The token is not tied to an order, so this is a security vulnerability. Bind it to every field and add an expiry."

Correction: trace supported callers, permissions, token semantics and actual added capability first. If the actor already has equivalent authority and no boundary is crossed, withdraw the security claim explicitly. Propose omitting it or retain only a separately verified behavioral problem. Never silently delete the original finding or infer the user's omission decision.

## Suggested fixes

A changed line uses `<` where a verified inclusive contract requires `<=`. A one-line suggestion is appropriate only if it completely repairs the issue and matches the exact anchor. If callers or migrations also need edits, explain the direction instead; do not publish a plausible-looking partial patch. No local edits or commits.

## Shortening without losing the point

Anti-pattern: several paragraphs of background, a repeated symptom list, all internal file references, a redesign menu and a generic request for tests.

Correction:

> A failed rates request leaves the previous route's flag on the order, so the warning can describe the wrong route. Could we clear it when the route changes?

If only documentation overclaims a deliberately retained value, ask for wording that describes the last saved calculation instead. Do not demand a product change when the verified contract only requires correcting documentation.

## Failure recovery and timeline

User says "omit F4, check whether F1 is reachable": record Omit for F4; F1 stays Investigate, not automatically kept. Append revised evidence and text, retaining F1. Do not renumber another comment into F4.

User chooses APPROVE: record chosen event, preview exact content, wait for explicit publication authorization. If head changes afterward, append invalidation and revalidation; obtain approval of the new preview. If submission times out, read remote reviews/comments before any retry. If logging fails, stop and report the gap. Never convert silence into approval or uncertainty into successful publication.
