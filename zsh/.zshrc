export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mecha"
plugins=(git)
source $ZSH/oh-my-zsh.sh

source ~/.profile
source ~/.zsh_profile

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$([ -z "/home/mecha/.config" ] && printf %s "${HOME}/.nvm" || printf %s "/home/mecha/.config/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

alias vim="nvim"
alias n="nvim"
alias f="fzf-nvim"
alias h="harpoon"
alias lg="lazygit"
alias ldk="lazydocker"
alias l="exa -1 --icons"
alias la="exa -1a --icons"
alias ll="exa -lg --icons"
alias lla="exa -la --icons"
alias t="tree -L 1 -a -C"
alias tt="tree -L 2 -a -C"
alias hmm="h-m-m"
alias matrix="unimatrix -a -f -s 95" # :P
