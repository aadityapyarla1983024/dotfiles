
shopt -s autocd
shopt -s histappend

export PATH=$PATH:$HOME/bin

export HISTSIZE=5000
export HISTFILESIZE=10000

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

HOST_NAME=$USER

TODAY=$(date +"Today is %A, %d of %B")
echo $TODAY

curl -H "Accept-Language: en" wttr.in/?0FQ
prompt_git() {
    $(git rev-parse --is-inside-git-dir 2>/dev/null ) \
        && return 1
    $(git rev-parse --is-inside-work-tree 2>/dev/null ) \
        || return 1
    git status &>/dev/null
    branch=$(git symbolic-ref --quiet HEAD 2>/dev/null ) \
        || branch=$(git rev-parse --short HEAD 2>/dev/null ) \
        || branch='unknown'
    branch=${branch##*/}
    git diff --quiet --ignore-submodules --cached \
        || state=${state}+
    git diff-files --quiet --ignore-submodules -- \
        || state=${state}!
    $(git rev-parse --verify refs/stash &>/dev/null ) \
        && state=${state}^
    [ -n "$(git ls-files --others --exclude-standard )" ] \
        && state=${state}?
    printf "@${branch:-unknown}(${state})"
}

txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
bldgrn='\e[1;32m' # Bold Green
bldpur='\e[1;35m' # Bold Purple
txtrst='\e[0m'    # Text Reset
lhtcyan='\x1b[38;5;209m'
blue='\x1b[38;5;93m'
EMOJI="😎"

print_before_the_prompt () {
    dir=$PWD
    home=$HOME
    dir=${dir/"$HOME"/"~"}
    printf "\n $txtred%s: $bldpur%s $lhtcyan%s $blue%s\n$txtrst" "$HOST_NAME" "$dir" "[$(date +%T)]" "$(prompt_git)" 
}
SPACE=' '
PROMPT_COMMAND=print_before_the_prompt
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PS1="${SPACE}$EMOJI >${SPACE}"

fortune | cowsay -f tux

function mkcd()
{
	mkdir $1 && cd $1
}

# -------
# Aliases
# -------
alias l="ls -h" # List files in current directory
alias ll="ls -ahl" # List all files in current directory in long list format
alias o="open ." # Open the current directory in Finder

# ----------------------
# Git Aliases
# ----------------------
alias gaa='git add .'
alias gcm='git commit -m'
alias gpsh='git push'
alias gss='git status -s'
alias gs='echo ""; echo "*********************************************"; echo -e "   DO NOT FORGET TO PULL BEFORE COMMITTING"; echo "*********************************************"; echo ""; git status'
