# core things that have to happen to get a MacOS setup to work
# this assumes things like XCode & its cli tools  are already installed

# first, lets install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# then install newer versions of bash, etc
brew install bash coreutils bash-completion

#now add the new bash to the shell list. Has to be sudo
echo "/usr/local/bin/bash" | sudo tee -a /etc/shells

# now change shell for the current user
chsh -s /usr/local/bin/bash

# now do it for the root user (me)
sudo chsh -s /usr/local/bin/bash

# now add a bashrc and bash_profile for terminal
touch ~/.bashrc
echo "source ~/.bashrc" > ~/.bash_profile