alias lsn="\ls"
alias l="ls"
alias dir="ls"

alias untar="tar -xvf"
alias untargz="tar -xvzf"
alias untarbz2="tar -xvjf"
alias maketar="tar -cvf"
alias maketargz="tar -cvzf"
alias maketarbz2="tar -cvjf"

alias python="/usr/local/bin/python2"
alias blender="/usr/local/bin/blender"

alias viper="~/Development/Viper/viper.py"

#alias mount-do-personal="mkdir /Volumes/DO-Personal && sshfs -o allow_other,defer_permissions root@192.241.205.97:/ /Volumes/DO-Personal"

# Platform-specific
if [[ "$(uname)" == "Darwin" ]]; then
    # I like installing the GNU coreutils ls command, so use that if available.
    if [ -e /usr/local/bin/gls ]; then
        alias ls="/usr/local/bin/gls -FlahN --color=auto"
    else
        alias ls="ls -FGlah"
    fi
    if [ -e /usr/local/bin/gmake ]; then
        alias make=gmake
    fi
    # Take files out of quarantine:
    alias liberate="xattr -d com.apple.quarantine"
elif [[ "$(uname)" == "Linux" ]]; then
    alias ls="ls -Flah --color=auto"
fi

# ANTLR
if [ -z "${ANTLR_CLASSPATH}" ]; then
    alias antlr4="java -Xmx500M -cp '/usr/local/lib/antlr-4.7-complete.jar:${ANTLR_CLASSPATH}' org.antlr.v4.Tool"
    alias grun="java org.antlr.v4.gui.TestRig"
fi
