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

export PATH=$HOME/Documents/Arcanite/git_ci_runner:$PATH
export NB_MINIONS=4
export VISUAL=nvim
export EDITOR=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)

source ~/.dotfiles/lib/zsh-autoenv/autoenv.zsh
