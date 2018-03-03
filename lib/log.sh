#!/bin/bash

function log {
    echo -e "$(date '+%Y-%m-%d %H:%M:%S') $*"
}

function info {
    log "$(green [INFO])" "$*"
}

function error {
    log "$(red [ERROR])" "$*"
}

function warn {
    log "$(yellow [WARN])" "$*"
}

