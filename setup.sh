#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
set -e
set -f

printf "Configuration:\n"
IGNORE_OMZ=${IGNORE_OMZ:-false}
IGNORE_DOTFILES=${IGNORE_DOTFILES:-false}
IGNORE_BREW=${IGNORE_BREW:-false}
IGNORE_NPM=${IGNORE_NPM:-false}
IGNORE_PIP=${IGNORE_PIP:-false}
IGNORE_GIT=${IGNORE_GIT:-false}
IGNORE_DIR=${IGNORE_DIR:-false}


if [[ ${REMOTE_CONTAINERS} ]] ; then
    IGNORE_BREW=true
fi

printf " - IGNORE_OMZ       = %s\n" "${IGNORE_OMZ}"
printf " - IGNORE_DOTFILES  = %s\n" "${IGNORE_DOTFILES}"
printf " - IGNORE_GIT       = %s\n" "${IGNORE_GIT}"
printf " - IGNORE_BREW      = %s\n" "${IGNORE_BREW}"

#----------------------------------------------------------------------------------------------------------------------
# OH MY ZSH (OMZ)
#----------------------------------------------------------------------------------------------------------------------
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

#----------------------------------------------------------------------------------------------------------------------
# DOTFILES
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DOTFILES} ; then
printf "\n🚀 Installing dotfiles\n"
ln -sf "$(pwd)/zsh/zshrc"           "${HOME}/.zshrc"
ln -sf "$(pwd)/common/aliases"      "${HOME}/.aliases"
ln -sf "$(pwd)/common/path"         "${HOME}/.path"
ln -sf "$(pwd)/common/functions"    "${HOME}/.functions"
ln -sf "$(pwd)/git/.gitconfig"      "${HOME}/.gitconfig"
ln -sf "$(pwd)/git/.gitignore"      "${HOME}/.gitignore"
fi

#----------------------------------------------------------------------------------------------------------------------
# HOMEBREW
#----------------------------------------------------------------------------------------------------------------------
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
brew install --cask microsoft-edge
brew install --cask spotify
brew install --cask appcleaner
brew install --cask visual-studio-code
brew install --cask microsoft-azure-storage-explorer 
brew install --cask alfred
brew install --cask drawio
brew install --cask dash
brew install --cask iterm2
brew install --cask typora
brew install skype

# CLI
brew install gh
brew install azure-cli
brew install awscli
brew install kubernetes-cli

# Infra as Code
brew install terraform
brew install terraform-docs
brew install terragrunt
brew install ansible
brew install pulumi
brew tap pulumi/tap
brew install pulumictl

# Containers
brew install --cask docker

# Languages and SDKs
brew install go
brew install node@14
brew install python@3.9

# Install other useful binaries.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum" || true
brew install moreutils
brew install findutils
brew install gnu-sed
brew install gnu-tar
brew install gnupg
brew install grep
brew install openssh
brew install ack
brew install git
brew install git-lfs
brew install jq
brew install yq
brew install htop
brew install kubectl
brew install pv
brew install ssh-copy-id 
brew install tree
brew install graphviz
brew install wget
brew install fetch 
brew install dust
brew install duf
brew install fd
brew install ripgrep
brew install ag
brew install fzf
brew install choose
brew install sd
brew install tldr
brew install glances
brew install procs
brew install gomplate

# Misc
brew install hugo

fi

#----------------------------------------------------------------------------------------------------------------------
# NPM
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_NPM} ; then
    printf "\n🚀 Installing NPM packages\n"

    npm install -g @angular/cli
    npm install -g typescript
fi

#----------------------------------------------------------------------------------------------------------------------
# PIP
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_PIP} ; then
    printf "\n🚀 Installing Python packages\n"

    pip3 install cruft
fi

#----------------------------------------------------------------------------------------------------------------------
# GIT Config
#----------------------------------------------------------------------------------------------------------------------
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

#----------------------------------------------------------------------------------------------------------------------
# DIR Structure
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DIR} ; then
    printf "\n🚀 Creating our folder structure\n"
    mkdir -p ~/Code/personal
    mkdir -p ~/Code/work
    mkdir -p ~/Code/work/ingenii-solutions
    mkdir -p ~/Code/work/ingenii-dev
    mkdir -p ~/Code/work/ingenii-corp
    mkdir -p ~/Code/work/ingenii-deployments
    mkdir -p ~/Code/research
    mkdir -p ~/Code/temp
fi

printf "\n✅ Complete\n"

zsh
