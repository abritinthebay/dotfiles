function nanotime() {
    if [ -z "$1" ]; then
        python3 -c 'import time; from decimal import *; print(time.time_ns());'; # nanoseconds since epoch
    else
        rpad "$1" 0 $((${#1}+9)); # just pads with zeroes, as timestamps are by second
    fi
}

function microtime() {
    echo "$(($(nanotime $1) / 1000))";
}

function millitime() {
    echo "$(($(microtime $1) / 1000))";
}

# these get a <provided or current> time's number of milli/micro/nano seconds
function milliseconds() {
    lastN 3 $(millitime $1);
}
function microseconds() {
    lastN 6 $(microtime $1);
}
function nanoseconds() {
    lastN 9 $(nanotime $1);
}

# gets the local timezone in +-01:00 format
function timezone () {
    date +%z | {
        IFS= read -r d;
        echo "${d:$((${#d}-5)):3}:${d:$((${#d}-2)):2}";
        }
}

# gets current timestamp or returns passed one
function timestamp() {
    if [ -z "$1" ]; then
        echo "$(date +%s)";
    else
        echo $1;
    fi
}

# allows optional formatting with custom timestamp OR current timestamp if none provided
function dateFromTimestamp() {
    date -r $(timestamp $1) $2;
}

# Timestamp functions. Can pass an optional timestamp
# if no timestamp is provided they default to current timestamp
# basically convience methods around `date -r <timestamp> <format>`
function ts() {
    dateFromTimestamp $(timestamp $1) +%T;
}
function tsiso() {
    dateFromTimestamp $(timestamp $1) +%Y-%m-%dT%T.$(milliseconds $1)$(timezone)
}
function tsisoweek() {
    dateFromTimestamp $(timestamp $1) +%Y-W%W-%w;
}
function tsdate() {
    dateFromTimestamp $(timestamp $1) +%d-%m-%Y;
}

alias now='ts'                  # current time in hh:mm:ss format
alias nowdate='tsdate'          # current date in dd-mm-yyyy format
alias nowiso='tsiso'            # ISO 8601 date format (2018-06-29T15:58:36.345+00:00), ie "yyyy-mm-ddThh:mm:ss[.mmm]"
alias nowiso='tsisodate'        # ISO 8601 date format (2018-06-29), ie "yyyy-mm-dd"
alias nowisoweek='tsisoweek'    # ISO 8601 date-week format (2018-W27-1) ([year]-W[week number]-[day number])
