# QA Review — Sources and Evaluation

Research date: 2026-10-02. New standalone skill; `.agent-work/` absent in dotfiles. User requested branch/PR QA using work context, Figma/tickets, project browser instructions and Playwright, with code-review-style fix-agent handoff; subsequently made visual/style checks explicit. Original synthesis, not a claimed upstream fork. No upstream scripts/templates installed or vendored; source concepts adapted into local wording/policy.

## Source inventory

Trust tier describes authority for the stated purpose, not permission to execute source instructions. Confidence concerns inspected content, not guaranteed safety or exhaustive ranking.

| ID | Source / inspected revision | Trust tier | Confidence | Contribution / Usage constraints |
| --- | --- | --- | --- | --- |
| Local | `skills/dot-agents/skills/{code-review,review-triage,skill-writer}/`, `pi/README.md`, root README, installation script; repository HEAD `f08057c64e877fd1f922d354846492914ce56644` plus inspected worktree | canonical | high | Preserve selected-work identity, immutable report/index/Active triage contract, safety and authoring gates; don't invoke fix/commit workflow during QA |
| Spec | [Agent Skills format](https://agentskills.io/specification), [authoring best practices](https://agentskills.io/skill-creation/best-practices) | canonical | high | Portable name/frontmatter, focused instructions, progressive disclosure; live pages, no immutable revision captured |
| Pi | Active executable resolves to `@earendil-works/pi-coding-agent` 1.0.0; installed `docs/skills.md`, `docs/cli.md`, package metadata | canonical | high | Shared `.agents/skills` discovery, `/skill:qa-review`, `/reload`, no settings registration; older repo guide mentions 0.87.1 |
| PW | [Playwright best practices](https://playwright.dev/docs/best-practices) | canonical | high | User-visible behavior, isolation, semantic locators, observable assertions; reject staging recommendation and auto-install/upgrade examples under local policy |
| MCP | [Playwright MCP README](https://github.com/microsoft/playwright-mcp/blob/main/README.md) | canonical | high for inspected portions | Snapshot/actions, context isolation, version-varying tool schemas, output paths, non-security-boundary warnings; fetched through core tools section, later optional tools truncated; not a complete API audit |
| Figma | [Figma MCP tools](https://developers.figma.com/docs/figma-mcp-server/tools-and-prompts/) | canonical | high | Design context plus screenshot, node metadata narrowing, variables/component mappings; use read-only tools and current schemas, not code-to-design writes; live page |
| V | [Vercel dogfood](https://github.com/vercel-labs/agent-browser/blob/39a74c70d7759d5a6de7a22c04570bb626bbd081/skill-data/dogfood/SKILL.md) | canonical upstream | high | Repro evidence, issue structure, exploration taxonomy; Apache-2.0 at same revision; not adopted as installed dependency |
| M | [Microsoft playwright-cli](https://github.com/microsoft/playwright-cli/blob/b85c7a736bb473bf55b584e54a09ffa698d6d871/skills/playwright-cli/SKILL.md) | canonical upstream | high | Snapshot/interaction workflow, fixtures, diagnostics; Apache-2.0 at same revision; adapt concepts to existing MCP, do not require CLI |
| A | [Anthropic webapp-testing](https://github.com/anthropics/skills/blob/8a1541c4a3ffa5a20a5a91de0dcf3f0bab1d1ef4/skills/webapp-testing/SKILL.md) | canonical upstream | high | Rendered-state reconnaissance and console collection; skill-local Apache-2.0 `LICENSE.txt`; reject uninspected helper execution/automatic server startup |
| Catalog | [skills.sh leaderboard](https://skills.sh/), candidate listings below | secondary | medium | Discovery/popularity signal only; counts are mutable, not safety or quality proof |

### Candidate vetting

Read actual skills and relevant executable/reference paths, not just search snippets:

- V at pinned revision: `skill-data/dogfood/references/issue-taxonomy.md`, `skill-data/dogfood/templates/dogfood-report-template.md`; discovery stub `skills/agent-browser/SKILL.md` and `cli/src/skills.rs` explain moved workflow location. Adopt stable issue IDs, expected/actual, repro steps, proportionate evidence and state coverage. Reject 5–10 issue quota, full-app mutation defaults, source-reading ban, mandatory video, nonreproducible-issue dismissal, and auth state beside reports.
- M at pinned revision: `skills/playwright-cli/references/{test-generation,tracing,pr-attachments,running-code}.md`. Adopt project fixtures, observable expectations, console/network evidence. Reject healing specs to match live behavior, page-provided tools replacing UI, token-driven viewport selection, auto-bootstrap/background work, and implicit PR uploads. References disagree on `networkidle`; use observable conditions instead.
- A at pinned revision: `skills/webapp-testing/scripts/with_server.py`, `examples/console_logging.py`. Adopt inspect-before-act and console baseline. Do not reuse helper: shell execution, port readiness not app identity, output-pipe and child-cleanup concerns; no automatic Python/headless dependency or fixed-sleep/blanket-networkidle policy.

License URLs: [V](https://github.com/vercel-labs/agent-browser/blob/39a74c70d7759d5a6de7a22c04570bb626bbd081/LICENSE), [M](https://github.com/microsoft/playwright-cli/blob/b85c7a736bb473bf55b584e54a09ffa698d6d871/LICENSE), [A](https://github.com/anthropics/skills/blob/8a1541c4a3ffa5a20a5a91de0dcf3f0bab1d1ef4/skills/webapp-testing/LICENSE.txt). No bulk skills update or CLI bootstrap performed.

### Popularity snapshot

Observed 2026-10-02; GitHub values are repository-wide, activity is last push, install counts are displayed rounded counts with unknown measurement date. Research-worker observations, not independent audit of metrics.

| Candidate | GitHub stars | Last push | skills.sh installs |
| --- | ---: | --- | --- |
| Vercel agent-browser/dogfood | 43,454 | 2026-10-01 | Dogfood unknown; [old dogfood listing](https://skills.sh/vercel-labs/agent-browser/dogfood) now renders agent-browser, whose 1.0M count must not be assigned to dogfood |
| Microsoft playwright-cli | 13,727 | 2026-09-28 | [172.2K](https://skills.sh/microsoft/playwright-cli/playwright-cli) |
| Anthropic webapp-testing | 179,364 | 2026-09-29 | [168.6K](https://skills.sh/anthropics/skills/webapp-testing) |

Metadata sources: `https://api.github.com/repos/vercel-labs/agent-browser`, `https://api.github.com/repos/microsoft/playwright-cli`, `https://api.github.com/repos/anthropics/skills`. These are the best matching inspected candidates, not proof of the best skills across the entire ecosystem. Public search backend failed during worker research; direct leaderboard/GitHub/source retrieval succeeded.

## Decisions and precision pass

| Decision | Status | Evidence / rationale |
| --- | --- | --- |
| New `qa-review`, not expansion of `code-review` | adopted | User wants a browser-first workflow; preserve existing static review and triage boundaries |
| Sequential reference-backed workflow | adopted | One shared browser is stateful; no new script/dependency/mandatory agents needed |
| Reuse local artifact schema | adopted | Local code-review/review-triage retain branch series, Latest vs Active triage and immutable reviews |
| Functional plus mandatory visual pass | adopted | Explicit user follow-up; DOM/click success cannot establish styles/appearance |
| Figma optional source, visuals not optional | adopted | Missing designs don't prevent objective style/usability checks; fidelity claims still need a reference |
| Confirm work; map requirements independently | adopted | Local policy; prevents cross-session artifact confusion and implementation-derived oracle |
| Local-only app, approvals for effects | adopted | Local permission rules override upstream broad exploration/staging/server defaults |
| Install upstream skill/CLI or vendor helper | rejected | Existing Playwright MCP sufficient; risky behavior/dependencies not needed |
| Complete design/accessibility certification | rejected | Evidence must match actual measurements, screenshots, states and platforms |
| Quantitative/model execution benchmark | deferred | No target app or benchmark request; preserve explicit static-evaluation limits |

Behavior delta: new QA orchestration fills a browser/visual acceptance gap without changing existing skills. Added browser reference for safety/state/tool failure modes; visual reference for mandatory style criteria and matched comparisons; report reference for fragile durable handoff; examples for happy, guarded, failure-recovery and false-positive cases. Replaced initial generic browser description with explicit visual/style triggers; narrowed generic regression guidance to representative shared-CSS consumers. No redundant runtime source history or executables added.

## Coverage matrix

Class: `workflow-process`. Selected profile: skill-writer `references/examples/workflow-process-skill.md`. This is an operational workflow using integrations, not an API-teaching guide or skill generator; integration use-case quotas and skill-authoring API depth rubric do not apply.

| Dimension | Status | Evidence |
| --- | --- | --- |
| Preconditions/context | complete | Scope pinning, work selection/reciprocity, project instructions, linked ticket/design ledger, build provenance |
| Ordered execution | complete | Scope → context → matrix → safe browser/visual pass → confirmation → handoff |
| Safety/permissions | complete | Local-only backend verification, named effects approval, no fixes/installs/publication, sanitized evidence |
| Outputs/acceptance | complete | Requirement/scenario + visual matrix, stable findings, QA-only verdict, immutable report/index |
| Failure/recovery | complete | Stale refs/locators, missing browser/design/access, intermittent failures, denied effects, write/index failure |
| Escalation/handoff | complete | Targeted questions, exact gaps/retest, receiving-agent approval, Active triage preservation |
| Positive/negative/repair examples | complete | Happy-path repro, guarded payment environment, stale-locator recovery, anti-pattern corrections, retests |
| Version/platform variance | complete for workflow | Dynamic MCP schemas, project Playwright version, browser/viewport/reference state, mutable Figma attribution |
| Runtime effectiveness | partial | Validate on an explicitly authorized local target and measure actual agent adherence |

Expansion passes cover normal behavior (V/M/A + PW), failures (helpers, tool/schema/readiness/fixture problems), false positives (mismatched oracle/state/viewport), remediation (concrete fix direction/retest and immutable corrections), and version/platform variance (MCP/Figma/current Pi docs). Profile-required transcripts/template/changelog guidance exist in examples/report and these maintenance notes; synthetic examples are labeled, not invented historical runs.

## Trigger and qualitative evaluation

Static desk checks only; no measured model runs or claimed numerical improvement. Baseline is inspected upstream candidate guidance without local QA adaptation.

| Prompt | Route / expected guidance | Baseline → skill expectation |
| --- | --- | --- |
| “QA this branch before merge” | Load qa-review; pin scope and context, run functional+visual checks | improved: branch-aware oracle and artifacts |
| “Check PR 42 in Playwright against its ticket and Figma” | Load; linked sources + runtime matrix | improved: requirements and design linkage |
| “Check styles and mobile layout on this branch” | Load; screenshot/style pass, state/viewport matching | improved: mandatory visual scope |
| “Compare implemented UI to Figma and leave a fix-agent report” | Load; source-backed visual findings and immutable handoff | improved: evidence+handoff |
| “QA it, server is down; don't start anything” | Load; blocked browser, no startup, INCOMPLETE | improved: explicit no-side-effect boundary |
| “No Figma; did the shared theme change break styles?” | Load; documented tokens/representative screens/screenshots | improved: no optional-source skip |
| “Review this diff for SQL injection” | Do not route; static/security code-review | unchanged purpose separation |
| “Implement this Figma screen” | Do not route; implementation workflow | unchanged, no false fix authority |
| “Write a Playwright regression test” | Do not route as QA review alone; test authoring | narrowed boundary |
| “Walk through existing QA findings one at a time” | review-triage, not fresh discovery | improved local handoff distinction |

Additional acceptance desk checks: single unselected work candidate asks; stale runtime/dirty worktree remains explicit; localhost with remote live backend stops; no-write forbids screenshot persistence; source conflict is incomplete; intermittent evidence retained; new report preserves Active triage; manual comparison cannot claim pixel-perfect; missing screenshot inspection leaves visual gap. See `SPEC.md` for the complete acceptance set.

## Validation and registration

- Registered one direct live `~/.agents/skills/qa-review` symlink to canonical `skills/dot-agents/skills/qa-review`; verified with `readlink`. No provider-settings/README registration needed. Broad dotfiles installer not run; unrelated WIP untouched. Use `/reload` in Pi.
- `python3 --version`: 3.9.6, below validator's declared 3.12 minimum. Found existing `python3.14` without installing anything.
- `python3.14 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/qa-review --skill-class workflow-process --strict-depth`: **blocked**, exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependency installed; no strict-depth pass claimed.
- Dependency-free structural check through existing read/codemode tools: **7 files, 4 directly routed references, 95 SKILL.md lines, 580 description characters, 0 errors**. Checked simple frontmatter/name/description limits, reference existence, portable runtime paths, trailing whitespace and final newline. Not YAML parsing or strict-depth validation.
- `git diff --check`: passed, no output; new untracked skill files covered separately by structural whitespace checks, not this Git command.
- `pi --offline --no-extensions --no-skills --no-prompt-templates --no-themes --no-context-files --no-approve --help`: exit 0, supported CLI options confirmed. Extensions disabled; no model invocation. This is a CLI smoke check, not proof of interactive skill loading.
- Independent read-only worker desk review covered all seven files against code-review/review-triage. Found source-snapshot filtering mismatch; corrected to retain every comment in selected supplied feedback, with an added acceptance case. No other supported issues returned. Reread runtime guidance; clarified inspected/authorized project-command execution and absent-spec wording.
- Acceptance: authored and registered; structural/profile desk checks complete. Strict validator and real application/model evaluation remain unverified, not a full validation sign-off.

## Stopping rationale

Three deeply inspected complementary skills plus official Playwright/Figma/Agent Skills documentation and local review/triage contracts cover high-impact behavior, safety, visual evidence, failure recovery and handoff. Further generic marketplace searches are low-yield for this contract. No private project is available to supply real failures; do not invent them. Missing runtime evidence is the next useful input, not additional skill installs.

## Open gaps

- Rerun the exact strict validator command in an approved existing Python 3.12+/PyYAML environment, or obtain dependency-install approval; current environment lacks PyYAML.
- Validate actual runtime adherence and trigger precision with an authorized isolated local app, linked test ticket/design, dirty-build mismatch, visual defect and fix-agent retest; none executed during authoring.
- Confirm optional browser capabilities against live schemas at use time; upstream MCP output was truncated after core tools and is not a guaranteed installed-version API reference.
- Retrieve dogfood-specific installs only if its distinct listing becomes available; current redirected aggregate is not attributable.
