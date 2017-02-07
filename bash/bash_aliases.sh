alias lsn="\ls"
alias l="ls"
alias dir="ls"

alias untar="tar -xvf"
alias untargz="tar -xvzf"
alias untarbz2="tar -xvjf"
alias maketar="tar -cvf"
alias maketargz="tar -cvzf"
alias maketarbz2="tar -cvjf"

alias mount-do-personal="mkdir /Volumes/DO-Personal && sshfs -o allow_other,defer_permissions root@192.241.205.97:/ /Volumes/DO-Personal"

# Platform-specific
if [[ "$(uname)" == "Darwin" ]]; then
    # I like installing the GNU coreutils ls command, so use that if available.
    if [ -e /usr/local/bin/gls ]; then
        alias ls="/usr/local/bin/gls -FlahN --color=auto"
    else
        alias ls="ls -FGlah"
    fi
    alias gateway="route -n get default | grep gateway | sed 's~[^0-9]*\([0-9]*\.[0-9]*\.[0-9]*\.[0-9]\)$~\1~'"
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls="ls -Flah --color=auto"
fi
