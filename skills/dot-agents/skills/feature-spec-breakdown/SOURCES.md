# Feature Spec Breakdown Sources

## 2026-10-08 — rename and file-backed tickets

User-directed: `feature-spec-to-todos` → `feature-spec-breakdown`. Tickets are saved as files (context survives sessions); list and order are agreed first, then each full ticket is reviewed one per turn; todos remain available as an optional output, alongside tracker publication on explicit instruction (tracker-agnostic). Added plan gate and spec/plan coverage table (previous skill read the plan but never checked coverage or handled a missing plan), and Figma/image/link handling. User-specified ticket shape: Context, Description, Steps to reproduce (bugs), Acceptance criteria; terse but complete.

Class: workflow-process. Shape: inline workflow + routed references (template, splitting patterns, publishing, examples).

| Source | Trust tier | Confidence | Contribution | Usage constraints |
| --- | --- | --- | --- | --- |
| https://github.com/mattpocock/skills/blob/9e2abf8611a345efbf779aacb171cff015bcdeb6/skills/engineering/to-tickets/SKILL.md | canonical upstream candidate | high content; inferred ancestry | Vertical-slice rules, quiz-then-publish, one file per ticket numbered in dependency order, prefactor first, expand–contract, avoid stale paths | Its `.scratch/` location, `ready-for-agent` label and setup skill are not local policy |
| https://www.humanizingwork.com/the-humanizing-work-guide-to-splitting-user-stories/ | secondary (practitioner guide) | high | INVEST, nine splitting patterns, meta-pattern, split-choice rules, Cynefin uncertainty handling | Condensed in own words in `references/splitting-patterns.md` |
| https://agentskills.io/specification | canonical spec | high | Frontmatter limits, name = directory, references one level deep, < 500 lines | Format only |
| Previous local `feature-spec-to-todos` (commit 3a7cbb9) | canonical local | high | Identity rules, Pi todo API encoding, dedupe, partial-failure recovery, approval gate | Todo tool demoted from sole output to optional handoff |
| Local `create-plan`, `pi/README.md`, `SYSTEM.md` | canonical local | high | Plan sections to check, `.agent-work/` layout, no-commit and no-customer-data rules | Local policy wins |
| User conversation (2026-10-08) | canonical requirements | high | Files over ephemeral todos, keep todos, tracker-agnostic, plan check, images/links, terse 4-section tickets, agree list before full review | — |

## Decisions

| Decision | Status | Evidence |
| --- | --- | --- |
| Files are source of truth; todos/tracker are handoff outputs | adopted | User; upstream local-file mode |
| Agree list + order before writing full tickets; review full tickets one per turn | adopted | User |
| Plan gate and spec/plan coverage table | adopted | User; other-agent assessment |
| Context / Description / Steps to reproduce / Acceptance criteria only | adopted | User; upstream template brevity |
| Omit implementation details by default; retain only necessary, source-backed constraints | adopted | User follow-up requirement; preserves outcome-focused tickets without dropping mandatory plan/ADR, compatibility, security, or migration constraints |
| Description defaults to prose; lists are used only when distinct items become clearer | adopted | User follow-up requirement; avoids checklist-like prose without banning useful lists |
| Ticket bodies contain no spec/plan/ADR citations; source coverage stays in the local header/index | adopted | User follow-up requirement |
| `Status`, `Blocked by`, `Source`, and `Published` remain local and are never published or mapped to Linear/Jira | adopted | User follow-up requirement |
| Inter-ticket references publish as hyperlinks to destination issues in any third-party tracker, including a final pass for forward references | adopted | User follow-up requirement |
| Necessary code pointers use path + symbol with commit SHA, no line numbers | adopted | Upstream "paths go stale" vs. user need for pointers |
| Stable ticket IDs; merges/splits never renumber | adopted | Resume and publication-record safety |
| Default tracker, triage label, auto-publish | rejected | User wants tracker-agnostic, explicit instructions |
| Separate todo skill alongside | rejected | Would duplicate slicing rules |

## Coverage

| Dimension | Status |
| --- | --- |
| Preconditions (identity, plan gate, resume) | complete |
| Ordered flow (outline → agree → write → review → handoff → report) | complete |
| Safety (no parent edits, no commits, customer data, explicit publish) | complete |
| Failure/recovery (missing plan, lost session, partial publish, duplicates) | complete |
| Outputs/acceptance (template, index, report) | complete |
| Tracker-specific field mappings | partial: asked at runtime by design |
| Runtime adherence | partial: desk checks only |

Stop rationale: upstream current revision, a canonical splitting guide, the format spec, and local contracts cover slicing, review, storage, and publish recovery; further generic search was low-yield (web search was unavailable; direct fetches succeeded).

## Earlier history

Previously `prd-to-todos` → `feature-spec-to-todos`; derived from mattpocock `to-tickets` (revision c55ee46) and sndrgrdn/pi `to-tickets` (54b2037) with local todo tool, identity, and approval contracts. See `skills/UPSTREAM.md`.
