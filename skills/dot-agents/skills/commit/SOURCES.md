# Commit Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: inline.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Local history `f1ff2f87ff72e170bf897326c1a6f60b64cc308e`, `3f2853b9b3cc3d16a60a620f98cd5b1591c4736d` | canonical local | high | Latest policy deliberately keeps title-only messages |
| https://github.com/getsentry/skills/blob/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills/commit/SKILL.md | candidate pattern source | high content; unknown ancestry | No Sentry commit format, automatic branches, bodies, or footers |

Decision: strengthen scope/index checks, distinguish drafting from committing, add privacy and hook-failure recovery. Preserve explicit staging and title-only format.

Coverage/profile: workflow-process preconditions, ordered flow, safety, check results, failure recovery and handoff covered. Desk checks: draft-message request never commits; unrelated staged hunk blocks commit; failed hook prompts inspection, not bypass. Negative trigger: plain code explanation.

Stop: local policy plus current candidate covers relevant changes. Gap: exact original source unknown; obtain owner-provided URL if needed. Strict validator blocked by missing PyYAML; no runtime commit performed.
