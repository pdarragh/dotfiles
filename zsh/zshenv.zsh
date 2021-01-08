########
# PATH

# Base path.
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
# Path for Haskell/GHC.
export PATH="$HOME/.local/bin:$PATH"
# Path for Rust.
export PATH="$HOME/.cargo/bin:$PATH"
# Path for TeX.
export PATH="/Library/TeX/texbin:$PATH"
# Path for Racket installed packages.
export PATH="/Applications/Racket v7.3/share/bin:$HOME/Library/Racket/7.3/bin:$PATH"
# Path for Ruby.
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"

########
# Extra GHC environment stuff.

if [ -f ~/.ghcup/env ]; then
    source ~/.ghcup/env
fi
