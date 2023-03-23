printf "\n🚀 Installing homebrew packages\n"

BREW_PREFIX=$(brew --prefix)

# Standard Apps
brew install --cask brave-browser
brew install --cask firefox
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
brew install --cask obsidian
brew install postman
brew install dive
brew install calibre
brew install devutils

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

# # .NET
# brew install dotnet-sdk # sdk
# brew isntall dotnet # runtime

# dotnet tool uninstall --global dotnet-ef || true
# dotnet tool install --global -a arm64 dotnet-ef  || true

# dotnet tool uninstall --global dotnet-aspnet-codegenerator || true
# dotnet tool install --global -a arm64 dotnet-aspnet-codegenerator || true

# dotnet tool uninstall --global dotnet-svcutil || true
# dotnet tool install --global -a arm64 powershell || true

# dotnet tool uninstall --global Microsoft.Web.LibraryManager.Cli || true
# dotnet tool install --global -a arm64 Microsoft.Web.LibraryManager.Cli || true

# Python
brew install python@3.11 pipenv pipx poetry # Python and friends
python3 --version | grep 3.10 && brew unlink python3 && brew link python@3.11 --force

# Go
brew install go
go install github.com/cosmtrek/air@latest

# NodeJS
brew install node@18
npm install --location=global nodemon
npm install --location=global json-server

# Other Dev Tools
brew install supabase/tap/supabase

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