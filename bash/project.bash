#compdef project
function _project {
  while IFS= read -r -d '' proj
  do
     if [[ ! $(basename "$proj") == '.git' ]]; then
      compadd "$(basename "$proj")"
    fi
  done < <(find "$PROJECT_DIRECTORY" -mindepth 1 -maxdepth 1 -type d)
}

_project