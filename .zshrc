export ZSH="$HOME/.oh-my-zsh"

function mkt(){
    dirmkt=$1
    mkdir {$dirmkt,$dirmkt/nmap,$dirmkt/content,$dirmkt/exploits,$dirmkt/scripts}
}

function settarget(){
    ip_address=$1
    machine_name=$2
    echo "$ip_address $machine_name" > $HOME/.xmonad/Target.txt
}


ZSH_THEME="robbyrussell"

plugins=(git)


alias cat="bat "
alias ct="cat "
alias ls="lsd "
alias ll="lsd -la"

source $ZSH/oh-my-zsh.sh

export PS1='$(echo -e "Yes, My Master?> ")'
