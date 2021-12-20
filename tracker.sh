#! /bin/bash
set -e

screenint="${SCREENINT:-30}"
quality="${QUALITY:-10}"

function set_today() {
    today=$(date --date="today" +"%m%d%y")
    echo "Set today's date: ${today}"
}

function get_dailydir() {
    dir="${TARGETDIR:-~/prodtracker}"
    dailydir="${dir}/${today}"
    echo "${dailydir}"
}


function check_or_create_dir() {
    dailydir=$(get_dailydir)
    if [ ! -d "${dailydir}" ]; then
        echo "Directory absent, creating: ${dailydir}"
        mkdir -p "${dailydir}"
    fi
}

function screenshot_loop() {
    while true; do
        # If it's a new day, reset some variables and create a new directory for saving screenshots.
        date_now=$(date --date="today" +"%m%d%y")
        if [ "${date_now}" != "${today}" ]; then
            set_today
            check_or_create_dir
        fi
        dailydir=$(get_dailydir)

        # Allow for pausing capture
        if [ ! -f /tmp/trackerpause ]; then
            ts=$(date +"%H%M%S")
            targetdir="${dailydir}/${ts}.jpeg"
            # scrot -q "${quality}" -m -z -p "${targetdir}"
            # This will need to be"
            # screencapture -D 1 (display 1, followed by -D 2), [-x (don't play sounds) ?], -C include cursor  "${targetdir}"
            # may need to screencapture calls, or maybe can use -R to define a rect capture area
        fi
        sleep $screenint
    done
}

function main() {
    set_today
    check_or_create_dir
    screenshot_loop
}

main
