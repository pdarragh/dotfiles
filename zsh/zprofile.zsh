export HOMEBREW_BASE="/opt/homebrew"
export HOMEBREW_OPT="$HOMEBREW_BASE/opt"
export HOMEBREW_LIB="$HOMEBREW_BASE/lib"
export RUBY_BASE="$HOMEBREW_BASE/opt/ruby"
export RUBY_EXEC="$RUBY_BASE/bin/ruby"
export GEM_EXEC="$RUBY_BASE/bin/gem"
export GEM_DIR="$($GEM_EXEC env gemdir)/bin"
export SMLNJ_BASE="/usr/local/smlnj"

if command -v xcrun &> /dev/null
then export SDK_PATH="$(xcrun --show-sdk-path)"
fi

sources=(
    $HOME/.opam/opam-init/init.zsh
)

for src in $sources; do [[ ! -r $src ]] || source $src; done

path_extensions=(
    $HOME/.cargo/bin
    $HOME/.ghcup/bin
    $HOMEBREW_BASE/bin
    $HOMEBREW_BASE/sbin
    $HOMEBREW_OPT/llvm/bin
    $HOMEBREW_OPT/openssl@3/bin
    $HOMEBREW_OPT/sqlite/bin
    $RUBY_BASE/bin
    $GEM_DIR
    $SMLNJ_BASE/bin
    $SDK_PATH/usr/bin
)

for extension in $path_extensions; do { [[ ! -d $extension ]] || export PATH="$extension:$PATH" }; done

linker_paths=(
    $HOMEBREW_OPT/apr/lib
    $HOMEBREW_OPT/apr-util/lib
    $HOMEBREW_OPT/bzip2/lib
    $HOMEBREW_OPT/icu4c/lib
    $HOMEBREW_OPT/libffi/lib
    $HOMEBREW_OPT/llvm/lib
    $HOMEBREW_OPT/ncurses/lib
    $HOMEBREW_OPT/openssl@1.1/lib
    $HOMEBREW_OPT/openssl@3/lib
    $HOMEBREW_OPT/readline/lib
    $HOMEBREW_OPT/zlib/lib
    $RUBY_BASE/lib
    $SMLNJ_BASE/bin
    $SDK_PATH/usr/lib
)

for linker_path in $linker_paths; do { [[ ! -d $linker_path ]] || export LDFLAGS="-L$linker_path $LDFLAGS" }; done

libs=(
    $HOMEBREW_OPT/apr/include
    $HOMEBREW_OPT/apr-util/include
    $HOMEBREW_OPT/bzip2/include
    $HOMEBREW_OPT/icu4c/include
    $HOMEBREW_OPT/libffi/include
    $HOMEBREW_OPT/llvm/include
    $HOMEBREW_OPT/ncurses/include
    $HOMEBREW_OPT/openssl@1.1/include
    $HOMEBREW_OPT/openssl@3/include
    $HOMEBREW_OPT/readline/include
    $HOMEBREW_OPT/zlib/include
    $RUBY_BASE/include
    $SDK_PATH/usr/include
)

for lib in $libs; do { [[ ! -d $lib ]] || { export CPPFLAGS="-I$lib $CPPFLAGS"; export CFLAGS="-I$lib $CFLAGS" }}; done

if command -v pyenv &> /dev/null
then
    export PYENV_ROOT=$HOME/.pyenv
    eval $(pyenv init --path)
fi
