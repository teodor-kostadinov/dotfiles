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
brew install vim
brew install grep
brew install openssh
brew install screen
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install git
brew install git-lfs
brew install gs
brew install imagemagick
brew install jq
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli

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

# Install ZSH Auto Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#######################################################################################################################
# General Apps
#######################################################################################################################

# Microsoft Edge
brew install --cask microsoft-edge

# Spotify
brew install --cask spotify

# App Cleaner
brew install --cask appcleaner

# Typora
brew install --cask typora

#######################################################################################################################
# Programming Languages
#######################################################################################################################

# Install GoLang
brew install golang
mkdir -p ~/.local/opt/go

# Install PowerShell
brew install --cask powershell

#######################################################################################################################
# CLI
#######################################################################################################################

# Install GitHub CLI
brew install gh

# Cloud CLI
brew install azure-cli awscli

# Kubernetes CLI
brew install kubernetes-cli

#######################################################################################################################
# Containers
#######################################################################################################################

# Install Docker
brew install --cask docker

#######################################################################################################################
# Editors
#######################################################################################################################

# Install VSCode
brew install --cask visual-studio-code

# Install JetBrains GoLand
brew install goland

#######################################################################################################################
# Infrastructure and Configuration Management
#######################################################################################################################

# Install Terraform and Terraform Related Tools
brew install terraform terraform-docs terragrunt

# Ansible
brew install ansible

#######################################################################################################################
# Tools
#######################################################################################################################

# Microsoft Azure Storage Explorer
brew install --cask microsoft-azure-storage-explorer

# Alfred
brew install --cask alfred

# Draw.IO
brew install --cask drawio

# Dash
brew install --cask dash

# Iterm
brew install --cask iterm2

#######################################################################################################################
# Cleanup
#######################################################################################################################

# Remove outdated versions from the cellar.
brew cleanup
