#!/usr/bin/env bash

#######################################################################################################################
# Homebrew
#######################################################################################################################

# Install Homebrew if not installed or try to update it
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew upgrade
    brew update
fi

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

#######################################################################################################################
# Apps
#######################################################################################################################

brew install --cask microsoft-edge
brew install --cask spotify
brew install --cask appcleaner
brew install --cask visual-studio-code
brew install --cask microsoft-azure-storage-explorer
brew install --cask alfred
brew install --cask drawio
brew install --cask dash
brew install --cask iterm2

# CLI
brew install gh
brew install azure-cli
brew install awscli
brew install kubernetes-cli

# Cloud Management and Configuration
brew install terraform 
brew install terraform-docs 
brew install terragrunt
brew install ansible

# Containers
brew install --cask docker

#######################################################################################################################
# Programming Languages
#######################################################################################################################
brew install golang
mkdir -p ~/.local/opt/go

brew install --cask powershell

#######################################################################################################################
# Tools
#######################################################################################################################
# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum" || true

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install jq
brew install yq
brew install p7zip
brew install pigz
brew install pv
brew install ssh-copy-id
brew install tree
brew install iproute2mac

# Install global Python packages and tools
pip3 install cruft 

# Install Hugo
brew install hugo

#######################################################################################################################
# Shell (zsh)
#######################################################################################################################

# Install more recent version of Zsh
brew install zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Fix Oh My Zsh Permissions
sudo chown -R $(whoami) /usr/local/share/zsh \
&& sudo chmod u+w /usr/local/share/zsh \
&& sudo chown -R $(whoami) /usr/local/share/zsh/site-functions \
&& sudo chmod u+w /usr/local/share/zsh/site-functions \
&& sudo chmod -R 755 /usr/local/share/zsh

#######################################################################################################################
# Cleanup
#######################################################################################################################

# Remove outdated versions from the cellar.
brew cleanup
