#!/bin/sh
echo "Welcome to your mac setup \n"


#########################################
# HOMEBREW INSTALLATION                 #
#########################################

if ! command -v brew &> /dev/null; then 
	echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
    export PATH="/usr/local/bin:$PATH"
	brew tap Homebrew/bundle
else
        echo "Homebrew already installed."
fi

#########################################
# APPLICATION INSTALLATION VIA BREWFILE #
#########################################

echo "Installing applications via the Brewfile"
brew bundle --file ~/Code/mac-setup/Brewfile


#########################################
# oh-my-zsh                             #
#########################################

if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Installing on-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed."
fi

#########################################
# Mackup and dotfile config             #
#########################################


##############################################
# Private & Public Key setup via laspass cli #
##############################################
if [[ ! -e ~/.ssh ]]; then
    # TODO: Add to Lastpass via the CLI - Password not working though
    read -p "Enter email : " email
    echo "Using email $email"
    if [ ! -f ~/.ssh/id_rsa ]; then
        ssh-keygen -t rsa -b 4096 -C "$email"
        ssh-add ~/.ssh/id_rsa
    fi
    pub=`cat ~/.ssh/id_rsa.pub`
    # read -p "Enter github username: " githubuser
    # echo "Using username $githubuser"
    # read -s -p "Enter github password for user $githubuser: " githubpass
    # echo
    # read -p "Enter github OTP: " otp
    # echo "Using otp $otp"
    # echo
    # curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" --header "x-github-otp: $otp" https://api.github.com/user/keys
    echo "Unable to send to github so please add your SSH key to github"
else
    echo "You already have ssh keys"
fi


#########################################
# Git Setup                             #
#########################################
# 
# git config --global user.name "Your Name"
# git config --global user.email you@example.com

##############################################
# Verify installation somehow?               #
##############################################