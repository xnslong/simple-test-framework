#!/bin/bash

function assert_equals() {
    if [ ! "$1" = "$2" ]; then
        error "check \"$3\" failed: expect \"$1\" but got \"$2\""
        return 1
    fi
}

function assert_contains() {
    if ! echo "$1" | grep "$2" &> /dev/null; then
        error "check \"$3\" failed:  \"$1\" contains \"$2\" failed."
        return 1
    fi
}

function is_number {
    [ -n "$1" ] && [ `echo "$1" | grep -oE '[0-9]+'` = "$1" ]
}

function assert_gt() {
    if ! is_number "$1" || ! is_number "$2" || [ ! "$1" -gt "$2" ] ; then
        error "check \"$3\" failed:  $1 > $2 failed"
        return 1
    fi
}

function assert_lt() {
    if ! is_number "$1" || ! is_number "$2" || [ ! "$1" -lt "$2" ] ; then
        error "check \"$3\" failed:  $1 < $2 failed"
        return 1
    fi
}

