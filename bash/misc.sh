
# turn a video into a gif
function gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i "$1" -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > "$1.gif"
      rm out-static*.png
    else
      ffmpeg -i "$1" -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > "$1.gif"
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# Weather
weather() {
    curl -s "https://wttr.in/${1:-}" | sed -n "1,27p"
}

bytesToHuman() {
    if (( $# == 0 )) ; then
      b=$(</dev/stdin);
    else
      b=${1:-0};
    fi
    d=''; s=0; S=(B {K,M,G,T,P,E,Z,Y}iB)
    while ((b > 1024)); do
        d="$(printf ".%02d" $((b % 1024 * 100 / 1024)))"
        b=$((b / 1024))
        (( s++ ))
    done
    echo "$b$d ${S[$s]}"
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