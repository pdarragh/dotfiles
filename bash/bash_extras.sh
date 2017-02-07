weather () {
    if [ -z "$1" ]; then
        echo "No location given."
        return 1
    fi
    curl -s "wttr.in/$1"
}

short_weather () {
    weather "$1" | head -7
}

moon_phase () {
    if [ -z "$1" ]; then
        time="$(date +%Y-%b-%d)"
    else
        time="$1"
    fi
    curl -s "wttr.in/moon@${time}"
}

