# Code Review Sources and Decisions

Original synthesis: 2026-07-08. Research and primary-review redesign: 2026-09-24.

## Local For Real consolidation

User approved absorbing `for-real` into `code-review`, including explicit checks that requirements were implemented. Inspected source: former `for-real/SKILL.md` and `SOURCES.md`; recorded local history `f1ff2f87ff72e170bf897326c1a6f60b64cc308e`. Trust: canonical local; high confidence in instruction content, not measured effectiveness. No verified external original exists; do not invent an upstream URL or synchronization claim.

Replace overlapping verification guidance rather than add a workflow: retain target/diff scrutiny, independent expectations, actual checks, exact evidence and blocked prerequisites. Extend existing requirements/docs and validation sections with source-to-behavior/check mappings, missing/surplus scope, API/config existence checks and browser verification boundaries. Keep the four-pass shape and readiness output. No new dependencies or wrappers.

Deliberately reject former implicit repair authority: prior implementation approval alone does not authorize fixing findings in this review. Explicit per-finding or explicit batch authorization remains required, followed by verification on the changed revision. Narrow verification requests retain scope limits, not whole-change readiness. “For real” and “verify completed fix” should trigger; initial diagnosis and test-first implementation should not.

Static calibration case added to `references/review-examples.md`: independently sourced expiry requirement contradicts code and passing tests; missing intent stays unverified; missing required browser checks prevent READY. Sources are user decisions, referenced specs and applicable established contracts—not inferred implementation intent. This is desk evaluation, not an executed product review or measured model benchmark.

Retire the canonical `for-real` skill and its verified shared/Claude links. Validation results for this merge are recorded separately below; Thermos and earlier validation entries are historical, not proof of this change. Stop source collection here: the local contracts and explicit user decision suffice; external ancestry remains unknown.

### For Real merge validation

