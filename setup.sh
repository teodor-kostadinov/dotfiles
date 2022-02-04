#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
set -e
set -f

printf "Configuration:\n"
IGNORE_OMZ=${IGNORE_OMZ:-false}
IGNORE_DOTFILES=${IGNORE_DOTFILES:-false}
IGNORE_BREW=${IGNORE_BREW:-false}
IGNORE_PIP=${IGNORE_PIP:-false}
IGNORE_GIT=${IGNORE_GIT:-false}
IGNORE_DIR=${IGNORE_DIR:-false}


if [[ ${REMOTE_CONTAINERS} ]] ; then
    IGNORE_BREW=true
    IGNORE_PIP=true
    IGNORE_DIR=true
    IGNORE_GIT=true
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
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended && \
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
        printf "\nRunning on intel\n" a
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
microsoft-edge \
spotify \
appcleaner \
visual-studio-code \
microsoft-azure-storage-explorer \
alfred \
drawio \
dash \
iterm2 \
obs \
aldente \

brew install \
skype \
postman

# CLI
brew install \
gh \
azure-cli \
awscli \
kubernetes-cli \
helm

# Infra as Code
brew install pulumi

# Containers
brew install --cask docker

# Languages and SDKs
brew install node@16
brew link node@16

brew install python@3.10 pipenv pipx
python3 --version | grep 3.9 && brew unlink python3 && brew link python@3.10 --force

# Install other useful binaries.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum" || true
brew install \
moreutils \
findutils \
 gnu-sed \
 gnu-tar \
grep \
openssh \
ack \
git \
git-lfs \
jq \
yq \
htop \
kubectl \
pv \
tree \
wget \
tmux \
ranger

# Misc
brew install hugo
fi

#----------------------------------------------------------------------------------------------------------------------
# PIP
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_PIP} ; then
   printf "\n🚀 Installing Python packages\n"

   pipx install cruft
   pipx install black
   pipx install mypy
   pipx install pylint
   pipx install flake8
   pipx install poetry
fi

#----------------------------------------------------------------------------------------------------------------------
# DIR Structure
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DIR} ; then
    printf "\n🚀 Creating our folder structure\n"
    mkdir -p ~/Code/personal
    mkdir -p ~/Code/work
    mkdir -p ~/Code/work/solutions
    mkdir -p ~/Code/work/dev
    mkdir -p ~/Code/work/corp
    mkdir -p ~/Code/work/deployments
    mkdir -p ~/Code/research
    mkdir -p ~/Code/temp
fi

printf "\n✅ Complete\n"

zsh
