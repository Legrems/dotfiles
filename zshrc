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

export GPG_TTY=$(tty)

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select

nv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}
