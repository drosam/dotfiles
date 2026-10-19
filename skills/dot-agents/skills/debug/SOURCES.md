# Debug Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: inline investigation.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Local history `0bb595144d775cb552208ee559760a2364629e9c` | canonical local | high | Read-only until explicit implementation approval |
| Current user direction | canonical user policy | high | Commands stay read-only except one explicitly requested, one-shot local mutating Rails execution; reset immediately afterward |
| https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/diagnosing-bugs/SKILL.md | secondary pattern source | high content; unknown ancestry | Do not import forced instrumentation, app startup, stress loops, or auto-fix phases |

Adopt exact-symptom feedback, ranked falsifiable hypotheses, minimal discriminating checks. Preserve safety over upstream's mandatory executable repro. Clarify runner boot, query cost, test side effects, redaction. Narrow the prior mutation prohibition rather than broadly relaxing it: explicit local Rails mutation requests authorize one execution attempt only; implementation approval and prior requests do not carry forward.

Coverage/profile: preconditions, ordered investigation, no-safe-repro recovery, output/evidence and one-shot approval handoff covered. Desk check: local failure → bounded read-only observations; “fix it” → no mutation; explicit targeted local Rails change → one attempt then read-only verification; unsafe runner → ask, not run; no repro → hypothesis labeled. Negative trigger: production command execution.

Stop: relevant diagnostic pattern and local restrictions reconcile the change. Gap: original source unknown; retrieve owner-provided provenance if needed. Strict validator blocked by missing PyYAML; no application runtime executed.
