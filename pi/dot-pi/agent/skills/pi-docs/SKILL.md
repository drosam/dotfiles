---
name: pi-docs
description: Pi coding agent documentation lookup. Use when asked about pi itself, SDK, extensions, themes, skills, prompt templates, TUI components, keybindings, custom providers, adding models, packages, settings, sessions, RPC/JSON mode, providers, usage, shell aliases, terminal setup, or customizing pi.
disable-model-invocation: true
---

# Pi Docs

Use this skill for pi-specific questions and implementation work.

## Resolve Pi Root

Prefer the installed package root:

```bash
PI_ROOT="$(pnpm root -g 2>/dev/null || npm root -g)/@earendil-works/pi-coding-agent"
```

If that fails on this machine, use:

```bash
PI_ROOT="/Users/david/.local/share/mise/installs/node/24.14.1/lib/node_modules/@earendil-works/pi-coding-agent"
```

## Read Docs by Topic

Read the relevant docs completely before answering or editing pi config.
Follow cross-references mentioned by each doc.

| Topic | Read |
| --- | --- |
| Overview | `README.md` |
| Extensions | `docs/extensions.md`, then `examples/extensions/` |
| Themes | `docs/themes.md` |
| Skills | `docs/skills.md` |
| Prompt templates | `docs/prompt-templates.md` |
| TUI/components | `docs/tui.md` |
| Keybindings | `docs/keybindings.md` |
| SDK/embedding | `docs/sdk.md`, then `examples/sdk/` |
| Custom providers | `docs/custom-provider.md` |
| Adding models | `docs/models.md` |
| Packages | `docs/packages.md` |
| Sessions | `docs/sessions.md`, `docs/session-format.md` |
| Settings | `docs/settings.md` |
| Compaction | `docs/compaction.md` |
| JSON/print mode | `docs/json.md` |
| RPC | `docs/rpc.md` |
| Providers | `docs/providers.md` |
| Usage | `docs/usage.md` |
| Shell aliases | `docs/shell-aliases.md` |
| Terminal setup | `docs/terminal-setup.md` |
| Quickstart | `docs/quickstart.md` |

## Local Config

This dotfiles repo stores pi config under:

```text
pi/dot-pi/agent/
```

Live config is usually symlinked under:

```text
~/.pi/agent/
```

Useful local paths:

| Area | Path |
| --- | --- |
| Settings | `pi/dot-pi/agent/settings.json` |
| Extensions | `pi/dot-pi/agent/extensions/` |
| Themes | `pi/dot-pi/agent/themes/` |
| Agents | `pi/dot-pi/agent/agents/` |
| Skills | `pi/dot-pi/agent/skills/` |

## Implementation Rules

- Read before changing.
- Prefer extension APIs over guessing JSON settings.
- GitHub CLI (`gh`) is available and acceptable to use when useful.
- For extension examples in this repo, match local import convention: `@mariozechner/pi-coding-agent` and `@mariozechner/pi-tui`.
- Use `/reload` after extension/skill/theme changes in interactive pi.
- Verify with a cheap command when possible, e.g. `pi --list-models <model> --extension <path> --offline`.
