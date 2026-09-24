# Thermo Correctness Review Sources

Retrieved: 2026-09-24. Class: security-review; shape: single delegated or direct pass.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Existing local skill; shared thermos SOURCES | canonical local | high | Preserve independent audit, changed-code scope, calibrated severity |
| https://github.com/sndrgrdn/pi/commit/54b2037a480491d2a7e8eaebd854163e875edad5 | recorded secondary upstream | high | Removes old thermo skills/agents; retain local name |
| https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/deep-review/SKILL.md | secondary replacement pattern | high | Orchestration contract inspected, not its full rubric leaves; no four-judge migration |

Adopt pinned scope, explicit coverage and counterevidence. Security-profile dimensions preserved: classes, reachable exploit paths, guards/false positives, calibrated impact, concrete remediation. True-positive example: changed unscoped ID lookup reaches another tenant; fix through current account scope. Safe counterexample: verified ownership-scoped lookup is not a vulnerability.

Desk cases: audit tenant leak → trace; denied tool → unchecked; no findings with unchecked path → qualified output. Stop: relevant replacement contract covered. Gap: language-specific exploit variants remain target-context work, not bundled claims. Strict validator blocked by missing PyYAML; no model benchmark.
