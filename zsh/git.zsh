export GIT_BASE_BRANCH="main" # some use the problematic master term, some use main.

alias co="git checkout"
alias merge="git merge"
alias branch="git branch"
alias pull="git pull"
alias push="git push"
alias addall="git add --all"
alias gitgraph="git log --graph --oneline --decorate --all"
alias gitdetail='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gitsetorigin="git remote add origin"

git config --global rerere.enabled true # enable git rerere
git config --global rerere.autoupdate true # enable git rere to auto-stage files it solved
# setup git alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.ri 'rebase -i HEAD~4' # quick way to do fixup/squashes of recent commits.
git config --global core.editor vim

function gitfind () {
    git log --all --grep="$1";
}

# Create a feature branch that's up to date with latest main branch
# then push it to remote origin
function feature_branch() {
    local branchName="$1"
    if [ "$branchName" != "" ]; then
        echo "Checking out and updating $GIT_BASE_BRANCH";
        git checkout $GIT_BASE_BRANCH && git pull;
        echo "Creating local branch from $GIT_BASE_BRANCH and tracking origin"
        git checkout -b "$branchName" -t origin/$GIT_BASE_BRANCH
    else
        echo "No branch name provided!"
    fi
}

# Validate provided param to SemVer standards.
# has a non-zero exit code and message if invalid
# returns the validated string on success
function semver_validate() {
  local NAT='0|[1-9][0-9]*'
  local ALPHANUM='[0-9]*[A-Za-z-][0-9A-Za-z-]*'
  local FIELD='[0-9A-Za-z-]+'
  local IDENT="$NAT|$ALPHANUM"
  local MAJORMINORPATCH="($NAT)\\.($NAT)\\.($NAT)"
  local PRERELEASE="(\\-($IDENT)(\\.($IDENT))*)"
  local BUILD="(\\+$FIELD(\\.$FIELD)*)"
  local SEMVER_REGEX="^[vV]?${MAJORMINORPATCH}${PRERELEASE}?${BUILD}?$";
  local VERSION=$1
  if [[ "$VERSION" =~ $SEMVER_REGEX ]]; then
    local major=${match[1]}
    local minor=${match[2]}
    local patch=${match[3]}
    local prere=${match[4]}
    local build=${match[8]}
    echo "${major}.${minor}.${patch}${prere}${build}"
    return 0; # being explicit
  else
    echo "[SemVer Validation Failed] '$VERSION' does not match pattern '(v|V)X.Y.Z(-PRERELEASE)(+BUILD)'."
    return 1; # also being explicit
  fi
}
