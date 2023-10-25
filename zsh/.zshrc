export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mecha"
plugins=(git)
source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $(keychain --eval --agents ssh --quick --quiet)
eval $(thefuck --alias)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

alias n="nvim"
alias f="fzfn"
alias h="harpoon"
alias lg="lazygit"
alias ldk="lazydocker"
alias l="eza -1 --icons --group-directories-first"
alias la="eza -1a --icons --group-directories-first"
alias ll="eza -lga --icons --group-directories-first"
alias lla="eza -la --icons"
alias t="tree -L 1 -a -C"
alias tt="tree -L 2 -a -C"
alias hmm="h-m-m"
alias matrix="unimatrix -a -f -s 95" # :P
alias tam="tmux -u new-session -A -s main"

# pnpm
export PNPM_HOME="/home/miguel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
