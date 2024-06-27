
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
    printf "\n $txtred%s: $bldpur%s $lhtcyan%s $blue%s\n$txtrst" "$HOST_NAME" "$dir" "[$(date +%T)]" "$(prompt_vcs)" 
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


