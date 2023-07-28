#!/bin/bash

duration=1500
remaining=$duration
stopped=true

print_time() {
    local time=$1
    if (( time < 0 )); then
        time=$((-time))
    fi
    local minutes=$(( time/60 ))
    local seconds=$(( time%60 ))
    printf "%02d:%02d" $((minutes)) $((seconds))
}

handle_signal() {
    if "$stopped"; then
        stopped=false;
        start_time=$(date +%s)
    else
        stopped=true;
        remaining=$duration;
    fi
}

render() {
    if "$stopped"; then
        print_time "$remaining"
        printf " %%{F#9B2C00}%%{F-}\n";
    elif (( remaining >= 0 )); then
        print_time "$remaining"
        printf " %%{F#599300}%%{F-}\n"
    else
        printf "%%{F#FCD100}"
        print_time "$remaining"
        printf " %%{F-}\n"
    fi
}

update() {
    if ! "$stopped"; then
        remaining=$((duration-$(($(date +%s)-start_time))))
    fi
}

trap "handle_signal" USR1

echo "$$"

while true; do
    update
    render
    sleep 0.2
done
