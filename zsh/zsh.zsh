# Basic Setup for zsh

# Some color flags
# First we tell the terminal to use colors and support 256 of them
# then we define the linux style LS_COLORS vs the BSD/MacOS style LSCOLORS
# Why? Because a lot of zsh tools only know the linux style, so we need it for completion/etc
# default is LSCOLORS=exfxcxdxbxegedabagacad, this translates into
# LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
# use this tool to customize: https://github.com/ggreer/lscolors
export TERM="xterm-256color"
export CLICOLOR=1; 
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
# this colorizes man/help pages
export LESS_TERMCAP_mb=$(print -P "%F{cyan}") \
    LESS_TERMCAP_md=$(print -P "%B%F{red}") \
    LESS_TERMCAP_me=$(print -P "%f%b") \
    LESS_TERMCAP_so=$(print -P "%K{magenta}") \
    LESS_TERMCAP_se=$(print -P "%K{black}") \
    LESS_TERMCAP_us=$(print -P "%U%F{green}") \
    LESS_TERMCAP_ue=$(print -P "%f%u")

#### Load Functions ####
autoload -Uz vcs_info;              # Load version control information
autoload -Uz compinit; compinit;    # Load Zsh Completion System
autoload zmv;                       # Load the pattern matching multiple file rename plugin 
                                    # eg: zmv '(*).(jpg|jpeg)' 'epcot-$1.$2' (add -n for a dry run )
#### Hooks ####
precmd() { vcs_info }

#### Options ####
setopt PROMPT_SUBST             # Enable substring substitution in prompt
setopt NO_CASE_GLOB             # Case-insensitive globbing and tab-completion
setopt AUTO_CD                  # Automatically change directory if you type one but forget "cd"
setopt CORRECT                  # Turn on spelling correction for commands
setopt CORRECT_ALL              # Turn on spelling correction for all arguments
setopt AUTO_PUSHD               # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS        # Do not store duplicates in the stack.
setopt PUSHD_SILENT             # Do not print the directory stack after pushd or popd.
setopt NOBEEP                   # Turns off all beeps, shockingly.

#### History Config ####
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
setopt EXTENDED_HISTORY         # Add time, execution length, etc to history file
setopt APPEND_HISTORY           # Append to history rather than overwrite
setopt INC_APPEND_HISTORY       # Adds to history as entered, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicates first in history
setopt HIST_IGNORE_DUPS         # do not store duplications in history
setopt HIST_FIND_NO_DUPS        # ignore duplicates in history when searching
setopt HIST_REDUCE_BLANKS       # removes blank lines from history

#### Style Options ####
# In zsh, the style mechanism is a flexible way of configuring shell add-ons that use functions,
# such as the completion system and editor widgets. Unlike variables they can be different
# in different contexts and unlike shell options they can take values.
# The mechanism is based on the command style.
zstyle ':vcs_info:*' check-for-changes true # Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' unstagedstr '*'    # custom string for unstaged changes (*)
zstyle ':vcs_info:*' stagedstr '+'      # custom string for staged changes (+)
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'       # format for vcs_info
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'    # more formats for vcs_info
zstyle ':completion:*' completer _extensions _expand_alias _complete _approximate   # setting up zsh completion 
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"     # sets the completion cache location
zstyle ':completion:*' use-cache on                                     # turns on completion cache
zstyle ':completion:*' group-name ''                                    # groups completions by type 
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}           # uses LS_COLORS for display
zstyle ':completion:*' squeeze-slashes true                             # uses more unix-y slash display

# Currently unused styles for setting up a different custom prompt
# zstyle ':vcs_info:git:*' formats      $'%K{9}\ue0b0%F{52} \ue0a0 %b%u%c %f%k'
# zstyle ':vcs_info:git:*' actionformats $'%K{9}\ue0b0%F{52} \ue0a0 %b|%a%u%c %f%k'

#### Aliases ####
alias ls="ls -lFhG" ll='ls -alFhG' dir='ls -alFhG';
alias rmrf='rm -rf';
alias ezsh="code ~/.zshrc";
alias uzsh="source ~/.zshrc" reload="source ~/.zshrc";
alias cd..='cd ..';
alias ffs='sudo !!';                    # redoes last command with sudo
alias -g 2clip='| pbcopy';              # pipe output to clipboard
alias -g clip2='pbpaste |';             # pipe clipboard to command
alias -g 2cb='| pbcopy';                # pipe output to clipboard
alias -g cb2='pbpaste |';               # pipe clipboard to command
alias -s {js,ts,json,md,yaml,yml}=code; # open {extensions} in code if directly accessed
alias -s log='tail -n10';               # tail logs if directly accessed
# colorized aliases
alias grep='grep --color=auto';
alias egrep='egrep --color=auto';
alias fgrep='fgrep --color=auto';
alias diff='diff --color=auto';
alias ip='ip --color';
alias df='df -h';
alias du='du -h';
alias free='free -h';
# adds a randomly colorizes sparkline to the top of the screen on clear
if (( $+commands[spark] )) && (( $+commands[lolcat] )); then
    alias clear='clear;seq 1 $(tput cols) | sort -R | spark | lolcat;'
fi

#### Hashed Directory Shortcuts ####
# this is where we can setup "cd ~foo" rather than "cd /very/long/and/annoying/to/type/path"
# hash -d git=$HOME/git;
#
# To do the above with the current directory we can use the following:
# usage: hashpwd <alias>
hashpwd() { hash -d "$1"="$PWD" }

# # Alternative set up the prompt (with git branch name) with Right Prompt
# PROMPT=$'%K{13}%F{53}%n%F{13}%K{14}\ue0b0%F{23}%1~%F{14}${vcs_info_msg_0_}%k%F{10} $%f%k '
# RPROMPT=$' %F{8}%K{0}\ue0b2%F{234}%K{8}%*'

#### Prompt ####
# Set up the Prompt (with git branch name). At the end so it can take advantage of anything above
# format is: "[HH:MM:SS] uname:currentdirectory (branch state) $ "
# single string is important otherwise updating strings like vcs info won't update!
PROMPT='%F{8}[%*] %F{13}%n%F{8}:%F{14}%1~%F{9}${vcs_info_msg_0_} %F{10}$%f '

# bash (and zsh) completions (if installed via homebrew, if not then comment out)
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
# NVM setup
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm