function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function rpm () {
  rg -l -U "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function pretty () {
  jq . "$1" > "$1.tmp" && rm -f "$1" && mv "$1.tmp" "$1"
}

function mp4 () {
   ffmpeg -i "$1" -vcodec libx264 -acodec aac "$1.mp4"
}
