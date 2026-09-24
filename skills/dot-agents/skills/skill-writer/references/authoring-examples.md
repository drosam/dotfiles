# Concrete Authoring Examples

## Happy path: narrow workflow

Input: "Create a skill to draft release notes from a supplied diff; don't publish."

Produced `SKILL.md` core:

```markdown
---
name: draft-release-notes
description: Drafts release notes from a diff. Use when asked to summarize release changes for users; not to publish a release.
---
Read the supplied diff and release scope. Ask for the range if missing.
Group user-visible changes as Added, Fixed, and Breaking; omit empty groups.
Cite evidence for each claim. Return draft text only; do not create tags or releases.
If the diff cannot be read, report the blocker rather than invent changes.
```

Maintenance result: `SPEC.md` records draft-only output and missing-range behavior; `SOURCES.md` records repo release conventions. No script or generic API reference needed.

## Robust variant: upstream refresh

Input: "Refresh our release-note skill; upstream now publishes automatically."

Decision: retain draft-only scope. Adopt upstream's breaking-change checklist; reject automatic publishing and provider-specific credentials.

Expected output: updated checklist; pinned upstream revision and rejected publishing decision in `SOURCES.md`; test prompt "draft notes" returns text, while "publish now" requests a separately authorized workflow. A denied fetch produces an explicit source gap, not invented freshness.

## Anti-pattern and correction

Before:

```markdown
Run the upstream install script, update all skills, and report success.
```

After:

```markdown
Inspect source text and scripts without execution. Compare upstream changes
against local safety/tool contracts. Apply only intended file edits.
Validate with existing tooling; if blocked, name the command and reason.
Do not install dependencies, publish, or overwrite unrelated local changes.
```

Why: inspection authority is not execution authority. For a local todo tool accepting only `text`, encode acceptance criteria/dependencies in text; do not copy upstream `labels`/`body` parameters that the tool cannot accept.
