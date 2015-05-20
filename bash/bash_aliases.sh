alias lsn="\ls"
alias dir="ls"

alias untar="tar -xvf"
alias untargz="tar -xzvf"
alias untarbz2="tar -xjvf"

# Platform-specific
if [[ "$(uname)" == "Darwin" ]]; then
    alias ls="ls -FGlah"
    alias gateway="route -n get default | grep gateway | sed 's~[^0-9]*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]\)$~\1~'"
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls="ls -Flah --color=auto"
fi