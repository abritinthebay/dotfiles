# Basic Setup for zsh

#### Load Functions ####
autoload -Uz vcs_info   # Load version control information

#### Hooks ####
precmd() { vcs_info }

#### Options ####
setopt PROMPT_SUBST             # Enable substring substution in prompt
setopt NO_CASE_GLOB             # Case-insensitive globbing and tab-completion
setopt AUTO_CD                  # Automatically change directory if you type one but forget "cd"
setopt CORRECT                  # Turn on spelling correction for commands
setopt CORRECT_ALL              # Turn on spelling correction for all arguments

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

# zstyle ':vcs_info:git:*' formats      $'%K{9}\ue0b0%F{52} \ue0a0 %b%u%c %f%k'
# zstyle ':vcs_info:git:*' actionformats $'%K{9}\ue0b0%F{52} \ue0a0 %b|%a%u%c %f%k'
# # Set up the prompt (with git branch name)
# PROMPT=$'%K{13}%F{53}%n%F{13}%K{14}\ue0b0%F{23}%1~%F{14}${vcs_info_msg_0_}%k%F{10} $%f%k '
# RPROMPT=$' %F{8}%K{0}\ue0b2%F{234}%K{8}%*'

#### Prompt ####
# Set up the Prompt (with git branch name)
# format is: "[HH:MM:SS] uname:currentdirectory (branch state) $ "
# single string is importatnt otherwise updating strings like vcs info won't update!
PROMPT='%F{8}[%*] %F{13}%n%F{8}:%F{14}%1~ %F{9}${vcs_info_msg_0_} %F{10}$%f '

#### Aliases ####
alias ls="ls -lFhG"
alias rmrf='rm -rf';
alias ezsh="code ~/.zshrc";
alias uzsh="source ~/.zshrc";
alias cd..='cd ..';