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

