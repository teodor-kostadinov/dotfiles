#!/usr/bin/env bash

set -e
set -f

printf "Configuration:\n"
IGNORE_OMZ=${IGNORE_OMZ:-false}
IGNORE_DOTFILES=${IGNORE_DOTFILES:-false}
IGNORE_BREW=${IGNORE_BREW:-false}
IGNORE_GIT=${IGNORE_GIT:-false}
IGNORE_DIR=${IGNORE_DIR:-false}


if [[ ${REMOTE_CONTAINERS} ]] ; then
    IGNORE_BREW=true
fi

printf " - IGNORE_OMZ       = %s\n" "${IGNORE_OMZ}"
printf " - IGNORE_DOTFILES  = %s\n" "${IGNORE_DOTFILES}"
printf " - IGNORE_GIT       = %s\n" "${IGNORE_GIT}"
printf " - IGNORE_BREW      = %s\n" "${IGNORE_BREW}"

#######################################################################################################################
# Oh My ZSH
#######################################################################################################################
if ! ${IGNORE_OMZ} ; then
    printf "\n🚀 Installing oh-my-zsh\n"
    if [ -d "${HOME}/.oh-my-zsh" ]; then
        printf "oh-my-zsh is already installed\n"
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        
        # Fix Oh My Zsh Permissions
        sudo chown -R $(whoami) /usr/local/share/zsh \
        && sudo chmod u+w /usr/local/share/zsh \
        && sudo chown -R $(whoami) /usr/local/share/zsh/site-functions \
        && sudo chmod u+w /usr/local/share/zsh/site-functions \
        && sudo chmod -R 755 /usr/local/share/zsh
    fi
fi

#######################################################################################################################
# Dotfiles
#######################################################################################################################
if ! ${IGNORE_DOTFILES} ; then
printf "\n🚀 Installing dotfiles\n"
ln -sf "$(pwd)/zsh/zshrc"       "${HOME}/.zshrc"
ln -sf "$(pwd)/common/aliases"  "${HOME}/.oh-my-zsh/custom/aliases.zsh"
ln -sf "$(pwd)/common/path"     "${HOME}/.oh-my-zsh/custom/path.zsh"
ln -sf "$(pwd)/common/functions" "${HOME}/.oh-my-zsh/custom/functions.zsh"
ln -sf "$(pwd)/git/.gitconfig"  "${HOME}/.gitconfig"
ln -sf "$(pwd)/git/.gitignore"  "${HOME}/.gitignore"
fi

#######################################################################################################################
# Homebrew
#######################################################################################################################
if ! ${IGNORE_BREW} ; then
    printf "\n🚀 Installing homebrew\n"
    if [ "$(arch)" = "arm64" ]; then
        printf "\nRunning on arm64\n"
        if ! brew --version ; then
            sudo mkdir -p /opt/homebrew
            sudo chown -R "$(whoami)":wheel /opt/homebrew
            curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
        else
            brew update
            brew upgrade
        fi
    else
        printf "\nRunning on intel\n"
        if ! brew --version ; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        else
            brew update
            brew upgrade
        fi
    fi

BREW_PREFIX=$(brew --prefix)

printf "\n🚀 Installing homebrew packages\n"

# Standard Apps
brew install --cask \
microsoft-edge  \
spotify \
appcleaner \
visual-studio-code \
microsoft-azure-storage-explorer \
alfred \
drawio \
dash \
iterm2

# CLI
brew install \
gh \
azure-cli \
awscli \
kubernetes-cli

# Cloud Management and Configuration
brew install \
terraform   \
terraform-docs \
terragrunt  \
ansible

# Containers
brew install --cask docker

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
brew install \
ack \
git \
git-lfs \
jq \
yq \
htop \
kubectl \
p7zip \
pigz \
pv \
ssh-copy-id \
tree \
iproute2mac \
graphviz \
jsonnet

# Install global Python packages and tools
pip3 install cruft 

# Install Hugo
brew install hugo

fi

#######################################################################################################################
# GIT Config
#######################################################################################################################
if ! ${IGNORE_GIT} ; then
    printf "\n🚀 Installing git configuration\n"
    if [ ! -f "${HOME}/.gitconfig.local" ] ; then
        cp git/.gitconfig.local "${HOME}/.gitconfig.local"

        echo "Enter your full name";
        read -re var
        sed -i "s/GITNAME/${var}/" "${HOME}/.gitconfig.local"

        echo "Enter your email address";
        read -re var
        sed -i "s/GITEMAIL/${var}/" "${HOME}/.gitconfig.local"
    fi
fi

#######################################################################################################################
# DIR Structure
#######################################################################################################################
if ! ${IGNORE_DIR} ; then
    printf "\n🚀 Creating our folder structure\n"
    mkdir -p ~/Code/personal
    mkdir -p ~/Code/work
    mkdir -p ~/Code/work/ingenii-solutions
    mkdir -p ~/Code/work/ingenii-dev
    mkdir -p ~/Code/work/ingenii-corp
    mkdir -p ~/Code/research
    mkdir -p ~/Code/temp
fi

printf "\n✅ Complete\n"

zsh
