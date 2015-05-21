#!/bin/tcsh

# Accepts one argument: the current shell.

################################################################################
# ANSI Color Codes
#
# Use these for any color settings in the prompts.

## Special
set RS="%{\033[0m%}"                # reset
set HC="%{\033[1m%}"                # hicolor (bold)
set DIM="%{\033[2m%}"               # dim
set UL="%{\033[4m%}"                # underline
set BL="%{\033[5m%}"                # blink
set INV="%{\033[7m%}"               # invert background and foreground
set HID="%{\033[8m%}"               # hidden
## Foreground
set FBLK="%{\033[30m%}"             # foreground black
set FRED="%{\033[31m%}"             # foreground red
set FGRN="%{\033[32m%}"             # foreground green
set FYEL="%{\033[33m%}"             # foreground yellow
set FBLU="%{\033[34m%}"             # foreground blue
set FMAG="%{\033[35m%}"             # foreground magenta
set FCYN="%{\033[36m%}"             # foreground cyan
set FWHT="%{\033[37m%}"             # foreground white
## Foreground Bright
set FBBLK="%{\033[90m%}"            # foreground bold black
set FBRED="%{\033[91m%}"            # foreground bold red
set FBGRN="%{\033[92m%}"            # foreground bold green
set FBYEL="%{\033[93m%}"            # foreground bold yellow
set FBBLU="%{\033[94m%}"            # foreground bold blue
set FBMAG="%{\033[95m%}"            # foreground bold magenta
set FBCYN="%{\033[96m%}"            # foreground bold cyan
set FBWHT="%{\033[97m%}"            # foreground bold white
## Background
set BBLK="%{\033[40m%}"             # background black
set BRED="%{\033[41m%}"             # background red
set BGRN="%{\033[42m%}"             # background green
set BYEL="%{\033[43m%}"             # background yellow
set BBLU="%{\033[44m%}"             # background blue
set BMAG="%{\033[45m%}"             # background magenta
set BCYN="%{\033[46m%}"             # background cyan
set BWHT="%{\033[47m%}"             # background white
## Background Bright
set BBBLK="%{\033[100m%}"           # background bold black
set BBRED="%{\033[101m%}"           # background bold red
set BBGRN="%{\033[102m%}"           # background bold green
set BBYEL="%{\033[103m%}"           # background bold yellow
set BBBLU="%{\033[104m%}"           # background bold blue
set BBMAG="%{\033[105m%}"           # background bold magenta
set BBCYN="%{\033[106m%}"           # background bold cyan
set BBWHT="%{\033[107m%}"           # background bold white

################################################################################
# Prompt Customization
#
# The following creates:
#       [ HH:MM:SS | $(pwd) ]
#       [ username | hostname | h\! | r$? ]\$
# Which could appear as:
#       [ 16:23:42 | /Users/pdarragh ]
#       [ pdarragh | mycomputer | h283 | r0 ]$

# This is the default color of "boring" items.
set default="${FBBLK}"

# Set the time.
set my_time="${FBYEL}%P"

# Set the shell.
if ( $?1 ) then
    set my_shel="${default}$1"
else
    set my_shel="${default}tcsh"
endif

# Set the current working directory.
set my_diry="${FBMAG}`pwd`"

# Set the user name and the superuser prompt indicator.
if ( "`whoami`" == "root" ) then
    set my_user="${HC}${FBYEL}${BBRED}%n"
    set my_suid='#'
else
    set my_user="${FBCYN}%n"
    set my_suid='$'
endif

# Set the hostname. Colorizes if it's an SSH session.
if ( $?SSH_CLIENT || $?SSH_TTY || $?SSH_CONNECTION ) then
    set my_host="${FBYEL}%m"
else
    set my_host="${default}%m"
endif

# Set the history number.
set my_hist="${default}h%h"

# Set the return status of the previous command.
set retstat=$?
if ( ${retstat} == 0 ) then
    # Success. Color it green.
    set my_rtrn="${HC}${FBGRN}r0"
else
    # Failed. Color it red.
    set my_rtrn="${FBRED}r${retstat}"
endif

# Put it all together in the prompt. Magic!
set prompt="${RS}"
set prompt="${prompt}${FWHT}[ ${my_time}${RS}${FWHT} | ${my_shel}${RS}${FWHT} | ${my_diry}${RS}${FWHT} ]\n"
set prompt="${prompt}${FWHT}[ ${my_user}${RS}${FWHT} | ${my_host}${RS}${FWHT} | ${my_hist}${RS}${FWHT} | ${my_rtrn}${RS}${FWHT} ]${my_suid}${RS} "

echo "${prompt}"
