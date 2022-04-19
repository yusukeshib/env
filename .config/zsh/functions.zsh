function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}
