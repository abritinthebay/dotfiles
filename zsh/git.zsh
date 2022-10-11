alias co="git checkout"
alias merge="git merge"
alias branch="git branch"
alias pull="git pull"
alias push="git push"
alias addall="git add --all"
alias gitgraph="git log --graph --oneline --decorate --all"
alias gitdetail='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gitsetorigin="git remote add origin"

# enable git rerere
git config --global rerere.enabled true
# enable git rere to auto-stage files it solved
git config --global rerere.autoupdate true
# setup git alias
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
# quick way to do fixup/squashes of recent commits.
git config --global alias.ri 'rebase -i HEAD~4'

function gitfind () {
    git log --all --grep="$1";
}

export GIT_BASE_BRANCH="main" # some use the problematic master term, some use main.

# Create a feature branch that's up to date with latest master
# then push it to remote origin
function feature_branch() {
    branchName="$1"
    if [ "$branchName" != "" ]; then
        echo "Checking out and updating $GIT_BASE_BRANCH";
        git checkout $GIT_BASE_BRANCH && git pull;
        echo "Creating local branch from $GIT_BASE_BRANCH and tracking origin"
        git checkout -b "$branchName" -t origin/$GIT_BASE_BRANCH
    else
        echo "No branch name provided!"
    fi
}  