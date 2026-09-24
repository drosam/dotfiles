# Debug Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: inline investigation.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Local history `0bb595144d775cb552208ee559760a2364629e9c` | canonical local | high | Read-only until explicit implementation approval |
| https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/diagnosing-bugs/SKILL.md | secondary pattern source | high content; unknown ancestry | Do not import forced instrumentation, app startup, stress loops, or auto-fix phases |

Adopt exact-symptom feedback, ranked falsifiable hypotheses, minimal discriminating checks. Preserve safety over upstream's mandatory executable repro. Clarify runner boot, query cost, test side effects, redaction.

Coverage/profile: preconditions, ordered investigation, no-safe-repro recovery, output/evidence and approval handoff covered. Desk check: local failure → bounded observations; unsafe runner → ask, not run; no repro → hypothesis labeled. Negative trigger: production command execution.

Stop: relevant diagnostic pattern and local restrictions reconcile the change. Gap: original source unknown; retrieve owner-provided provenance if needed. Strict validator blocked by missing PyYAML; no application runtime executed.
