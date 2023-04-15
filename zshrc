# Generic defaults
source ~/.zsh/generic.sh

# History
source ~/.zsh/history.sh

# Bind keys
source ~/.zsh/keys.sh

# Alias
source ~/.zsh/alias.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/legrems/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/legrems/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/legrems/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/legrems/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# PM functions
source /home/legrems/.pm/pm.zsh
alias pma="pm add"
alias pmg="pm go"
alias pmrm="pm remove"
alias pml="pm list"
# end PM
