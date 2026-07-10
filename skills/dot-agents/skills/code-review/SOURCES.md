# Code Review Skill Sources

Retrieval date: 2026-07-08

## Source inventory

| Source | Trust tier | Confidence | Contribution | Usage constraints |
| --- | --- | --- | --- | --- |
| `skills/dot-agents/skills/code-review/SKILL.md` pre-update | canonical-local | high | Existing trigger phrases, severity labels, output style, local tool rules | Preserve local concise findings-only behavior |
| `https://google.github.io/eng-practices/review/reviewer/standard.html` | canonical-external | high | Review approval bar: improve code health, avoid perfectionism, facts over opinion | Adapt principles; do not copy large text |
| `https://google.github.io/eng-practices/review/reviewer/looking-for.html` | canonical-external | high | Design/functionality/complexity/tests/naming/comments/docs/every-line/context checklist | Convert to terse actionable workflow |
| `https://google.github.io/eng-practices/review/reviewer/comments.html` | canonical-external | high | Comment tone, explain why, severity labels, code-not-author framing | Keep output concise; avoid verbose mentoring by default |
| `https://owasp.org/www-project-code-review-guide/` | canonical-external | medium | Manual security review emphasis and vulnerability class coverage | OWASP page is broad/index-like; use only high-level security dimensions |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/code-review/SKILL.md` | secondary-external | high | Two-axis spec/standards review with parallel subagents | Adapt pattern, not exact wording |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/skills/thermos/SKILL.md` | secondary-external | high | Thermo orchestration: correctness/security + code-quality parallel passes, synthesize | Use only for deep/audit mode |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-review-subagent.md` | secondary-external | high | Correctness/security branch-audit scope and PR discussion handling | Adapt as pass definition, not as required subagent name |
| `https://raw.githubusercontent.com/sndrgrdn/pi/master/agents/thermo-nuclear-code-quality-review-subagent.md` | secondary-external | high | Maintainability/code-health branch-audit scope | Adapt as pass definition, not as required subagent name |
| `skill-writer` references: mode-selection, synthesis-path, authoring-path, description-optimization, evaluation-path, registration-validation, design-principles, skill-patterns, workflow-patterns, output-patterns, security/workflow examples | canonical-local | high | Required skill update workflow, provenance, trigger optimization, validation expectations | Apply only relevant paths; avoid overbuilding artifacts |

## Decisions and rationale

| Decision | Status | Evidence | Rationale |
| --- | --- | --- | --- |
| Keep `SKILL.md` self-contained | adopted | Local skill is one coherent review workflow; skill-patterns allow SKILL-only for under ~500 lines | Avoid unnecessary conditional reference loading during common reviews |
| Add synthesis provenance in `SOURCES.md` | adopted | skill-writer authoring/synthesis path | Material update used external sources; provenance should not bloat SKILL.md |
| Add deep review orchestration | adopted | thermos skill and agents | Enables “deep/audit/thermo” mode without changing default lightweight review |
| Add spec/standards modes | adopted | external code-review skill | Separates “matches requirement” from “code healthy” to avoid masking failures |
| Add stricter false-positive guardrails | adopted | security-review example + Google review guidance | Prevents noisy reviews and pattern-only security claims |
| Preserve findings-only default | adopted | existing local skill + concise preference | Keeps normal reviews high signal and short |
| Add broad OWASP category list but require reachable evidence | adopted | OWASP guide + security-review example | Improves coverage while controlling false positives |
| Add scripts for validation/eval | rejected | current workflow has no repeated machine-checkable transformation | Would add complexity without clear runtime value |

## Coverage matrix

| Dimension | Status | Notes |
| --- | --- | --- |
| Preconditions and target discovery | complete | Target/base/diff/PR discovery added |
| Ordered review flow | complete | Intent → central path → correctness → security → tests → perf → maintainability |
| Failure/uncertainty handling | complete | Unknown target, empty diff, weak evidence, incomplete coverage handled |
| Safety boundaries | complete | Reviewer not implementer, no code edits unless asked, preserve unrelated work |
| Vulnerability classes | complete | Auth, validation, injection, SSRF, traversal, XSS, sessions, secrets, uploads, dependencies |
| Exploit/evidence requirements | complete | Finding bar + false-positive guardrails require reachable path/sink/context |
| Remediation guidance | complete | Output format requires specific fix direction |
| False-positive controls | complete | Explicit do-not-report list and security evidence gates |
| Spec/standards fit | complete | Dedicated rules and optional two-axis output |
| Deep review orchestration | complete | Independent passes and synthesis rules included |
| Trigger precision | complete | Description covers review/code review/PR/diff/bugs/fixes/pre-merge/AI-generated code |

## Description optimization

Should trigger:

- “review this PR”
- “review my diff”
- “find bugs in these changes”
- “security review this patch”
- “do a deep audit of this branch”
- “check whether this matches the ticket”
- “give pasteable PR comments”
- “review this AI-generated code”
- “pre-merge review”

Should not trigger:

- “implement this feature”
- “debug this production issue”
- “write tests for this file”
- “commit my changes”
- “explain this codebase”
- “format this file”
- “create a PR description”

Edits made:

- Kept third-person description.
- Added “spec fit” and “AI-generated code” while retaining concrete review trigger phrases.
- Avoided provider-specific trigger terms.

## Lightweight evaluation

Representative prompts:

1. “Review my current diff.”
2. “Do a security review of this PR.”
3. “Deep audit this branch against main.”
4. “Does this match the ticket?”
5. “Give pasteable PR comments.”

Expected behavior after update:

- Prompt 1: unchanged concise findings-only default, with stronger target/context discovery.
- Prompt 2: improved security coverage and false-positive controls.
- Prompt 3: improved independent-pass orchestration and synthesis.
- Prompt 4: improved spec mismatch/scope-creep handling.
- Prompt 5: unchanged pasteable format with clearer severity intent.

Acceptance decision: accepted for lightweight qualitative update. No quantitative baseline run requested.

## Retrieval stopping rationale

Additional generic code-review blog posts are currently low-yield because high-trust sources already cover review standard, review checklist, comment style, security class coverage, spec/standards separation, and deep-review orchestration. Further retrieval should be targeted only if a future failure reveals a missing domain such as accessibility, mobile, infra, or language-specific security.

## Open gaps

- No language-specific review references are bundled; rely on repo context and framework docs when needed.
- No quantitative eval was run.
- Live mirror under `~/.agents/skills/code-review` was not found in this environment; repository source is updated only.
