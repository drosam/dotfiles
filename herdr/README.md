# Herdr session

My usual Herdr session. Herdr has no layout file, so an agent recreates it from this description with the `herdr` CLI.

## Layout

All paths are under `~/Developer`. Every pane uses its workspace directory as cwd.

| # | Workspace | Directory | Tabs, in order |
| --- | --- | --- | --- |
| 1 | `develop` | `booqable/develop` | `server` (shell), `code` (`nvim`), `π` (Pi) |
| 2 | `dotfiles` | `dotfiles` | `code` (`nvim`), `π` (Pi) |
| 3 | `agents` | `agents` | `code` (`nvim`), `π` (Pi) |
| 4 | `pi-config` | `pi-config` | `code` (`nvim`), `π` (Pi) |
| 5 | `booqable` | `booqable` | `1` (shell) |

- One pane per tab.
- `server` and `1` are plain shells; I start the dev server myself.
- `booqable` is the bare repo root, the parent of every Booqable worktree.
- Pi tabs run the Pi agent through Herdr, named `<workspace>-pi` (for example `dotfiles-pi`).

## Recreate it (instructions for an agent)

Follow the Herdr skill (`herdr --skill`) and the installed CLI help. Rules:

- Run only inside Herdr (`HERDR_ENV=1`).
- Run `herdr workspace list` and `herdr tab list` first. Skip workspaces and tabs that already exist by label; only add what's missing. Never close or rename existing workspaces, tabs or panes.
- Use `--no-focus` everywhere, and read every ID from the JSON responses instead of guessing.

For each missing workspace, in table order:

1. `herdr workspace create --cwd <dir> --label <workspace> --no-focus`. Its first tab is `.result.tab`, with pane `.result.root_pane`.
2. Rename that first tab to the first tab label: `herdr tab rename <tab_id> <label>`.
3. Create each remaining tab: `herdr tab create --workspace <workspace_id> --cwd <dir> --label <label> --no-focus`.
4. Start each tab's program in its pane:
   - `nvim`: `herdr pane run <pane_id> nvim`
   - Pi: `herdr agent start <workspace>-pi --kind pi --pane <pane_id>`
   - shell: nothing

Finish with `herdr pane list` and report each workspace's tabs and running programs.
