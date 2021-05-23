
################################################################################################################################################
# Settings
################################################################################################################################################

# Show file extensions
Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty . HideFileExt "0"
Pop-Location

# TODO: Disable show recently used files in Quick Access
# TODO: Disable show frequently used folders in Quick Access
# TODO: Change from Quick Access to This PC
# TODO: Night light - set to 30%, sunset to sunrise (location required)

################################################################################################################################################
# Apps
################################################################################################################################################

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

################################################################################################################################################
# Standard Apps
################################################################################################################################################

# Greenshot
choco install greenshot -y

# 7zip
choco install 7zip.install -y

# Gimp
choco install gimp -y

# Paint.NET
choco install paint.net -y

# Power Toys
choco install powertoys -y

# Draw IO
choco install drawio -y

# Typora
choco install typora -y

# Spotify
# choco install spotify -y (broken)
choco install spotify --ignore-checksums -y

################################################################################################################################################
# Dev Apps
################################################################################################################################################

# Velocity
choco install velocity -y

# Windows Terminal
choco install microsoft-windows-terminal -y

# VSCode
choco install vscode -y

# JetBrains GoLand
choco install goland -y

# Notepad ++
choco install notepadplusplus.install -y

# Git
choco install git.install -y

# Sysinternals
choco install sysinternals -y

# Powershell Core
choco install powershell-core -y

# Docker
choco install docker-desktop -y

################################################################################################################################################
# WSL
################################################################################################################################################

# Enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine Platform
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Install WSL Kernel
# TODO: https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi

# Reboot
# TODO: Reboot and continue.

# Set WSL to version 2
#wsl --set-default-version 2
