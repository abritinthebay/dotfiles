#!/bin/bash
alias co="git checkout"
alias merge="git merge"
alias branch="git branch"
alias pull="git pull"
alias push="git push"
alias addall="git add --all"
alias gitgraph="git log --graph --oneline --decorate --all"
alias gitdetail='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gitsetorigin="git remote add origin"
alias newfeature="feature_branch"

# enable git rerere
git config --global rerere.enabled true
# enable git rere to auto-stage files it solved
git config --global rerere.autoupdate true

function getGitBranchString () {
    git branch 2>/dev/null | grep '^*';
}
# Gets the current git branch name
function getGitBranch () {
    # the dev/null means we won't get "fatal:" output in a non-git branch
    string="$(git branch 2>/dev/null | grep '^*')";
    # If it contains a color excape sequence we should truncate more
    # the sed call removes the color control codes that *may* be present
    if [[ $string == *";"* ]]; then
        git branch 2>/dev/null | grep '^*' | colrm 1 8 | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'
    else
        git branch 2>/dev/null | grep '^*' | colrm 1 2 | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'
    fi
}

# Git log find by commit message
function gitfind () {
    git log --all --grep="$1";
}

function describeGitBranch () {
    if [ "$(getGitBranch)" != "" ]; then
        if [ -z "$1" ]; then
            git config branch."$(getGitBranch)".description;
        else
            git config branch."$(getGitBranch)".description "$1";
        fi
    fi
}

# Gets one or more characters to symbolize the current git repo status (if any)
function getGitStatus () {
    # git status --porcelain output codes:
    # ' ' = unmodified, M = modified, A = added, D = deleted, R = renamed, C = copied, U = unmerged
    git status --porcelain  2>/dev/null | (
        unset dirty deleted untracked newfile ahead renamed
        while read -r line ; do
            case "$line" in
            *"M "*)                           dirty='*' ; ;;
            *"D "*)                           deleted='-' ; ;;
            *"?? "*)                          untracked='?' ; ;;
            *'A '*)                           ahead='+' ; ;;
            *"R "*)                           renamed='~' ; ;;
            esac
        done
        bits="$dirty$deleted$untracked$newfile$ahead$renamed"
        [ -n "$bits" ] && echo "$bits" || echo
    )
}

# Gets a string for the Bash prompt of format "([git branch])[git status]"
function get_git_prompt () {
    if [ "$(getGitBranch)" != "" ]; then
        output="($(getGitBranch))$(getGitStatus)"
        echo "$output"
    fi
}

# Create a feature branch that's up to date with latest master
# then push it to remote origin
function feature_branch() {
    branchName="$1"
    if [ "$branchName" != "" ]; then
        echo "Checking out and updating master";
        git checkout master && git pull;
        echo "Creating local branch from master and tracking origin"
        git checkout -b "$branchName" -t origin/master
    else
        echo "No branch name provided!"
    fi
}  

function git_remote_url_to_web_url() {
  local base
  base=$(echo "$remote_url" | sed -e "s/.git$//" -e "s/^git\@//" -e "s/\(.*[:/].*\)/\1/" -e "s/https\:\/\///" -e "s/\:/\//")
  echo "https://$base"
}


# Open a PR against <base_branch> (master by default) for the current branch
# on <remote_name> (origin by default)
# works for GITHUB only
# Usage: opr [<base_branch>] [<remote_name>]
function ghpr() {
    if ! git_is_repository; then
        echo 'Not a git repository.'
        return
    fi
    local base_branch_name pr_branch_name remote_url
    base_branch_name=$([ -n "$1" ] && echo "$1" || echo master)
    pr_branch_name="$(git symbolic-ref --short HEAD)"
    remote_url=$(git_get_remote_url "$2")
    if [ -z "$remote_url" ]; then
        echo "Remote $2 does not exist."
        return
    fi
    local repository_web_url
    repository_web_url=$(git_remote_url_to_web_url "$remote_url")
    open "$repository_web_url/compare/$base_branch_name...$pr_branch_name"
}