printf "\n🚀 Installing dotfiles\n"
ln -sf "${HOME}/.dotfiles/shell/zshrc"           "${HOME}/.zshrc"
ln -sf "${HOME}/.dotfiles/shell/aliases"      "${HOME}/.aliases"
ln -sf "${HOME}/.dotfiles/shell/path"         "${HOME}/.path"
ln -sf "${HOME}/.dotfiles/shell/functions"    "${HOME}/.functions"
ln -sf "${HOME}/.dotfiles/shell/completion"   "${HOME}/.completion"
ln -sf "${HOME}/.dotfiles/git/.gitconfig"      "${HOME}/.gitconfig"
ln -sf "${HOME}/.dotfiles/git/.gitignore"      "${HOME}/.gitignore"