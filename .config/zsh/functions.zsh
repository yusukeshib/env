function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function pretty () {
  jq . "$1" > "$1.tmp" && rm -f "$1" && mv "$1.tmp" "$1"
}

function as {
  export AWS_REGION=us-east-1
  export AWS_PROFILE=$1
}
