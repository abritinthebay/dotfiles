# core things that have to happen to get a MacOS setup to work
# this assumes things like XCode & its cli tools are already installed

# first, lets install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# then install bash completions (good for zsh and bash)
brew install bash-completion

# Uncomment below if you want to use bash instead of zsh in MocOS
# # install newest bash
# brew install bash
# # now add the new bash to the shell list. Has to be sudo
# echo "/usr/local/bin/bash" | sudo tee -a /etc/shells

# # now change shell for the current user
# chsh -s /usr/local/bin/bash

# # now do it for the root user (me)
# sudo chsh -s /usr/local/bin/bash

# # now add a bashrc and bash_profile for terminal
# touch ~/.bashrc
# echo "source ~/.bashrc" > ~/.bash_profile