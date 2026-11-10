Installation common
=============

Prereqs:
- Clone this repo to `~/Developer/dotfiles` or set `DOTFILES_DIR=/path/to/dotfiles`.
- Install GNU Stow. The install script uses `stow --dotfiles` to symlink config into `$HOME`.

ZSH:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Install dotfiles:
```
./bin/dot-bin/install-dotfiles
```

Notes:
- The script removes `~/.zshrc` so Stow can replace the oh-my-zsh generated file with the repo-managed symlink.
- In Docker/dev containers the script skips GUI-only config: Alacritty, Ghostty, skhd, and Herdr.
- Stowed config includes shell, git/delta, Neovim, tmux/tmuxinator, Herdr, Starship, Lazygit, pi agent config, Claude Code settings/scripts, skills, and `~/bin`.
- Pi work-artifact layout, spec/plan links, and cross-session selection: [Pi guide](pi/README.md).

Installation MacOS
==================

```
brew install --cask font-meslo-lg-nerd-font
brew install curl git git-delta gnu-sed alacritty neovim tmux tmuxinator jesseduffield/lazygit/lazygit ripgrep koekeishiya/formulae/skhd stow starship ghostty fzf gnupg pass htop openssl

mkdir -p ~/.tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin/tmux

skhd --start-service
./bin/dot-bin/install-dotfiles

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
```

Herdr (agent terminal multiplexer):
```
brew install herdr
./bin/dot-bin/install-dotfiles
herdr integration install pi
herdr integration status
herdr plugin link ~/.config/herdr-plugins/lastfocus
```

Notes:
- Run `install-dotfiles` before the first `herdr` launch. Herdr onboarding writes `~/.config/herdr/config.toml`, which blocks the stow link; remove that file and rerun the script if it already exists.
- The Pi integration writes `herdr-agent-state.ts` into `pi/dot-pi/agent/extensions/` through the stowed symlink.
- Apply config edits to a running server with `herdr server reload-config`.
- `lastfocus` plugin (`herdr/dot-config/herdr-plugins/lastfocus/`): tmux-style toggles. `prefix+tab` jumps to the last tab in the current workspace, `prefix+shift+tab` to the last workspace. These keys replace the default `cycle_pane_next`/`cycle_pane_previous`. Event hooks on `tab.focused`/`workspace.focused` record current/previous ids in `~/.local/state/herdr/plugins/lastfocus/`; requires `jq`. Debug with `herdr plugin log list --plugin lastfocus`.
- Local plugins live in `~/.config/herdr-plugins/`, not `~/.config/herdr/plugins/`. Herdr treats `~/.config/herdr/plugins/<id>` as a legacy config location and copies its contents into `~/.config/herdr/plugins/config/<id>` on link.

Booqable worktrees:
```bash
new-booqable-worktree my-task
# Omit the name to prompt. Prints the checkout path; reuses existing worktrees.

# Create/setup the checkout, then open it in Herdr:
worktree=$(new-booqable-worktree my-task) &&
  herdr worktree open --cwd "$HOME/Developer/booqable/develop" --path "$worktree" --focus
```

The tmux `booqable-worktree` action uses the same helper, then creates its usual windows.
