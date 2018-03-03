#!/bin/bash

function run_test () {
    echo -e "-------------------------" >> "$LOG_FILE"
    CASE_NAME="`yellow $1` (in `yellow $SUITE`)"
    info "running testcase $CASE_NAME" >> "$LOG_FILE"
    {
        "$1" &>> "$LOG_FILE"
    } && {
        msg="$CASE_NAME   `green "[SUCCESS]"`" 
        info "$msg" >> "$LOG_FILE"
        echo -e "$msg"
    } || {
        msg="$CASE_NAME   `red "[FAIL]"`" 
        info "$msg" >> "$LOG_FILE"
        echo -e "$msg"
    }
    echo -e "" >> "$LOG_FILE"
}

function run_tests () {
    source "$1"
    export SUITE="$(echo "$1" | sed -E 's#(.*/)*([^/]+)$#\2#g')"
    export LOG_FILE="$LOG_DIR/$SUITE.log"
    echo  -e "----- running tests in \"$SUITE\" (detail logs see $LOG_FILE) -----"
    declare -F | awk '{print $3}' | while read name; do
        if echo "$name" | grep -E '^test_.*' &> /dev/null; then
            export CASE="$name"
            run_test "$CASE" | awk '{print "\t" $0}' 
            unset CASE
        fi
    done
    unset LOG_FILE
    unset SUITE
}
