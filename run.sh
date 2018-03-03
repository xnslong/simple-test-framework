#!/bin/bash

export TEST_TIME="$(date +%Y%m%d-%H%M%S)"
LOG_DIR="logs/$TEST_TIME"
[ -d "$LOG_DIR" ] || mkdir -p "$LOG_DIR"

export REPORT="$LOG_DIR/report.log"
for l in lib/*; do
    source "$l"
done

for f in cases/*; do
    if echo "$f" | grep -E '.*\.case' &> /dev/null; then 
        run_tests "$f" | tee -a "$REPORT"
    fi
done

echo -e "see report $REPORT"

unset TEST_TIME
