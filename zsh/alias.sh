alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -al'
alias mux='tmuxinator'

alias pm='python manage.py'
alias sp='python manage.py shell_plus'
alias mkmg='python manage.py makemigrations'
alias mg='python manage.py migrate'
alias gp='git push'
alias rs='python manage.py runserver'
alias rs2='python manage.py runserver 127.0.0.2'
alias ga!='git commit --amend --no-edit --date now'

cheat() { curl cheat.sh/"$1" }
cda() { conda activate "$@" }
cdd() { conda deactivate "$@" }
cdc() { conda create --name "$@" python=3.5 pip }
cdi() { conda info --envs "$@" }
ca() { pygmentize -g "$@" }
grepf() { grep -rnw ./ -e "$@"}
amendnow() { GIT_COMMITTER_DATE="$(date +%d/%m/%Y' '%H:%M:%S)" git commit --amend --no-edit --date "$(date +%d/%m/%Y' '%H:%M:%S)" }
continous-running() { while true; do inotifywait $1 -r -e close_write && ${@:2}; done }

make_venv() {
    echo $(basename $(pwd) | awk '{print "conda activate "$1}') > $(pwd | awk '{print $1"/.autoenv.zsh"}')
    echo $(basename $(pwd) | awk '{print "conda deactivate "$1}') > $(pwd | awk '{print $1"/.autoenv_leave.zsh"}')
}
