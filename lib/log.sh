#!/bin/bash

function log {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') $*"
}

function info {
    log "\033[34m[INFO]\033[0m" "$*"
}

function error {
    log "\033[31m[ERROR]\033[0m" "$*"
}

function warn {
    log "\033[33m[WARN]\033[0m" "$*"
}

