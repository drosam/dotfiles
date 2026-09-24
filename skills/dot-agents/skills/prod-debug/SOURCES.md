# Production Debug Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: read-only analysis + user-run handoff.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Local history `0bb595144d775cb552208ee559760a2364629e9c` | canonical local | high | Never execute production observations or mutations |
| https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/diagnosing-bugs/SKILL.md | secondary diagnostic pattern | high content; unknown ancestry | Use hypothesis/evidence concept only; production repro/instrumentation remains prohibited |

Decision: remove contradictory execution exception, make environment/result bounds and redaction explicit, provide clipboard-unavailable fallback. Preserve user-run commands and no-production-MCP execution.

Coverage/profile: workflow context, observation flow, permission safety, clipboard failure, result handoff covered. Desk cases: pasted incident log → local analysis; prod query → literal handoff; unavailable clipboard → fenced text, no false copied claim. Code approval never becomes production approval.

Stop: local safety contract and bounded diagnostic pattern cover relevant deltas. Gap: original upstream unrecorded; request original URL if needed. Strict validator blocked by missing PyYAML; no production actions tested.
