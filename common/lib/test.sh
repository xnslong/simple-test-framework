# Copyright 2018-03-04 zilong6
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

function run_test () {
    echo -e "-------------------------" >> "$LOG_FILE"
    CASE_NAME="`yellow $1` in `yellow $SUITE`"
    info "running testcase $CASE_NAME" >> "$LOG_FILE"
    {
        set -e
        "$1" &>> "$LOG_FILE"
    } && {
        msg="$CASE_NAME   `green "[SUCCESS]"`" 
        info "[RESULT] $msg" >> "$LOG_FILE"
        echo -e "$msg"
    } || {
        msg="$CASE_NAME   `red "[FAIL]"`" 
        error "[RESULT] $msg" >> "$LOG_FILE"
        echo -e "$msg"
    }
    echo -e "" >> "$LOG_FILE"
}

function run_tests () {
    source "$1"
    cases="$2"
    export SUITE="$(echo "$1")"
    export LOG_FILE="$LOG_DIR/$(echo "$SUITE.log" | sed -E 's#(.*/)*([^/]+)$#\2#g')"
    echo  -e "test suite \"$SUITE\" (log details see $LOG_FILE)"
    declare -F | awk '{print $3}' | while read name; do
        if echo "$name" | grep -E '^test_.*' &> /dev/null; then
            export CASE="$name"
            if [ -n "$cases" ] && ! echo "$cases" | grep "$CASE" &> /dev/null; then
                continue
            fi
            run_test "$CASE" | awk '{print "\t" $0}' 
            unset CASE
        fi
    done
    unset LOG_FILE
    unset SUITE
}
