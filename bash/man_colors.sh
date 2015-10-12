####
# This is used to set the colors in the man pages. Enjoy.

man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[01;31m") \
    LESS_TERMCAP_md=$(printf "\e[01;38;5;208m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[04;38;5;111m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    man "$@"
}
