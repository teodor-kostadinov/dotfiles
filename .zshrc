# ZSH Path
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="cloud"

# ZSH Plugins
plugins=(git zsh-autosuggestions)

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load additional dotfiles
for file in ~/.{path,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
