# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew
         colored-man-pages
         command-not-found
         dotenv
         pip
         wd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Add support for auto-completions.
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

# Add autosuggestions.
[[ ! -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] || source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Add support for syntax highlighting on the command line.
[[ ! -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# If iTerm configuration is present, use its integration functionality.
[[ ! -f ~/.iterm2_shell_integration.zsh ]] || source ~/.iterm2_shell_integration.zsh

# # Pyenv startup.
# [[ -z "${PYENV_ROOT}" || ! -d "${PYENV_ROOT}" ]] || eval "$(pyenv init -)"

# If the x86-64 Homebrew path is found, add it first to put it at the back.

[[ ! -d /usr/local/Homebrew ]] || {
    alias brew64="arch -x86_64 /usr/local/homebrew/bin/brew"
    export PATH="/usr/local/homebrew/bin:$PATH"

    export HOMEBREW64_BASE="/usr/local"
    export HOMEBREW64_OPT="$HOMEBREW64_BASE/opt"
    export HOMEBREW64_LIB="$HOMEBREW64_BASE/lib"
}

# Then add all other Homebrew-related paths as needed.

[[ ! -d /opt/homebrew ]] || {
    export HOMEBREW_BASE="/opt/homebrew"
    export HOMEBREW_OPT="$HOMEBREW_BASE/opt"
    export HOMEBREW_LIB="$HOMEBREW_BASE/lib"
    export RUBY_BASE="$HOMEBREW_BASE/opt/ruby"
    export RUBY_EXEC="$RUBY_BASE/bin/ruby"
    export GEM_EXEC="$RUBY_BASE/bin/gem"
    { [[ ! -x $GEM_EXEC ]] || export GEM_DIR="$($GEM_EXEC env gemdir)/bin" }
}

[[ ! -d /usr/local/smlnj ]] || export SMLNJ_BASE="/usr/local/smlnj"

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
    $HOME/.local/bin
    $HOMEBREW_BASE/bin
    $HOMEBREW_BASE/sbin
    $HOMEBREW_OPT/llvm/bin
    $HOMEBREW64_OPT/llvm/bin
    $HOMEBREW_OPT/openssl@3/bin
    $HOMEBREW_OPT/sqlite/bin
    $RUBY_BASE/bin
    $GEM_DIR
    $SMLNJ_BASE/bin
    $SDK_PATH/usr/bin
)

for extension in $path_extensions; do { [[ ! -d $extension ]] || export PATH="$extension:$PATH" }; done

linker_paths=(
    $HOMEBREW_LIB
    $HOMEBREW_OPT/apr/lib
    $HOMEBREW_OPT/apr-util/lib
    $HOMEBREW_OPT/bzip2/lib
    $HOMEBREW_OPT/icu4c/lib
    $HOMEBREW_OPT/libffi/lib
    $HOMEBREW_OPT/llvm/lib
    $HOMEBREW64_OPT/llvm/lib
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
    $HOMEBREW64_OPT/llvm/include
    $HOMEBREW_OPT/ncurses/include
    $HOMEBREW_OPT/openssl@1.1/include
    $HOMEBREW_OPT/openssl@3/include
    $HOMEBREW_OPT/readline/include
    $HOMEBREW_OPT/zlib/include
    $RUBY_BASE/include
    $SDK_PATH/usr/include
)

for lib in $libs; do { [[ ! -d $lib ]] || { export CPPFLAGS="-I$lib $CPPFLAGS"; export CFLAGS="-I$lib $CFLAGS" }}; done

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

[[ ! -d "$CARGO_HOME/bin" ]] || {
    export PATH="$CARGO_HOME/bin:$PATH"
}

fpath=(
    /opt/homebrew/share/zsh/site-functions
    "$XDG_DATA_HOME"/zsh/site-functions
    $fpath
)

export GHCUP_USE_XDG_DIRS="t"

# Add Racket.
# TODO: Find a way to make this automatic when Racket is updated, i.e., find the
# newest Racket version in [/Applications/] and use that one.
[[ ! -d "/Applications/Racket v9.0" ]] || {
    export PATH="/Applications/Racket v9.0/bin:$PATH"
}

if command -v pyenv &> /dev/null
then
    export PYENV_ROOT=$HOME/.pyenv
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init - zsh)"
fi

if command -v opam &> /dev/null
then
    eval $(opam env)
fi
