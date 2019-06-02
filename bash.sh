#set the generic editor
export EDITOR=code
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

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

# load general bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}
# load NVM bash completions
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# load Project completion
[ -s "~/.dotfiles/project.bash" ] && \. "~/.dotfiles/project.bash"