- Removed the canonical directory and both verified live symlinks. Existing shared/Claude code-review links still resolve to the canonical directory.
- Dependency-free `python3 -c` checks passed: requirement mapping, triggers, approval boundary, four-pass routing, reference existence, registration/removal state, whitespace and fenced blocks. Repository search found only historical/provenance references to `for-real`, not a remaining runtime dependency.
- `git diff --check -- skills/dot-agents/skills/code-review skills/dot-agents/skills/for-real skills/UPSTREAM.md`: passed, no output. Python also checked ignored skill-file whitespace.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`. Nothing installed; strict validation remains blocked.
- No spawned review or browser/product test executed. Static contract checks do not establish runtime adherence or completeness of future reviews.

## Local Thermos consolidation

User approved one `code-review` entry point with thermo checks always included in the existing four passes, not a separate opt-in mode or six-worker review. Keep both specialized Pi agents; dispatch them for security/data/rollout and rules/docs/patterns/code health, with general workers for the other two passes. Missing specialists use the same complete task packet through a general worker or permitted sequential review.

Absorb explicit developer-setup/feature-gate checks and stronger ownership, invariant and structural-simplification scrutiny. Preserve code-review's evidence, validation, scope, severity and readiness contract where the former thermo contracts differ: no default `main`, bare clean-audit output, automatic high severity or line-count blocker. Workers do not orchestrate nested reviews. Explicitly requested narrower scopes remain supported and cannot grant full-change readiness.

Inspected local sources: former `thermos/{SKILL.md,SOURCES.md}`, both Pi `thermo-nuclear-*/{SKILL.md,SOURCES.md}`, and both specialized agent definitions. Trust: canonical local; confidence high for instruction content, not empirical effectiveness. Remove the three redundant skill entry points and their verified live links; retain upstream consultation links below. No new dependencies or skill references required.

Desk cases: ordinary review dispatches four tasks, not six; “thermos” selects the same workflow; specialist unavailable gets general/sequential fallback; worker cannot load skill uses supplied rubric or reports incomplete; security-only excludes other dimensions; a 1001-line file or `unknown` at a trust boundary alone is not a defect; no findings still requires coverage and verdict. These are static contract checks, not observed review runs.

### Original Thermos resources — retain for future updates

Consult these upstream resources when updating the absorbed Thermos behavior. These exact historical URLs were recorded by the former `thermos/SOURCES.md`; they are provenance, not runtime dependencies. They are mutable and may now be missing. Do not claim a fresh fetch or immutable original-content pin from this consolidation.

| Resource | Original upstream URL |
| --- | --- |
| Thermos coordinator | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermos/SKILL.md |
| Correctness/security rubric | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-review/SKILL.md |
| Code-quality rubric | https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermo-nuclear-code-quality-review/SKILL.md |
| Correctness worker | https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-review-subagent.md |
| Code-quality worker | https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-code-quality-review-subagent.md |

Recorded upstream trust: secondary-external; historical source content/removal comparison previously recorded with high confidence. Exact original ancestry/content revision remains unpinned. To recover removed files, inspect the repository's history before the removal commit rather than assuming current URLs still contain them:

- Repository: https://github.com/sndrgrdn/pi
- Removal commit (`remove thermos skill + agents`): https://github.com/sndrgrdn/pi/commit/54b2037a480491d2a7e8eaebd854163e875edad5
- Inspected replacement coordinator: https://github.com/sndrgrdn/pi/blob/54b2037a480491d2a7e8eaebd854163e875edad5/skills/deep-review/SKILL.md
- Current replacement lookup: https://github.com/sndrgrdn/pi/blob/master/skills/deep-review/SKILL.md (mutable; verify on refresh).

The earlier comparison inspected the replacement coordinator, not all its rubric leaves. Adopted pinned shared scope, independent evidence, counterevidence, root-cause/remedy deduplication and honest incomplete coverage. Do not automatically import upstream four-judge policies, tool assumptions, permission changes or mechanical blockers. Local four-pass behavior is this user's decision, not a claim of an upstream migration. Stop research here for this local merge; no new external claim needs retrieval.

### Consolidation validation

- Dependency-free `python3 -c` structural check passed: four-pass routing, all five original upstream URLs, removal/replacement commit reference, bundled reference existence, worker coverage/no-nesting contracts, canonical registration targets, removed directories/link, balanced fences and whitespace. This is not strict YAML/depth validation or a runtime review test.
- `git diff --check -- skills/dot-agents/skills/code-review skills/UPSTREAM.md pi/dot-pi/agent/agents pi/dot-pi/agent/skills`: passed, no output. Ignored skill/agent file whitespace was also checked by Python.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependencies installed.
- Live registration verified: shared code-review links point to the canonical source; Pi agents/skills use canonical parent-directory links. Removed three skill directories and the sole separate Thermos symlink; both specialist agent files remain.
- No application review or spawned-worker behavior evaluation performed. Future runtime adherence and strict validation remain open gaps.

The research and validation sections below predate this consolidation unless explicitly labeled otherwise.

## Requested behavior and shape

User requires exhaustive automated review with no assumed later human review: repo rules, best practices, edge cases, recent deployed-code patterns, relevant documentation, and confirmation rather than guessing.

Class: security-review + workflow-process. Shape: one self-contained ordered review workflow with four independent perspectives and permitted sequential fallback. One directly routed examples reference supports evidence calibration; SPEC.md records the materially changed readiness contract. No scripts, dependencies, new agent definitions or registration changes needed.

Replace the former lightweight/findings-only default and optional deep mode. Preserve read-only boundaries, local severity names, scoped findings, counterevidence and concise individual comments. Exhaustiveness is coverage accountability, not a claim of perfect recall.

## Research shortlist

Checked the skills.sh leaderboard before other discovery. Public websearch failed (`fetch failed`); used public skill pages and read-only GitHub metadata/tree/content retrieval instead. No CLI bootstrap or installs. Popularity is a discovery signal, not measured effectiveness or safety.

Observed 2026-09-24; install counts are rounded as displayed and stars are repository-wide:

| Candidate | Installs | GitHub stars / last push | Fit and limits |
| --- | --- | --- | --- |
| [Trail of Bits differential-review](https://skills.sh/trailofbits/skills/differential-review) | 6.9K | 7,226 / 2026-09-23 | Strongest inspected specialist for history, blast radius and adversarial tracing. Not a complete general review. Reject scope-skipping shortcuts and automatic risk/severity inflation |
| [Matt Pocock code-review](https://skills.sh/mattpocock/skills/code-review) | 609.3K on leaderboard | 268,883 / 2026-09-24 | Strong fit for independent standards/spec checks and pinned target. Add correctness/security/rollout and remove fixed short-output limits |
| [Sentry code-review](https://skills.sh/getsentry/skills/code-review) + find-bugs | 4.8K for code-review; find-bugs not verified | 1,004 / 2026-09-21 | Broad baseline and complete-diff/attack-surface accounting. Do not import human escalation, Sentry-specific conventions or assume a framework |
| [Anthropic code-review and PR toolkit](https://github.com/anthropics/claude-code/tree/d78be9481b889e11186ec4578b4f5e9301396e25/plugins) | Not verified | 147,907 / 2026-09-24 | Useful separate validation, behavioral test and failure-path perspectives. Default code-review explicitly excludes input/state-dependent bugs; unsuitable unchanged for this request |

Recommendation: maintain this local synthesis rather than install a replacement. These are task-fit judgments from inspected content, not an empirical ranking of the ecosystem. No upstream scripts executed or agent/tool availability assumptions imported.

## Source inventory

All GitHub paths below were read at the exact revision shown. These are pattern references, not newly claimed original ancestry. Usage is original local formulation of review ideas; no upstream files/scripts or substantial example text copied.

| ID | Source and exact inspected files | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- | --- |
| T | [trailofbits/skills @ 32e34f8173796e3566a51aee877dc96bc5191f64](https://github.com/trailofbits/skills/tree/32e34f8173796e3566a51aee877dc96bc5191f64/plugins/differential-review/skills/differential-review): SKILL.md, methodology.md, adversarial.md | canonical publisher; external pattern | High for retrieved instructions, not automatic correctness | Repo license metadata CC-BY-SA-4.0. Attribute concepts; no text/code vendored. Reject checkout commands, obligatory file writes, heuristic severity multipliers and unproved example impacts |
| M | [mattpocock/skills @ c55ee46073ed923f86ce59a5eb3b6d895095d1b7](https://github.com/mattpocock/skills/blob/c55ee46073ed923f86ce59a5eb3b6d895095d1b7/skills/engineering/code-review/SKILL.md): skills/engineering/code-review/SKILL.md | canonical publisher; external pattern | High | Repo license metadata MIT. No setup dependency or fixed 400-word worker cap; scoped standards/spec remain distinguishable |
| S | [getsentry/skills @ c2f99a5b04b4cd992ec3022d7c2c3e23e938d241](https://github.com/getsentry/skills/tree/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills): code-review/SKILL.md, find-bugs/SKILL.md | canonical publisher; external pattern | High | Repo license metadata Apache-2.0. Complete input and verification concepts only; no human-review requirement, shell substitution or assumed local tooling |
| A | [anthropics/claude-code @ d78be9481b889e11186ec4578b4f5e9301396e25](https://github.com/anthropics/claude-code/tree/d78be9481b889e11186ec4578b4f5e9301396e25/plugins): code-review/commands/code-review.md; pr-review-toolkit/agents/silent-failure-hunter.md and pr-test-analyzer.md; root LICENSE.md | canonical publisher; external pattern | High for retrieved content | LICENSE.md reserves rights under Commercial Terms; no content vendored. Reject guaranteed-tool assumptions, automatic comments, no-context review, input-independent-only bug bar, provider models and unconditional critical severity for catches |
| G | [Google review scope](https://google.github.io/eng-practices/review/reviewer/looking-for.html) and [standard](https://google.github.io/eng-practices/review/reviewer/standard.html) | canonical engineering guidance | High | Live pages, no immutable revision captured. Every-line/context, meaningful tests, code health and documented-rule precedence; adapt away from human-review handoff |
| O | [OWASP Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html) | canonical security guidance | High | Live page. Object-level authorization, per-request enforcement, framework/config verification, safe denial and privacy-aware logging; not a comprehensive language security reference |
| D | [skills.sh leaderboard](https://skills.sh/) and candidate pages above | secondary discovery/metrics | Medium | Report displayed metrics only; badges/install counts are not a code audit or effectiveness benchmark |
| L | Existing local SKILL.md/SOURCES.md, adjacent thermos workflow, skill-writer workflow and user requirements | canonical local | High | Existing safeguards and new user contract override upstream defaults. Skill-writer workflow/security example profiles selected |

## Decisions and rationale

| Decision | Status | Evidence / reason |
| --- | --- | --- |
| Default exhaustive primary review, all actionable findings, explicit readiness | adopted | User request; S complete-input accounting; G every-line coverage. Replace optional-depth and bare no-findings output |
| Four independent perspectives with sequential fallback | adopted | M standards/spec separation; A specialized test/error reviews; local missing-worker safety. No assumption a particular agent exists |
| Mandatory relevant-document review in both directions | adopted | User follow-up; G documentation/consistency. Check code against rules/contracts and docs made stale by the patch |
| Version-matched official references and confirm-before-asserting | adopted | User follow-up; O framework/config caveats. Unverified behavior/intent/deployment stays unknown |
| Recent analogues, removed-guard history and deployed-contract comparison | adopted | User requirement; T history/baseline invariant tracing. Distinguish merged/released/deployed and account for rollback/mixed versions |
| Concrete edge-case/abuse scenarios and counterevidence | adopted | T attacker model; S attack-surface mapping; O authorization; A behavioral test perspective |
| Drop input/state-dependent bugs or context outside diff | rejected | A defaults conflict directly with requested edge-case and integration coverage |
| Automatically escalate risk based on caller count, absent tests or broad catch | rejected | T/A heuristics do not prove harm; severity must follow confirmed impact |
| Skip low-risk files, force report-file writes, checkout baseline, post comments | rejected | T/A defaults conflict with complete coverage and local read-only/permission boundaries |
| Treat recent deployed pattern as correct by definition | rejected | Deployment proves use only; rules/invariants/confirmed failure outrank frequency |
| Delegate final safety to unspecified human review | replaced | User workflow. Missing evidence produces scoped INCOMPLETE with exact next action |
| New reference and SPEC | adopted | Material readiness change needs a maintenance contract; synthetic true-positive, safe-pattern, remediation and recovery examples prevent abstract-only guidance |

## Coverage matrix

Statuses below describe documentation coverage by desk inspection, not executed review accuracy.

| Dimension | Status | Evidence / remaining limit |
| --- | --- | --- |
| Preconditions / ordered process | complete | Pin → inventory → docs → recent/deployed context → four passes → verify → verdict |
| Safety and failure recovery | complete | Read-only, permitted test environment, denied worker fallback, stale CI/changed worktree handling |
| Outputs / acceptance | complete | Per-finding blocking status; coverage/source/validation ledger; BLOCKED/INCOMPLETE/READY |
| Vulnerability classes and prerequisites | complete for general-review rubric | Auth, input/sink, privacy, supply chain and resource/business risk; actual target determines applicable classes |
| Exploit evidence / safe counterexamples / remediation | complete | Traced guard/caller evidence; synthetic tenant regression, equivalent policy, correction and test cases |
| Severity and confidence | complete | Confirmed impact separate from uncertainty, coverage and mandatory-rule gate |
| Rules, relevant docs and best practices | complete | Scoped standards, version evidence, contract mapping, stale-doc check and conflict handling |
| Edge cases, tests and operational failure | complete | Input/state/time/concurrency/partial-failure/version matrix, behavioral assertions, exact check evidence |
| Recent pattern / deployed compatibility | complete guidance | Recent independent analogues, history, verified current deployment per environment, old/new coexistence |
| Framework-specific exploit details | partial | Retrieve locked-version official security/source docs when reviewing an actual target; no language-specific completeness claim |
| Empirical detection quality | partial | Run isolated baseline/candidate cases before making precision/recall claims |

Selected profiles: skill-writer `references/examples/security-review-skill.md` and `workflow-process-skill.md`. The examples reference covers true/false positives, remediation, happy path, guarded production boundary, denied-worker recovery, deterministic reporting and version ambiguity. This is a general workflow, not a vendored integration API guide.

## Trigger and behavior desk checks

Should trigger: “review this PR”, “review my diff exhaustively”, “find edge cases”, “check these changes against repo rules and docs”, “compare this approach with recently deployed code”, “security review this patch”, “give pasteable review comments”.

Should not trigger: “implement this feature”, “deploy this branch”, “explain this API”, “find a skill to install”, “write a PR description”, or production debugging without a review target.

Description change: make exhaustive/default coverage, relevant docs, recent deployed patterns and absence of later human review discoverable; retain PR/diff/review/edge-case language without provider assumptions.

Static expected before/after behavior (not measured model runs):

| Case | New required result / delta |
| --- | --- |
| Plain “review this diff” | All passes + docs/history + coverage/verdict, rather than lightweight findings only |
| Bug only at expiration boundary | Investigate exact inputs; do not discard as merely input-dependent |
| Authentication exists but object ownership removed | Trace middleware/policy and return confirmed finding if exposed |
| Mandatory equivalent guard exists elsewhere | Suppress pattern-only accusation after inspecting guard/callers |
| Ten independent actionable issues | Return all ten, not strongest few |
| Worker denied | Sequential permitted review or explicit incomplete pass |
| Required tests blocked / CI stale | Not READY; show command/error/revision mismatch |
| Recent merge with no deployment evidence | Do not call it deployed; incomplete if live compatibility is required |
| Rollback or mixed producer versions | Check both schemas and old queued payloads, not only all-new state |
| New code follows docs but docs describe wrong framework version | Resolve locked-version facts; unknown if inaccessible |
| Config renamed but runbook unchanged | Verify and report the concrete broken documented workflow |
| Valid intentional departure from recent patterns | Explain justification; no taste-only finding |
| No findings, complete appropriate checks | Scoped READY with coverage, not bare “No findings” |
| Security-only or truncated review | No whole-change READY; identify exclusions and remaining work |
| Explicit audit of unchanged files | Review pinned content and existing defects within that scope; do not demand a diff |
| Focused tests pass but mandatory integration gate absent | Inventory applicable gates; missing mandatory evidence prevents READY |

## Validation and registration

- `git diff --check -- skills/dot-agents/skills/code-review skills/UPSTREAM.md`: passed, no output.
- Dependency-free `python3 -c` structural check: PASS for four skill files; scalar frontmatter/name/description, 188-line body, one routed reference, balanced fences, whitespace, portable paths and key contract markers. This is not a general YAML parser or a behavioral evaluation.
- `python3 skills/dot-agents/skills/skill-writer/scripts/quick_validate.py skills/dot-agents/skills/code-review --skill-class security-review --strict-depth`: blocked, exit 1, `ModuleNotFoundError: No module named 'yaml'`. No dependency installed.
- Independent read-only document audit identified three consistency gaps; corrected whole-file scope, worker-fallback wording, and explicit inventory of mandatory validation gates. Final local desk inspection confirmed the corrections and the representative cases above; no model benchmark or application review executed.
- GitHub commit endpoints independently confirmed all four publisher revisions used above.
- Existing registration/name/invocation preserved. No installation, application-code changes, production access, PR publication or git commit performed.

## Retrieval stopping rationale

Four inspected publishers plus Google/OWASP cover complementary orchestration, completeness, rules/spec, history, abuse evidence, tests and failure paths. User requirements supply the deployment/docs/confirmation contract. Additional generic review lists would duplicate these concepts; target-specific docs and actual deployment data belong in each future review. No claim that one published skill is universally best.

## Open gaps

- Run strict validation in an existing approved Python/PyYAML environment if available; do not install dependencies implicitly.
- Run isolated behavior/trigger evaluations to measure adherence, precision, recall and cost; desk checks cannot establish effectiveness as the only review layer.
- Retrieve application-specific locked-version docs, current deployment evidence and repo-required gate policy during actual reviews. This dotfiles update has no application deployment target.
- Candidate install metrics for find-bugs and Anthropic plugins were not verified; verify them if installation is later considered.

## Historical provenance

The previous local synthesis recorded sndrgrdn/pi `skills/code-review/SKILL.md`, thermos and thermo agents. Earlier 2026-09-24 research inspected [revision 54b2037a480491d2a7e8eaebd854163e875edad5](https://github.com/sndrgrdn/pi/tree/54b2037a480491d2a7e8eaebd854163e875edad5/skills), where deep-review replaces removed thermos paths. That comparison contributed pinned shared input, root-cause/remedy deduplication and honest incomplete coverage. Those safeguards remain; the old lightweight/findings-only default is intentionally superseded by this user's new contract. No new historical-lineage claim made for the additional publishers.
