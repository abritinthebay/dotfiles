#!/bin/zsh
# Description: things that have to happen to get these to work cleanly in MacOS

# first, lets make sure xcode's cli tools are installed.
xcode-select --install

# Make sure the zshrc exists (it should, but... things break if it isn't and it doesn't by default)
touch ~/.zshrc
# Create a git directory in user home, this will be where any git projects will live
mkdir ~/git 

# Install node version manager (nvm)
if ! type "nvm" > /dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

# Install homebrew if it's not installed
if ! type "brew" > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# then install bash completions (good for zsh and bash)
if type "brew" > /dev/null; then
    # Why in a if? Because xcode-select --install can be weird
    # and it might run brew install and fail due to not being done installing 
    brew install bash-completion;
    brew install jq;                      # JSON querying
    brew install htop;                    # activity monitor for the shell
    brew install wget;
    brew install tmux;
    brew install tldr;                    # summarizes man pages
    brew install imagemagick;
    brew install ffmpeg;
    brew install spark;                   # sparklines for the shell. See https://github.com/holman/spark
    brew install lolcat;                  # rainbow colorizes any input
    brew install handbrake;               # video transcoder
    brew install zsh-syntax-highlighting; # does what it says on the tin
    echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
    brew install zsh-autosuggestions;
    echo "source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
    brew tap homebrew/command-not-found;  # suggestions for when a command is not found
    # see https://github.com/Homebrew/homebrew-command-not-found
fi

# Reload zsh config to make sure things like NVM and Homebrew are loaded
source ~/.zshrc

if type "nvm" > /dev/null; then
    # Install and use latest stable version of NodeJS
    nvm install stable
    nvm use stable
    corepack enable
    corepack enable yarn
fi