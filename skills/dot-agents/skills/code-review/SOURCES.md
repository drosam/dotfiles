# Sources

## External skill scan

Used `find-skills` workflow: searched skills.sh and public results for code-review / PR-review skills, then incorporated only high-signal patterns. No external skill was installed.

Candidate signals:

- `addyosmani/agent-skills/code-review-and-quality` — 6.5K installs, 50K GitHub stars. Useful pattern: approve improvements, review across correctness/readability/architecture/security/performance, avoid perfectionism.
- `juliusbrussee/caveman/caveman-review` — 146K installs, 70.9K GitHub stars. Useful pattern: terse paste-ready review comments with location/problem/fix and no filler.
- `obra/superpowers/requesting-code-review` — 122.8K installs, 222K GitHub stars. Useful pattern: review early/often and use focused reviewer context.
- `jwynia/agent-skills/code-review` — 433 installs, 94 GitHub stars. Useful pattern: explicit use / do-not-use boundaries and systematic diagnostic framing.

## Engineering references

- Google Engineering Practices: review for design, functionality, complexity, tests, naming, comments, style, consistency, docs, every line, and code health.
- Google Engineering Practices: broad review first, main path next, then details.
- Google Engineering Practices: kind, useful comments that explain why and give fix direction.
- OWASP Code Review Guide: manual security review for vulnerability classes automated checks miss.

## Local decision record

- Kept skill reviewer-only by default; no edits unless user asks.
- Added modes for blocking, deep, security, test, pasteable, and implementer handoff.
- Added a finding bar to reduce false positives.
- Kept default output terse: findings only or exact `No findings.`
