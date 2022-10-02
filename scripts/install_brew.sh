PATH=$PATH:/opt/homebrew/bin

if ! brew --version ; then
  printf "\n🚀 Installing homebrew\n"
  xcode-select  --install
  sudo mkdir -p /opt/homebrew
  sudo chown -R "$(whoami)":wheel /opt/homebrew
  curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /opt/homebrew
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  printf "\n🚀 Homebrew already installed. Running brew update\n"
  brew update
  brew upgrade
fi