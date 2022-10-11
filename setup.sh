#!/bin/zsh
# Description: things that have to happen to get these to work cleanly in MacOS

# first, lets make sure xcode's cli tools are installed.
xcode-select --install

# Make sure the zshrc exists (it should, but... things break if it isn't and it doesn't by default)
touch ~/.zshrc
# Create a git directory in user home, this will be where any git projects will live
mkdir ~/git 

# Install node version manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install homebrew if it's not installed
if ! type "brew" > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# then install bash completions (good for zsh and bash)
if type "brew" > /dev/null; then
    # Why in a if? Because xcode-select --install can be weird
    # and it might run brew install and fail due to not being done installing 
  brew install bash-completion
fi

# Reload zsh config to make sure things like NVM and Homebrew are loaded
source ~/.zshrc

# Install and use latest stable version of NodeJS
nvm install stable
nvm use stable
corepack enable
corepack enable yarn