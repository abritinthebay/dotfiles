
function fractionalSecond() {
    python -c 'import time; from decimal import *; time=Decimal(time.time()); rounded = int(time); print time - rounded;'
}
function milliseconds() {
    local frac;
    frac="$(fractionalSecond)";
    local milli="${frac: 1: 5}";
    echo "$milli";
}

function timezone () {
    # gets the timezone in +-01:00 format
    date -R | {
        IFS= read -r d;
        echo "${d:$((${#d}-5)):3}:${d:$((${#d}-2)):2}";
        }
}

alias now='date +%T'                                        # current time in hh:mm:ss format
alias nowdate='date +%d-%m-%Y'                              # current date in dd-mm-yyyy format
alias nowiso='date +%Y-%m-%dT%T$(milliseconds)$(timezone)'  # ISO 8601 date format (2018-06-29T15:58:36+00:00)
alias nowisoweek='date +%Y-W%W-%w'                          # ISO 8601 date-week format (2018-W27-1) ([year]-W[week number]-[day number])
