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
#       [ HH:MM:SS | $(pwd) (| g: git info )]
#       [ username | hostname | h\! | r$? ]\$
# Which could appear as:
#       [ 16:23:42 | /Users/pdarragh ]
#       [ pdarragh | mycomputer | h283 | r0 ]$
prompt_command () {
	# This must be done first to correctly capture the return status.
	retstat=$?
	
	local my_time	# time
	local my_shel	# shell
	local my_diry	# directory
	local my_gitd	# git repository information
	local my_user	# user name
	local my_host	# hostname
	local my_hist	# history number
	local my_rtrn	# return value
	local my_suid	# superuser id prompt (e.g. $ or #)
	
	# This is the default color of "boring" items.
	default="${FBBLK}"
	
	# Set the time.
	my_time="${FBYEL}\t"
	
	# Set the shell.
	shell="$(echo $0)"
	if [[ ${shell} =~ -(.*) ]]; then
		shell=${BASH_REMATCH[1]}
	fi
	my_shel="${default}${shell}"
	
	# Set the current working directory.
	my_diry="${FBMAG}$( pwd )"
	
	# Set the git prompt (if it's available)
	my_gitd=""
	if [ -f ~/.git_prompt ]; then
		git_branch="$(__git_ps1)"
		if [ "${git_branch}" != "" ]; then
			my_gitd="${FWHT} | ${default}g:${FBCYN}${git_branch} "
		fi
	fi
	
	# Set the user name and the superuser prompt indicator.
	if [ "$(whoami)" == "root" ]; then
		my_user="${HC}${FBYEL}${BBRED}\u"
		my_suid="#"
	else
		my_user="${FBCYN}\u"
		my_suid="$"
	fi
	
	# Set the hostname. Colorizes if it's an SSH session.
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
        my_host="${FBYEL}\h"
    else
        my_host="${default}\h"
    fi
	
	# Set the history number.
	my_hist="${default}h\!"

	# Set the return status of the previous command.
	if [[ ${retstat} -eq 0 ]]; then
		# Success. Color it green.
		my_rtrn="${HC}${FBGRN}r0"
	else
		# Failed. Color it red.
		my_rtrn="${FBRED}r${retstat}"
	fi
	
	# Put it all together in the prompt. Magic!
	export PS1="${RS}"
	export PS1+="${FWHT}[ ${my_time}${RS}${FWHT} | ${my_shel}${RS}${FWHT} | ${my_diry}${RS}${FWHT}${my_gitd}${RS}${FWHT}]\n"
	export PS1+="${FWHT}[ ${my_user}${RS}${FWHT} | ${my_host}${RS}${FWHT} | ${my_hist}${RS}${FWHT} | ${my_rtrn}${RS}${FWHT} ]${my_suid}${RS} "
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

# History file
# export HISTFILE='~/.bash_history'

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
