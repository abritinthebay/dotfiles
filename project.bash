#compdef project
function _project {
  for proj in $(find "$PROJECT_DIRECTORY" -mindepth 1 -maxdepth 1 -type d)
  do
    if [[ ! $(basename $proj) == '.git' ]]; then
      compadd "$(basename $proj)"
    fi
  done
}

_project