#!/bin/bash

function assert_equals() {
    if [ ! "$1" = "$2" ]; then
        error "check \"$3\" failed: expect \"$1\" but got \"$2\""
        return 1
    fi
}

