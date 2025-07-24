alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -al'
alias mux='tmuxinator'
alias i="ipython"

alias pm='python manage.py'
alias pmt='clear && pm test'
alias sp='python manage.py shell_plus'
alias mkmg='python manage.py makemigrations'
alias pms='pm showmigrations'
alias mg='python manage.py migrate'
alias gp='git push'
alias ga!='git commit --amend --no-edit --date now'

alias n='cd . && nvim -S'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias fm='vifm .'
alias git-testpush="git checkout master && git pull && git checkout testing && git pull && git merge master && git push"
alias git-prodpush="git checkout master && git pull && git checkout prod && git pull && git merge master && git push"
alias git-intpush="git checkout master && git pull && git checkout abahost-int && git pull && git merge master && git push"
alias git-stackpush="git checkout master && git pull && git checkout deep && git pull && git merge master && git push && git checkout pay && git pull && git merge master && git push && git checkout services && git pull && git merge master && git push"

# alias megapush="git checkout master && git pull && git checkout deep && git pull && git merge master && git push && git push deep && git checkout pay && git pull && git merge master && git push && git push pay && git checkout services && git pull && git merge master && git push && git push abaservices" # The real megapush

poetry-version() {
    poetry version $1 &&
    version=$(poetry version | cut -d' ' -f2) &&
    git add . && git commit -m "chore(release): $version"
}

poetry-version-release() {
    poetry-version $1 &&
    version=$(poetry version | cut -d' ' -f2) &&
    echo "Creating tag $version" &&
    git tag -a $version -m "Release $version"
}

rs() {python manage.py runserver 127.0.0."$1":"$2"}

cheat() { curl cheat.sh/"$1" }
cda() { conda activate "$@" }
cdd() { conda deactivate "$@" }
cdc() { conda create --name "$@" python=3.9 pip ipython memory_profiler psycopg2 black isort poetry }
cdi() { conda info --envs "$@" }
ca() { pygmentize -g "$@" }
grepf() { grep -rnw ./ -e "$@"}
amendnow() { GIT_COMMITTER_DATE="$(date +%d/%m/%Y' '%H:%M:%S)" git commit --amend --no-edit --date "$(date +%d/%m/%Y' '%H:%M:%S)" }
continous-running() { while true; do inotifywait $1 -r -e close_write && ${@:2}; done }
f() { find . -name "*$1*"; }

# branch-version() {for var in "$@" do curl "https://main.arcastore.ch/arcanite-gestion/version/arcanite-gestion.$var" done}

tar-create() {tar cfv $@}
tar-list() {tar -tvf $@}
tar-extract() {tar xfv $@}
us-layout() {setxkbmap us }
usint-layout() {setxkbmap us -variant intl }

make_venv() {
    echo $(basename $(pwd) | awk '{print "conda activate "$1}') > $(pwd | awk '{print $1"/.autoenv.zsh"}')
    echo $(basename $(pwd) | awk '{print "conda deactivate "}') > $(pwd | awk '{print $1"/.autoenv_leave.zsh"}')
}

alias activate_venv_gestion="cda arcanite-gestion39 && cd /home/legrems/Documents/Arcanite/arcanite-gestion/arcanite_gestion/"

alias cls="ls -lha --color=always -F --group-directories-first |awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"
alias lcs="ls -lhaS --color=always -F --group-directories-first |awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"

alias open_keepass="keepassxc-cli open ~/KeepassXC/main.kdbx --key-file ~/KeepassXC/main.key"

kpxc() {
    cat ~/.pw.gpg | gpg -d | keepassxc-cli $1 ~/KeepassXC/main.kdbx --key-file ~/KeepassXC/main.key ${@:2}
}


#export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
