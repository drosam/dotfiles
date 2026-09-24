# Grill Me Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: inline dependency-aware rounds.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| https://github.com/mattpocock/skills/tree/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/productivity | canonical upstream candidate | high content; inferred lineage | Read grill-me/SKILL.md and grilling/SKILL.md; do not require an uninstalled skill or Skill tool |
| Local skill and rename history | canonical local | high | Preserve name, manual invocation, recommended answers |

Upstream grill-me now routes to grilling; grilling batches the current independent decision frontier. Adopt rounds and stop/handoff boundary, with explicit one-at-a-time preference support and blocked-worker fallback. See SPEC.md.

Coverage/profile: input/context, round order, dependent questions, fact lookup, denied tools, stop and handoff covered. Desk cases: independent tenancy/retention questions share a round; index design waits for tenancy; finished interview does not implement.

Stop: route and delegated source both inspected; no missing runtime skill dependency introduced. Gap: original local ancestry inferred, not locked. Strict validator blocked by missing PyYAML; interview quality not benchmarked.
