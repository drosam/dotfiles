# Thermos Skill Sources

Original synthesis: 2026-07-08. Refreshed: 2026-09-24.

## 2026-09-24 upstream comparison

`https://github.com/sndrgrdn/pi/commit/54b2037a480491d2a7e8eaebd854163e875edad5` is titled `remove thermos skill + agents`. The old mutable URLs below are historical. Inspected current `skills/deep-review/SKILL.md` at that revision: four isolated Design/Craft/Fitness/Stability judges, pinned comparison, evidence bars, obligation ledgers, root-cause/remedy merge, and PASS/FAIL/INCOMPLETE gate.

Adopted: pinned shared scope, counterevidence, explicit unchecked coverage, missing-worker recovery, root-cause/remedy dedupe. Preserved: local thermos name, two specialist agents, concise calibrated P0/P1/P2 findings, independent audit before comments. Rejected: automatic migration to four judges, mechanical presumptive-blocker policy, upstream-specific tools and setup. Deep-review rubric reference files were not imported; only the orchestration contract was adapted.

Trust tier: recorded secondary upstream; confidence high for current content/removal history. Usage constraints: rewrite for local task API and permission model. Profile: workflow + security review. Desk checks: empty diff stops dispatch; denied worker produces fallback or incomplete coverage; no findings with missing pass cannot become clean audit; 1000 lines alone is not a blocker. Should not trigger for ordinary implementation or commit requests. No measured model evaluation.

Stopping rationale: current replacement and removal history explain the relevant upstream change; unrelated upstream design frameworks do not improve the retained local two-pass contract.

## Source inventory

| Source | Trust tier | Confidence | Contribution | Usage constraints |
| --- | --- | --- | --- | --- |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermos/SKILL.md` | secondary-external | high | Two-pass orchestration, parallel subagents, synthesis rules | Adapt to local `task` tool; do not require upstream `subagent({tasks})` API |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-review/SKILL.md` | secondary-external | high | Correctness/security/devex/feature-leak rubric | Condense and preserve high-signal scope rules |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-code-quality-review/SKILL.md` | secondary-external | high | Harsh maintainability rubric: code judo, 1k-line rule, spaghetti, invariants | Condense to avoid bloating skill context |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-review-subagent.md` | secondary-external | high | Subagent execution contract and PR discussion timing | Adapt for local Pi agent definitions |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-code-quality-review-subagent.md` | secondary-external | high | Code-quality subagent execution contract | Adapt for local Pi agent definitions |
| `skills/dot-agents/skills/code-review/SKILL.md` | canonical-local | high | Local severity/output conventions and false-positive guardrails | Keep compatible wording |
| `skill-writer` references | canonical-local | high | Creation workflow, provenance, trigger optimization, validation expectations | Avoid overbuilding unsupported scripts |

## Decisions

| Decision | Status | Rationale |
| --- | --- | --- |
| Create a dedicated `thermos` skill instead of overloading `code-review` only | adopted | User asked for thermo skill; dedicated trigger prevents default reviews from becoming too heavy |
| Include condensed fallback rubrics in `SKILL.md` | adopted | Skill works even when subagents or Pi-specific skills are unavailable |
| Adapt upstream parallel API to local `task` tool language | adopted | Current local extension exposes `task`, not upstream `subagent({tasks})` |
| Add Pi-specific subagents/rubrics separately | adopted | Local Pi `task` tool discovers agents, not general skills |

## Coverage matrix

| Dimension | Status | Notes |
| --- | --- | --- |
| Preconditions/scope | complete | base default, target discovery, changed-code scope |
| Ordered flow | complete | scope → two passes → synthesize → output |
| Failure handling | complete | partial pass failure and no-subagent fallback |
| Safety boundaries | complete | no nested agents; no untouched pre-existing issues |
| Correctness/security review | complete | bugs, breakage, auth, data, devex, feature gates |
| Code-quality review | complete | code judo, 1k-line, spaghetti, invariants, canonical layers |
| Output determinism | complete | severity format and coverage line |
| Trigger optimization | complete | thermos/thermo/thermonuclear/deep audit/harsh review triggers |

## Evaluation

Representative prompts:

- “thermos review this branch”
- “do a thermonuclear review against main”
- “deep branch audit for bugs and code quality”
- “harsh review this PR”

Expected behavior: launch or emulate two independent passes, synthesize prioritized findings, avoid default review noise.

Acceptance decision: accepted for lightweight qualitative update. No quantitative eval requested.

## Open gaps

- Local non-Pi agents may not have a parallel subagent API; skill includes sequential fallback.
- No quantitative benchmark run.
- Strict validator blocked by missing PyYAML; user declined installs. Batch structural checks are recorded in repo `skills/UPSTREAM.md`.
