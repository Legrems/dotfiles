# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

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
#<<< conda initialize <<<

export PATH=$HOME/custom_commands:$PATH
export NB_MINIONS=4
export VAGRANT_TYPE='abacus-abahost'
export VISUAL=nvim
export EDITOR=nvim
export AUTOENV_ENV_FILENAME='.autoenv.zsh'
export AUTOENV_ENV_LEAVE_FILENAME='.autoenv_leave.zsh'
export AUTOENV_ENABLE_LEAVE='yes'

# To remove the conda env on ps1, run:
# conda config --set changeps1 False

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)

source ~/.autoenv/activate.sh
