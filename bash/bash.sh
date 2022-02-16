#set the generic editor
export EDITOR=code
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=5000

# set our prompt
PROMPT_COMMAND='PS1="$(colorcode darkgrey)[\t] $(colorcode magenta)\u$(colorcode darkgrey):$(colorcode cyan)\W/$(colorcode red)$(get_git_prompt) $(colorcode green)\$$(colorcode default) "';

alias ls="ls -lFh";
alias rmrf='rm -rf';
alias ebash="code ~/.bashrc";
alias ubash="source ~/.bashrc";
alias cd..='cd ..';

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell
# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob
# Check the window size after each command and, if necessary,
# update the values of lines and columns.
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

# Make Directory then cd into it. -p will  create recursively
function mkcd() {
  mkdir -p "$1" && cd "$_" || return
}

# Easily go up directories. up 3 === cd ../../..
function up() {
  times=$1
  while [ "$times" -gt "0" ]; do
    cd ..
    times=$((times - 1))
  done
}

# Who has time to remember the right extract commands 
# for all the possible formats?
function extract () {
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.tar.xz)    tar Jxvf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       rar x "$1"       ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip -d "$(echo "$1" | sed 's/\(.*\)\.zip/\1/')" "$1";;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "Sorry, I don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' does not appear to be a valid file."
  fi
}




# load general bash completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[ -f /usr/local/etc/bash_completion ];
# load Project completion
[ -s "$HOME/.dotfiles/project.bash" ];