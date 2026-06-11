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
- In Docker/dev containers the script skips GUI-only config: Alacritty, Ghostty, and skhd.
- Stowed config includes shell, git/delta, Neovim, tmux/tmuxinator, Starship, Lazygit, opencode, pi agent config, skills, and `~/bin`.

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
