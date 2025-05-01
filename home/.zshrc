export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME="viridescent"
plugins=(git ssh-agent)
source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $(thefuck --alias)

export FZF_DEFAULT_OPTS="--color=fg:$VIRID_FG,bg+:$VIRID_DARK,fg+:$VIRID_BRIGHT_MINT,pointer:$VIRID_BRIGHT_MINT,prompt:$VIRID_WHITE"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

alias n="nvim"
alias f="fzfn"
alias l="eza -1 --icons --group-directories-first"
alias la="eza -1a --icons --group-directories-first"
alias ll="eza -lga --icons --group-directories-first"
alias tree="exa -T"
alias tt="exa -T -L 3 -lha"
alias matrix="unimatrix -a -f -s 95" # hehe
alias lgit="lazygit"
alias ldock="lazydocker"
alias tam="tmux -u new-session -A -s main"
alias fp=". fp"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# pnpm
export PNPM_HOME="/home/miguel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
