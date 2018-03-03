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

    for f in `find cases -name '*.case'`; do
        if echo "$failure_file" | grep "$f"; then 
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
