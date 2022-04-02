#!/usr/bin/env bash

#----------------------------------------------------------------------------------------------------------------------

# Bash Options
# Ref: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
set -e # exit immediately if any command returns a non-zero exit code
set -f # disable filename expansion (globbing)

printf "
 ______   __  __        _____     ______     ______   ______   __     __         ______     ______    
/\__  _\ /\ \/ /       /\  __-.  /\  __ \   /\__  _\ /\  ___\ /\ \   /\ \       /\  ___\   /\  ___\   
\/_/\ \/ \ \  _'-.     \ \ \/\ \ \ \ \/\ \  \/_/\ \/ \ \  __\ \ \ \  \ \ \____  \ \  __\   \ \___  \  
   \ \_\  \ \_\ \_\     \ \____-  \ \_____\    \ \_\  \ \_\    \ \_\  \ \_____\  \ \_____\  \/\_____\ 
    \/_/   \/_/\/_/      \/____/   \/_____/     \/_/   \/_/     \/_/   \/_____/   \/_____/   \/_____/ 
\n"

printf "Configuration:\n"

IGNORE_OMZ=${IGNORE_OMZ:-false}
IGNORE_DOTFILES=${IGNORE_DOTFILES:-false}
IGNORE_BREW=${IGNORE_BREW:-false}
IGNORE_PIP=${IGNORE_PIP:-false}
IGNORE_DIR=${IGNORE_DIR:-false}


# VSCode sets the REMOTE_CONTAINERS env inside a devcontainer
# We only need a subset of features from the dotfiles inside the devcontainer
if [[ ${REMOTE_CONTAINERS} ]] ; then
    IGNORE_BREW=true
    IGNORE_DIR=true
fi

printf " - Ignore Oh My Zsh     = %s\n" "${IGNORE_OMZ}"
printf " - Ignore Dotfiles      = %s\n" "${IGNORE_DOTFILES}"
printf " - Ignore Homebrew      = %s\n" "${IGNORE_BREW}"

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

        printf "Done\n"
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
ln -sf "$(pwd)/common/completion"   "${HOME}/.completion"
ln -sf "$(pwd)/git/.gitconfig"      "${HOME}/.gitconfig"
ln -sf "$(pwd)/git/.gitignore"      "${HOME}/.gitignore"
printf "Done\n"
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
    printf "Done\n"
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
aldente

brew install \
skype \
postman

# CLI
brew install \
gh \
azure-cli \
awscli \
kubectl \
helm

# Infrastructure
brew install pulumi terraform terragrunt terraform-docs

# Containers
brew install --cask docker

# Programming Languages

# DotNET
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --architecture x64
$HOME/.dotnet/dotnet tool install --global dotnet-ef

# Go
brew install go golang-migrate

# JavaScript/Node
brew install node@16

# Python
brew install python@3.10 pipenv pipx poetry # Python and friends
python3 --version | grep 3.9 && brew unlink python3 && brew link python@3.10 --force



# Other Tools
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
pv \
tree \
wget \
tmux \
ranger \
hey

printf "Done\n"
fi

#----------------------------------------------------------------------------------------------------------------------
# DIR Structure
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DIR} ; then
    printf "\n🚀 Creating our folder structure\n"
    mkdir -p ~/Code/personal/projects
    mkdir -p ~/Code/personal/research
    mkdir -p ~/Code/work/solutions
    mkdir -p ~/Code/work/dev
    mkdir -p ~/Code/work/corp
    mkdir -p ~/Code/work/deployments
    mkdir -p ~/Code/work/research
    mkdir -p ~/Code/temp
    mkdir -p ~/Lib/go
    printf "Done\n"
fi

printf "\n✅ Complete\n"

zsh
