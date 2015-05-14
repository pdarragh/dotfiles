alias lsn           "\ls"
alias dir           "ls"

alias untar         "tar -xvf"
alias untargz       "tar -xzvf"
alias untarbz2      "tar -xjvf"

# Platform-specific
if ( `uname` == "Darwin" ) then
    alias ls        "ls -FGlah"
else if ( `uname` == "Linux" ) then
    alias ls        "ls -Flah --color=auto"
endif
