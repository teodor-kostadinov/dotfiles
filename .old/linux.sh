#!/usr/bin/env bash

# Ask for sudo password beforehand, so we don't get prompted during the execution of the script
sudo -v

################################################################################################################################################
# Updates
################################################################################################################################################
sudo apt update -y && sudo apt upgrade -y

################################################################################################################################################
# Core Tools
################################################################################################################################################

# Unzip
sudo apt install unzip -y

# Make
sudo apt install make -y

# Whois
sudo apt install whois -y

# jq
sudo apt install jq -y

################################################################################################################################################
# Dev Tools
################################################################################################################################################

# Hashicorp Tools
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# Terraform, Packer
sudo apt install terraform packer -y

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install && \
rm -rf ./aws && rm -rf awscliv2.zip

# Azure CLI
sudo apt install ca-certificates curl apt-transport-https lsb-release gnupg -y && \
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
AZ_REPO=$(lsb_release -cs) && \
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list && \
sudo apt-get update && \
sudo apt-get install azure-cli -y

# Powershell Core
sudo apt-get install -y wget apt-transport-https software-properties-common && \
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb && \
sudo dpkg -i packages-microsoft-prod.deb && \
sudo apt-get update && \
sudo add-apt-repository universe && \
sudo apt-get install -y powershell && \
rm -rf packages-microsoft-prod.deb

# Go
sudo apt-get install software-properties-common gpg && \
sudo add-apt-repository ppa:longsleep/golang-backports && \
sudo apt-get update -y && \
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 52B59B1571A79DBC054901C0F6BC817356A3D45E && \
sudo apt-get install golang-go -y

# Python 3
sudo apt install python3-pip -y

################################################################################################################################################
# Shell (ZSH)
################################################################################################################################################

# Install ZSH
sudo apt install zsh -y

# Install OhMyZSH
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
