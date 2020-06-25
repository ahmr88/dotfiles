#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"

# Default programs:
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

export PATH="~/.npm-global/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"
export PATH="~/.ghcup/bin:$PATH"
export PATH="~/driver/:$PATH"
export PATH="~/.cabal/bin:$PATH"
export PATH="$PATH:~/npm"
export PATH="/usr/local/opt/ruby/bin:$PATH"

alias vim="nvim"

export VISUAL=nvim


PS1='[\u@\h \W]\$ '

alias ls="exa"

alias lt='ls --tree --level=2 -G'
alias la='ls -aF'
alias l='ls -GF'
alias ll='ls -alF'

alias cat='bat'
export BAT_THEME='OneHalfDark'

alias grep='grep --color=auto'

alias rm='rm -i'
alias mv='mv -i'

export HISTCONTROL=ignoredups


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# FZF
source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash

bind '"\C-g":"cd_with_fzf\n"'
bind '"\C-t":"open_with_fzf\n"'
bind '"\C-v":"vim\n"'
# bind '"\C-I":"install_with_fzf\n"'


export FZF_DEFAULT_COMMAND='fd'


cd_with_fzf() {
  cd $HOME && cd "$(fd -t d --exclude "anaconda3" | fzf --preview="exa --tree --level=1 -G {}")" && echo $PWD && exa -alF
}

open_with_fzf() {
  fd -t f --exclude "anaconda3" | fzf -m | tr '\n' '\0' | xargs -0 xdg-open
}

installf() {
  pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
}

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
