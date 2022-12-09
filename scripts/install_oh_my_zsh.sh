if [ -d "${HOME}/.oh-my-zsh" ]; then
    printf "oh-my-zsh is already installed\n"
else
    printf "\n🚀 Installing oh-my-zsh\n"        
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended && \
    
    # Fix Oh My Zsh Permissions
    sudo chown -R $(whoami) /usr/local/share/zsh \
    && sudo chmod u+w /usr/local/share/zsh \
    && sudo chown -R $(whoami) /usr/local/share/zsh/site-functions \
    && sudo chmod u+w /usr/local/share/zsh/site-functions \
    && sudo chmod -R 755 /usr/local/share/zsh
    
    printf "Done\n"
fi