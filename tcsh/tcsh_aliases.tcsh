alias lsn           "\ls"
alias dir           "ls"
alias ldr           "ls -aFsG"

alias untar         "tar -xvf"
alias untargz       "tar -xzvf"
alias untarbz2      "tar -xjvf"

alias md            "makedir"

# Platform-specific
if ( `uname` == "Darwin" ) then
    alias ls        "ls -FGla"
else if ( `uname` == "Linux" ) then
    alias ls        "ls -Fla --color=auto"
endif
