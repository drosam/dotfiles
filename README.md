Installation common
=============

ZSH:
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

Installation MacOS
==================

```
brew install --cask font-meslo-lg-nerd-font
brew install curl git git-delta gnu-sed alacritty neovim tmux tmuxinator jesseduffield/lazygit/lazygit ripgrep koekeishiya/formulae/skhd stow starship ghostty fzf gnupg pass htop openssl

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.tmux/plugins/catppuccin/tmux

skhd --start-service
./bin/dot-bin/install-dotfiles

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins

```

