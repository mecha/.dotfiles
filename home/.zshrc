export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

ZSH_THEME="viridescent"
plugins=(git ssh-agent zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)

fpath+="${ZSH_CUSTOM}/plugins/zsh-completions/src"

autoload -U compinit bashcompinit
compinit
bashcompinit

source "$ZSH/oh-my-zsh.sh"

# source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export FZF_DEFAULT_OPTS="--color=fg:$VIRID_FG,bg+:$VIRID_DARK,fg+:$VIRID_BRIGHT_MINT,pointer:$VIRID_BRIGHT_MINT,prompt:$VIRID_WHITE"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

alias tam="tmux -u new-session -A -s main"
alias ll="eza -lga --icons --group-directories-first"
alias n="nvim"
alias f="fzfn"
alias tt="exa -T -lha"
alias matrix="unimatrix -a -f -s 95" # :P
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end

# pnpm
export PNPM_HOME="/home/miguel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
