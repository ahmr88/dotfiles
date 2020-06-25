export PATH="~/.npm-global/bin:$PATH"
export PATH="./node_modules/.bin/:$PATH"
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/Users/amirhosseinmeyssamirad/.ghcup/bin:$PATH"
export PATH="~/driver/:$PATH"

export DENO_INSTALL="/Users/amirhosseinmeyssamirad/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

alias vim="nvim"

export VISUAL=nvim
export EDITOR="$VISUAL"

## npm
export PATH="$PATH:~/npm"
export PATH="/Users/amirhosseinmeyssamirad/.gem/ruby/2.3.0/bin:$PATH"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/amirhosseinmeyssamirad/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/amirhosseinmeyssamirad/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/amirhosseinmeyssamirad/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/amirhosseinmeyssamirad/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PATH="/usr/local/opt/ruby/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# FZF
bind '"\C-f":"cd_with_fzf\n"'
bind '"\C-t":"open_with_fzf\n"'
bind '"\C-v":"vim\n"'


export FZF_DEFAULT_COMMAND='fd'


cd_with_fzf() {
  cd $HOME && cd "$(fd -t d --exclude "anaconda3" | fzf --preview="exa --tree --level=1 -G {}")" && echo $PWD && exa -alF
}

open_with_fzf() {
  fd -t f --exclude "anaconda3" | fzf -m | tr '\n' '\0' | xargs -0 open
}
