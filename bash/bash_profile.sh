if [ "${BASH_VERSINFO}" -ge 4 ]; then
    shopt -s globstar
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

###############################################################################
# added for GHC/Cabal
export PATH="$HOME/Library/Haskell/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# added for Ocaml
. /Users/pdarragh/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
