#!/bin/bash

function logged {
    info "$@" >> "$LOG_FILE"
    result=$("$@")
    info "$result" >> "$LOG_FILE"
    echo -e "$result"
}

