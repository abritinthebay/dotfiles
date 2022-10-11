# Make Directory then cd into it. -p will  create recursively
function mkcd() {
  mkdir -p "$1" && cd "$_" || return
}

# Directory tree traversal and listing: d lists, d <num> goes to that entry
d() {
    if (( $# == 0 )) ; then
        dirs -v
    else
        index=${1:-0};
        cd +${index}
        unset index
    fi
}
# Weather to <place> or by default current IP location
weather() {
    curl -s "https://wttr.in/${1:-}" | sed -n "1,27p"
}

# convery number of bytes into a more human readable format (e.g. 1000 bytes = 1 kB)
bytesToHuman() {
    if (( $# == 0 )) ; then
      b=$(</dev/stdin);
    else
      b=${1:-0};
    fi
    d=''; s=0; S=(B {k,M,G,T,P,E,Z,Y}B)
    while ((b > 999)); do
        d="$(printf ".%02d" $((b % 1000 * 100 / 1000)))"
        b=$((b / 1000))
        (( s++ ))
    done
    echo "$b$d ${S[$s+1]}"
}

# As above but using the power of two system (e.g. 1024 bytes = 1 KiB)
bytesToIEC () {
    if (( $# == 0 )) ; then
      b=$(</dev/stdin);
    else
      b=${1:-0};
    fi
    d=''; s=0; S=(B {K,M,G,T,P,E,Z,Y}iB)
    while ((b > 1023)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "$b$d ${S[$s+1]}"
}

gzsize() {
  if (( $# == 0 )) ; then
    echo "No file specified!";
    echo "Usage: gzsize <file>";
    echo "";
  else
    d=$(<"$1");
    echo "original: $(echo "$d" | wc -c | bytesToHuman)";
    echo " gzipped: $(gzip -c "$1" | wc -c | bytesToHuman)";
  fi
}

# Who has time to remember the right extract commands 
# for all the possible formats?
function extract () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.tar.xz)    tar Jxvf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       rar x "$1"       ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip -d "$(echo "$1" | sed 's/\(.*\)\.zip/\1/')" "$1";;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "Sorry, I don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' does not appear to be a valid file."
  fi
}