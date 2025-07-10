function rp () {
  rg -l "$1" | xargs perl -i -pe "s|$1|$2|g"
}

function Gcauto() {
  git commit -m "$(claude -p "Look at the staged git changes and create a summarizing git commit title. Only respond with the title and no affirmation.")"
}
