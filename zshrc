# Generic defaults
source ~/.zsh/generic.sh

# History
source ~/.zsh/history.sh

# Bind keys
source ~/.zsh/keys.sh

# Alias
source ~/.zsh/alias.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/home/legrems/Documents/mattermost:$PATH"
export PATH="/home/legrems/.cargo/bin:$PATH"

if [ -f '/home/legrems/.cdwe.zsh' ]; then . '/home/legrems/.cdwe.zsh'; fi

eval "$(zoxide init zsh | sed -e 's/\\builtin cd/cdwe/g')"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export KEYTIMEOUT=1

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
