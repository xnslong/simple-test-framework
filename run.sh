# Copyright 2018-03-04 zilong6
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

export TEST_TIME="$(date +%Y%m%d-%H%M%S)"
LOG_DIR="logs/$TEST_TIME"
[ -d "$LOG_DIR" ] || mkdir -p "$LOG_DIR"

export REPORT="$LOG_DIR/report.log"
for l in `find common -name '*.sh'`; do
    if echo "$l" | grep -E '.*\.sh$' &> /dev/null; then
        source "$l"
    fi
done

function run_all {
    for f in `find cases -name '*.case'`; do
        run_tests "$f" | tee -a "$REPORT"
    done

    echo -e "see report $REPORT"
}

function run_failed {
    report="$1"
    failures="$(cat "$1" | sed -r "s/[[:cntrl:]]\[[0-9]{1,3}m//g"| awk '$4 ~ /.*FAIL.*/ {print $1, $3}')"
    failure_file="$(echo "$failures" | awk '{print $2}' | sort | uniq)"

    for f in `echo "$failure_file"`; do
        if [ -r "$f" ] && echo "$f" | grep -E -E ".*\.case" &> /dev/null; then 
            run_tests "$f" "$(echo "$failures" | grep "$f" | awk '{print $1}')" | tee -a "$REPORT"
        fi
    done

    echo -e "see report $REPORT"
}

function print_usage {
cat << EOFSDFKJ
`green $0`  -a                       : run all test cases
`green $0`  -r <report file>         : run all failed test cases in the report file
`green $0`  -h                       : show this help and exit
EOFSDFKJ
}

if [ $# -gt 0 ]; then
    case "$1" in
        -h)
            print_usage
            ;;
        -r)
            run_failed "$2"
            ;;
        -a)
            run_all
            ;;
        *)
            print_usage
    esac
else
    print_usage
fi

unset TEST_TIME
