#!/usr/bin/env bash

cd; curl -#L https://github.com/teodor-kostadinov/dotfiles/tarball/main | tar -xzv --strip-components 1 --exclude={README.md,LICENSE,bootstrap,.gitignore,setup.sh}; source .zshrc