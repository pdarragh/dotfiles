alias lsn="\ls"
alias dir="ls"

alias untar="tar -xvf"
alias untargz="tar -xzvf"
alias untarbz2="tar -xjvf"

# Platform-specific
if [[ "$(uname)" == "Darwin" ]]; then
    # I like installing the GNU coreutils ls command, so use that if available.
    if [ -e /usr/local/bin/gls ]; then
        alias ls="/usr/local/bin/gls -Flah --color=auto"
    else
        alias ls="ls -FGlah"
    fi
    alias gateway="route -n get default | grep gateway | sed 's~[^0-9]*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]\)$~\1~'"
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls="ls -Flah --color=auto"
fi
