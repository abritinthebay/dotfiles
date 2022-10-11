
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