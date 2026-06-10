# Registration and Validation

Apply repository registration and quality checks before completion.

## Registration checklist

1. Inspect the workspace and identify the canonical skill root before editing skill files.
2. Create/update `<skill-root>/SKILL.md` and any bundled `references/`, `scripts/`, or `assets/` beneath that root.
3. Update live symlinks only when the skill should be exposed to that runtime.
4. Do not add README tables or provider settings unless this repository actually uses them for skill discovery.

For this dotfiles repository today:

- general skill sources live under `skills/dot-agents/skills/`
- pi-specific skill sources live under `pi/dot-pi/agent/skills/`
- live agent skills usually mirror general skills under `~/.agents/skills/`
- live Claude skills usually mirror the subset exposed to Claude under `~/.claude/skills/`
- live Pi skills usually mirror pi-specific skills under `~/.pi/agent/skills/`
- symlink targets must point back to canonical repo paths, not to another live mirror

## Validation checklist

1. Run:

```bash
uv run skills/dot-agents/skills/skill-writer/scripts/quick_validate.py <path/to/skill-directory> --strict-depth
```

Run from the repository root when possible. If running from another directory, convert both paths to relative paths from that directory instead of introducing absolute or host-specific paths into skill docs.

2. Confirm for authoring/generator skills:
- transformed examples exist in references (happy-path, secure/robust, anti-pattern+fix)
- synthesis depth gates are satisfied
- selected example profile requirements are satisfied and reported

3. Confirm for integration/documentation skills:
- `references/api-surface.md` exists
- `references/common-use-cases.md` exists with sufficient depth
- `references/troubleshooting-workarounds.md` exists with sufficient depth
- `SKILL.md` and `references/*.md` avoid host-specific absolute filesystem paths

4. Confirm portability for skills that are expected to be portable by default:
- bundled file references use skill-root-relative paths such as `references/...`, `scripts/...`, or `assets/...`
- provider-specific path variables (for example `${CLAUDE_SKILL_ROOT}`) are absent unless the skill is intentionally provider-specific
- provider-specific behavior, if any, is labeled as compatibility guidance rather than the primary workflow

5. Confirm evaluation outputs as applicable:
- lightweight qualitative summary (recommended default)
- qualitative depth rubric status for API/workaround/use-case/gap handling (recommended for integration/documentation and skill-authoring)
- deeper eval or quantitative summary only if user requested benchmark mode or risk warrants it

6. Reject shallow handoffs that omit required artifacts.

## Required output

- Registration changes summary
- Validator output
- Evaluation summary status
- Any residual risks or open gaps
