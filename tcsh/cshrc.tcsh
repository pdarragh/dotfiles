################################################################################
## TCSH Customizations
##
## All my favorite settings and customizations in one handy .bashrc file.
##
## This is based on a cshrc provided by Todd McDaniel.
##
################################################################################

################################################################################
# Prompt Customization

set promptchars='$#'

if ( -f ~/.tcsh_prompt ) then
    # alias precmd "tcsh ~/.tcsh_prompt"
    alias precmd 'set prompt="`tcsh ~/.tcsh_prompt`"'
endif

################################################################################
# Alias Inclusion

# Alias definitions.
# These are sourced from a separate file (~/.bash_aliases).
if ( -f ~/.tcsh_aliases ) then
    source ~/.tcsh_aliases
endif

################################################################################
# Programmable Completion (Tab Completion)
set autolist

################################################################################
# SSH Tab Completion

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W `grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n'` scp sftp ssh;

################################################################################
# Miscellaneous

# Color for ls output
setenv CLICOLOR YES
setenv LSCOLORS GxFxCxDxBxegedabagaced

# Color for Grep
setenv GREP_OPTIONS --color=auto
setenv GREP_COLOR '1;35;40'

# History file
set histfile = ~/.tcsh_history

# History size limits and time format
set history = ( 100000 "%h  %d %Y-%W-%D %P\t%R\n" )
set savehist = ( 100000 merge )

# Autocorrect typos in path names when using `cd`
set autocorrect

# Modify $PATH
setenv PATH '/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/lib:/usr/local/include'

################################################################################
# Extras Inclusion

# These are sourced from a separate file (~/.bash_extras).
# This is useful if you want per-machine changes to be made. Since this is at
# the bottom of .bash_profile, these will be the last changes to be effected.
if ( -f ~/.tcsh_extras ) then
    source ~/.tcsh_extras
endif
