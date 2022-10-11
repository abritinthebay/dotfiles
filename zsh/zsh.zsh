# Basic Setup for zsh

# Some color flags
# First we tell the terminal to use colors
# then we define the linux style LS_COLORS vs the BSD/MacOS style LSCOLORS
# Why? Because a lot of zsh tools only know the linux style, so we need it for completion/etc
# default is LSCOLORS=exfxcxdxbxegedabagacad, this translates into
# LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
# use this tool to customize: https://github.com/ggreer/lscolors
export CLICOLOR=1; 
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

#### Load Functions ####
autoload -Uz vcs_info           # Load version control information
autoload -U compinit; compinit  # Load Zsh Completion System

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
# # Set up the prompt (with git branch name)
# PROMPT=$'%K{13}%F{53}%n%F{13}%K{14}\ue0b0%F{23}%1~%F{14}${vcs_info_msg_0_}%k%F{10} $%f%k '
# RPROMPT=$' %F{8}%K{0}\ue0b2%F{234}%K{8}%*'

#### Prompt ####
# Set up the Prompt (with git branch name)
# format is: "[HH:MM:SS] uname:currentdirectory (branch state) $ "
# single string is important otherwise updating strings like vcs info won't update!
PROMPT='%F{8}[%*] %F{13}%n%F{8}:%F{14}%1~ %F{9}${vcs_info_msg_0_} %F{10}$%f '

# bash (and zsh) completions (if installed via homebrew, if not then comment out)
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

#### Aliases ####
alias ls="ls -lFhG"
alias rmrf='rm -rf';
alias ezsh="code ~/.zshrc";
alias uzsh="source ~/.zshrc";
alias cd..='cd ..';