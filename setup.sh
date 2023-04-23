#!/usr/bin/env bash

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
printf " - Ignore Dir Structure = %s\n" "${IGNORE_DIR}"

SCRIPTS_DIR="${HOME}/.dotfiles/scripts"
#----------------------------------------------------------------------------------------------------------------------
# OH MY ZSH (OMZ)
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_OMZ} ; then
    source ${SCRIPTS_DIR}/install_oh_my_zsh.sh
fi

#----------------------------------------------------------------------------------------------------------------------
# DOTFILES
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DOTFILES} ; then
    source ${SCRIPTS_DIR}/install_dotfiles.sh
fi

#----------------------------------------------------------------------------------------------------------------------
# HOMEBREW
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_BREW} ; then
    source ${SCRIPTS_DIR}/install_brew.sh
    source ${SCRIPTS_DIR}/install_apps_brew.sh
fi

#----------------------------------------------------------------------------------------------------------------------
# DIR Structure
#----------------------------------------------------------------------------------------------------------------------
if ! ${IGNORE_DIR} ; then
    printf "\n🚀 Creating our folder structure\n"
    mkdir -p ~/Projects
    mkdir -p ~/Customers
    mkdir -p ~/Temp
    mkdir -p ~/.go
    printf "Done\n"
fi

printf "\n✅ Complete\n"
