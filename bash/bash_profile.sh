if [ "${BASH_VERSINFO}" -ge 4 ]; then
    shopt -s globstar
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.ghcup/env ]; then
    source ~/.ghcup/env
fi

###############################################################################
# added for GHC
#export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# added for Ocaml
. /Users/pdarragh/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# added for Maven
export PATH="$HOME/.maven/bin:$PATH"

# added for Z3
export PATH="$HOME/.z3/bin:$PATH"

# added for Apache Ant
export PATH="$HOME/.ant/bin:$PATH"

# added for Homebrew Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"

# added for better Java support
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_192.jdk/Contents/Home"

# added for Rust
export PATH="$HOME/.cargo/bin:$PATH"

# added for ncurses
export PATH="/usr/local/opt/ncurses/bin:$PATH"

# added for Racket
export PATH="/Applications/Racket v7.3/share/bin:$HOME/Library/Racket/7.3/bin:$PATH"

# added for gcc
#export PATH="/usr/local/opt/gcc/bin:$PATH"

# added for LaTex
export PATH="/Library/TeX/texbin:$PATH"
