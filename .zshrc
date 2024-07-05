# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  rbenv
  nvm
  gh
  zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#878ede"

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'
alias ls='ls -G'

#Satchel aliases
alias_with_show() {
    alias $1="echo $2; $2"
}

alias_with_show 'run-s1-frontend' 'ember s --port=4200 --proxy http://0.0.0.0:6050 --live-reload-port 49161'
alias_with_show 'run-s1-admin-frontend' 'ember s --port=4201 --proxy http://0.0.0.0:6051 --live-reload-port 49160'
alias_with_show 'run-s1-api' "DEBUG_QUERIES=true PORT=6050 bundle exec puma -C '/Users/davidrosa/Developer/show-app/backend/smhw-api/config/puma/minimal.rb'"
alias_with_show 'run-s1-admin-api' "DEBUG_QUERIES=true PORT=6051 bundle exec puma -C '/Users/davidrosa/Developer/show-app/backend/smhw-admin-api/config/puma/minimal.rb'"

alias_with_show 'ssh-s1-qa' 'ssh railsconsolereadonly@bastionqa.satchel.cloud'
alias_with_show 'ssh-s1-qa-rw' 'ssh railsconsolereadwrite@bastionqa.satchel.cloud'
alias_with_show 'ssh-s1-prod' 'ssh railsconsolereadonly@bastionprod.satchel.cloud'
alias_with_show 'ssh-s1-prod-rw' 'ssh railsconsolereadwrite@bastionprod.satchel.cloud'

alias_with_show 'ssh-prod' 'ssh pulse-ro@bastionprod.satchel.cloud'
alias_with_show 'ssh-prod-rw' 'ssh pulse-rw@bastionprod.satchel.cloud'
alias_with_show 'ssh-prod-uk' 'ssh pulse-uk-ro@bastionprod.satchel.cloud'
alias_with_show 'ssh-prod-uk-rw' 'ssh pulse-uk-rw@bastionprod.satchel.cloud'
alias_with_show 'ssh-prod-ca' 'ssh pulse-ca-ro@bastionprod.satchel.cloud'
alias_with_show 'ssh-prod-ca-rw' 'ssh pulse-ca-rw@bastionprod.satchel.cloud'
alias_with_show 'ssh-qa' 'ssh pulse-ro@bastionqa.satchel.cloud'
alias_with_show 'ssh-qa-rw' 'ssh pulse-rw@bastionqa.satchel.cloud'
alias_with_show 'ssh-qa-uk' 'ssh pulse-uk-ro@bastionqa.satchel.cloud'
alias_with_show 'ssh-qa-uk-rw' 'ssh pulse-uk-rw@bastionqa.satchel.cloud'
alias_with_show 'ssh-qa-ca' 'ssh pulse-ca-ro@bastionqa.satchel.cloud'
alias_with_show 'ssh-qa-ca-rw' 'ssh pulse-ca-rw@bastionqa.satchel.cloud'

alias_with_show 'run-pulse-front-end' 'ember s --proxy=http://localhost:3000'
alias_with_show 'run-pulse-api' 'foreman start -f Procfile.dev '

# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin/:$PATH"
export EDITOR='nvim'
PROMPT='%F{blue}%n %F{green}%~%f %F{yellow}$(git_current_branch) %F{green}$ %f'