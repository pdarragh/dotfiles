################################################################################
## Bash Customizations
##
## All my favorite settings and customizations in one handy .bashrc file.
##
################################################################################

################################################################################
# ANSI Color Codes
#
# Use these for any color settings in the prompts.

## Special
RS="\[\033[0m\]"                # reset
HC="\[\033[1m\]"                # hicolor (bold)
DIM="\[\033[2m\]"               # dim
UL="\[\033[4m\]"                # underline
BL="\[\033[5m\]"                # blink
INV="\[\033[7m\]"               # invert background and foreground
HID="\[\033[8m\]"               # hidden
## Foreground
FBLK="\[\033[30m\]"             # foreground black
FRED="\[\033[31m\]"             # foreground red
FGRN="\[\033[32m\]"             # foreground green
FYEL="\[\033[33m\]"             # foreground yellow
FBLU="\[\033[34m\]"             # foreground blue
FMAG="\[\033[35m\]"             # foreground magenta
FCYN="\[\033[36m\]"             # foreground cyan
FWHT="\[\033[37m\]"             # foreground white
## Foreground Bright
FBBLK="\[\033[90m\]"            # foreground bold black
FBRED="\[\033[91m\]"            # foreground bold red
FBGRN="\[\033[92m\]"            # foreground bold green
FBYEL="\[\033[93m\]"            # foreground bold yellow
FBBLU="\[\033[94m\]"            # foreground bold blue
FBMAG="\[\033[95m\]"            # foreground bold magenta
FBCYN="\[\033[96m\]"            # foreground bold cyan
FBWHT="\[\033[97m\]"            # foreground bold white
## Background
BBLK="\[\033[40m\]"             # background black
BRED="\[\033[41m\]"             # background red
BGRN="\[\033[42m\]"             # background green
BYEL="\[\033[43m\]"             # background yellow
BBLU="\[\033[44m\]"             # background blue
BMAG="\[\033[45m\]"             # background magenta
BCYN="\[\033[46m\]"             # background cyan
BWHT="\[\033[47m\]"             # background white
## Background Bright
BBBLK="\[\033[100m\]"           # background bold black
BBRED="\[\033[101m\]"           # background bold red
BBGRN="\[\033[102m\]"           # background bold green
BBYEL="\[\033[103m\]"           # background bold yellow
BBBLU="\[\033[104m\]"           # background bold blue
BBMAG="\[\033[105m\]"           # background bold magenta
BBCYN="\[\033[106m\]"           # background bold cyan
BBWHT="\[\033[107m\]"           # background bold white

################################################################################
# Prompt Customization
# PS1

# Include the git_prompt magic.
if [ -f ~/.git_prompt ]; then
	. ~/.git_prompt
	GIT_PS1_SHOWDIRTYSTATE=true
	GIT_PS1_SHOWUPSTREAM="auto"
fi

# The following creates:
#       [ HH:MM:SS | $(pwd) ]
#       [ username | hostname | h\! | r$? ]\$
# Which could appear as:
#       [ 16:23:42 | /Users/pdarragh ]
#       [ pdarragh | mycomputer | h283 | r0 ]$
prompt_command () {
	ret=$?
	def=${FBBLK}
	# Build the return value.
	if [[ $ret -eq 0 ]]; then
		# Color return value green
		prev="${FBGRN}${HC}r0${def}"
	else
		# Color return value red
		prev="${FBRED}r${ret}${def}"
	fi
	# Requires git_prompt.
	git_branch="$(__git_ps1)"
	# Build the git branch string.
	if [ "${git_branch}" != "" ]; then
		git_display="| g:${FBCYN}${git_branch} ${RS}"
	else
		git_display=""
	fi
	export PS1="${RS}"
	export PS1+="${FWHT}[ ${def}\t${FWHT} | ${FBMAG}$( pwd )${def} ${git_display}${FWHT}]\n"
	export PS1+="${FWHT}[ ${FBCYN}\u${FWHT} | ${def}\h${FWHT} | ${def}h\!${FWHT} | ${prev} ${FWHT}]\$ ${RS}"
}

export PROMPT_COMMAND=prompt_command

################################################################################
# Alias Inclusion

# Alias definitions.
# These are sourced from a separate file (~/.bash_aliases).
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

################################################################################
# Programmable Completion (Tab Completion)

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

################################################################################
# SSH Tab Completion

[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

################################################################################
# Miscellaneous

# Color for ls output
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Color for Grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

# History size limits
export HISTFILESIZE=100000
export HISTSIZE=100000

# Prepend the date and time to history entries
export HISTTIMEFORMAT='%a %F %T%t'

# Append to the history file instead of overwriting
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Modify $PATH
export PATH='/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/lib:/usr/local/include'

################################################################################
# Functions

# Allows for searching of Bundle IDs by application name
# Written by Brett Terpstra
bid() {
	local shortname location

	# combine all args as regex
	# (and remove ".app" from the end if it exists due to autocomplete)
	shortname=$(echo "${@%%.app}"|sed 's/ /.*/g')
	# if the file is a full match in apps folder, roll with it
	if [ -d "/Applications/$shortname.app" ]; then
		location="/Applications/$shortname.app"
	else # otherwise, start searching
		location=$(mdfind -onlyin /Applications -onlyin ~/Applications -onlyin /Developer/Applications 'kMDItemKind==Application'|awk -F '/' -v re="$shortname" 'tolower($NF) ~ re {print $0}'|head -n1)
	fi
	# No results? Die.
	[[ -z $location || $location = "" ]] && echo "$1 not found, I quit" && return
	# Otherwise, find the bundleid using spotlight metadata
	bundleid=$(mdls -name kMDItemCFBundleIdentifier -r "$location")
	# return the result or an error message
	[[ -z $bundleid || $bundleid = "" ]] && echo "Error getting bundle ID for \"$@\"" || echo "$location: $bundleid"
}

################################################################################
# Extras Inclusion

# These are sourced from a separate file (~/.bash_extras).
# This is useful if you want per-machine changes to be made. Since this is at
# the bottom of .bash_profile, these will be the last changes to be effected.
if [ -f ~/.bash_extras ]; then
    . ~/.bash_extras
fi
