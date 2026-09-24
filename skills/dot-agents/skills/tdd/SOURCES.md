# TDD Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: reference-backed implementation.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/tdd/SKILL.md | canonical upstream candidate | high content; inferred lineage | Strong local text match, no source lock; preserve local red-green-refactor |
| Local SKILL and tests/mocking/deep-module references | canonical local | high | Existing reference paths remain valid |

Also read upstream `tests.md` and `mocking.md` at the same revision. Local mocking guidance matches the retrieved source; tests.md gains the upstream anti-tautology principle with a locally transformed example.

Adopt agreed public seams, independent expected values, glossary/ADR vocabulary. Add baseline discovery and real RED vs setup-failure distinction. Reject upstream requirement to move all refactoring into a separate review and dependency on uninstalled codebase-design skill.

Coverage/profile: planning preconditions, vertical cycle, false-green/setup failure, test isolation, scope and output evidence covered. Desk cases: test-first feature → agreed seam; tautological assertion → independent literal/spec; setup error → not valid RED. Negative: read-only diagnosis/test review.

Stop: current main workflow and existing local references cover changed behavior. Gap: historical ancestry remains inferred; obtain original provenance if an exact historical baseline is required. Strict validator blocked by missing PyYAML; no application tests executed.
