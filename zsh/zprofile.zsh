# Path for Pyenv.
export PYENV_ROOT="$HOME/.pyenv"
[[ ! -d ${PYENV_ROOT} ]] || export PATH="$PYENV_ROOT/bin:$PATH"

# Pyenv initalization.
eval "$(pyenv init --path)"
