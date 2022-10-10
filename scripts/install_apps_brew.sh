printf "\n🚀 Installing homebrew packages\n"

BREW_PREFIX=$(brew --prefix)

# Standard Apps
brew install --cask brave-browser
brew install --cask bitwarden
brew install --cask spotify
brew install --cask appcleaner
brew install --cask visual-studio-code
brew install --cask alfred
brew install --cask drawio
brew install --cask dash
brew install --cask iterm2
brew install --cask obs
brew install --cask grammarly-desktop
brew install --cask jetbrains-toolbox
brew install --cask privatevpn
brew install --cask selfcontrol
brew install --cask vlc
brew install --cask piezo
brew install postman
brew install dive
brew install calibre

# CLI
brew install gh
brew install azure-cli
brew install awscli
brew install kubectl
brew install helm
brew install derailed/k9s/k9s
brew tap aws/tap
brew install aws-sam-cli

# Infrastructure
brew install pulumi
brew install terraform
brew install terragrunt
brew install terraform-docs
brew install terrascan
brew install trivy

# Containers
brew install --cask docker

# .NET
brew install dotnet-sdk
dotnet tool install --global -a arm64 dotnet-ef  || true
dotnet tool install --global -a arm64 dotnet-aspnet-codegenerator || true

# Python
brew install python@3.10 pipenv pipx poetry # Python and friends
python3 --version | grep 3.9 && brew unlink python3 && brew link python@3.10 --force

# Go
brew install go

# NodeJS
brew install node@16
npm install --location=global nodemon

# Other Tools
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum" || true
brew install moreutils
brew install findutils
brew install gnu-sed
brew install gnu-tar
brew install grep
brew install openssh
brew install ack
brew install git
brew install git-lfs
brew install jq
brew install yq
brew install htop
brew install pv
brew install tree
brew install wget
brew install tmux
brew install hey
brew install mtr
brew install hugo

# Fonts
brew tap homebrew/cask-fonts && brew install --cask font-roboto-mono-nerd-font
brew tap homebrew/cask-fonts && brew install --cask font-ubuntu-nerd-font
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font