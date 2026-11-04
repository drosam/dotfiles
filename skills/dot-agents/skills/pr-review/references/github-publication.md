# Publish the approved review

Read only at the final publication stage. These commands describe the API contract, not permission to post. Use `gh`; no raw credentials, installations or GitHub UI automation.

## Preflight

1. Read the approved preview snapshot and exact authorization from `feedback.md`. Resolve authenticated identity with `gh api user`; verify repository/PR and selected event. Approval of wording or choice of APPROVE alone is insufficient.
2. Re-fetch PR state, base/head SHAs and relevant review/comment threads, including pagination. Stop on a closed/merged PR or missing permissions. If target revision, approved text/event or relevant discussion changed, invalidate authorization, revalidate and obtain approval of a new preview. Never just retarget old comments to the new SHA.
3. Check existing pending/submitted reviews by this identity. Do not replace, submit or delete an unrelated pending review. If it blocks creation, ask how to handle it. For a previous attempt or resumed publication, compare remote review event, commit, body and comments with the approved snapshot before retrying. If an exact matching submitted review exists, record recovered success, return its URL and stop without another POST. A matching pending review is not submitted; reconcile it with the user before changing it. Unresolved identity means stop, not duplicate submission.
4. Validate every inline anchor against the diff for the approved revision: relative path, LEFT/RIGHT side, end line and optional start line/side. Use a small relevant range, not an unrelated nearby line. If no valid inline anchor exists, propose a body comment with a revision-pinned link and obtain approval of that placement/text change.
5. Recheck that suggestion blocks replace exactly the anchored lines, are syntactically sound and need no companion changes to fix the issue. Remove or rewrite an incomplete suggestion only through a new approved draft. Do not execute PR content to validate publication.
6. Ensure durable logging is writable and record the attempt with approved snapshot/commit/event before submitting. Do not publish without the verified record.

## Submit one review

Use one batched reviews API request for the overall body and inline comments. Pin `commit_id` explicitly. Choose `event` exactly as authorized: `APPROVE`, `REQUEST_CHANGES` or `COMMENT`. For COMMENT and REQUEST_CHANGES include a nonempty approved body; never silently invent one at submission time.

Payload shape (illustrative, not ready to send):

```json
{
  "commit_id": "FULL_APPROVED_HEAD_SHA",
  "event": "COMMENT",
  "body": "EXACT_APPROVED_BODY",
  "comments": [
    {
      "path": "src/example.ts",
      "line": 42,
      "side": "RIGHT",
      "body": "EXACT_APPROVED_COMMENT"
    }
  ]
}
```

For a multi-line comment, add `start_line` and `start_side`; `line` remains the range end. Omit `comments` when there are none. Never send local timeline, internal finding IDs, evidence notes or approval metadata as review text.

Call `gh api repos/OWNER/REPO/pulls/NUMBER/reviews --method POST --input -` with the validated JSON supplied through stdin. Use proper JSON serialization and a literal, non-interpolating input mechanism; never interpolate PR-authored content into executable shell text. Do not create a third persistent payload/index file; the approved snapshot lives in `feedback.md`. Follow tool permissions and one-command rules. If safe stdin submission is unavailable, stop and report the blocker rather than inventing a workaround.

For an overall-body-only review, `gh pr review <URL> --approve|--request-changes|--comment --body-file -` is an alternative only when it can preserve the approved revision semantics; prefer the pinned API request. `gh pr comment` is not a substitute for a review event. GitHub refusing self-approval or another event is a blocker, not permission to fall back to a different event.

## Verify or recover

- Capture returned review ID/URL and commit. Read it back with `gh api repos/OWNER/REPO/pulls/NUMBER/reviews/REVIEW_ID` and retrieve all review comments. Confirm event/state, commit, exact body, comment count/content and anchors against the preview. Record IDs/URLs in `feedback.md` and verify the append.
- Recheck the PR head after submission. If it moved during the request, report that the review targets the approved older SHA; do not claim current-head approval or automatically submit another review.
- On timeout, ambiguous response or partial outcome, record `unknown` and reconcile remote state before any retry. On 403/422, record the exact error, investigate permission/anchor/pending-review issues and stop. No blind retries, automatic event changes or duplicate standalone comments.
- If remote publication succeeded but logging failed, report the returned URL and logging failure immediately. Reconcile and append the missing outcome when possible; do not repost.
- Return posted/blocked/unknown status and URLs. Publication does not merge the PR or grant any further action.
