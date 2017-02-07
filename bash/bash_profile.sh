if [ "${BASH_VERSINFO}" -ge 4 ]; then
    shopt -s globstar
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

###############################################################################
# added by Anaconda3 4.2.0 installer
export PATH="/Users/pdarragh/anaconda/bin:$PATH"

# added for GHC/Cabal
export PATH="$HOME/Library/Haskell/bin:$PATH"

