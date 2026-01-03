export ZSH="$HOME/.config/oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

ZSH_THEME="viridescent"
plugins=(git ssh-agent zsh-autosuggestions zsh-history-substring-search fast-syntax-highlighting)

fpath+="${ZSH_CUSTOM}/plugins/zsh-completions/src"

autoload -U compinit bashcompinit zmv
compinit
bashcompinit

source "$ZSH/oh-my-zsh.sh"

export DEV_PATH="$HOME/dev"
export DOTFILES_PATH="$DEV_PATH/personal/.dotfiles/"
export PATH="/$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
export MANPAGER="less -isg"
export FZF_DEFAULT_OPTS="--reverse --color=fg:$VIRID_FG,bg+:$VIRID_DARK,fg+:$VIRID_BRIGHT_MINT,hl+:$VIRID_BRIGHT_RED,pointer:$VIRID_BRIGHT_MINT,prompt:$VIRID_WHITE,border:$VIRID_MINT"

# copy command buffer to system clipboard
copy-cmd-buffer() {
    echo -n $BUFFER | wl-copy
    zle -M "Copied to clipboard"
}
zle -N copy-cmd-buffer
bindkey '^xc' copy-cmd-buffer

hash -d dev="$DEV_PATH"

alias tam="tmux -u new-session -A -s main"
alias ll="eza -lga --icons --group-directories-first --color=always --git --git-ignore"
alias l="eza -g --icons --group-directories-first --color=always --git --git-ignore"
alias t="eza -T -L 2 --icons --group-directories-first --color=always --git --git-ignore"
alias tt="eza -T -L 3 -lha --icons --group-directories-first --color=always --git --git-ignore"
alias n="nvim"
alias f="fzfn"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias open='xdg-open'

alias -g C='| wl-copy'

# go
export PATH="$HOME/go/bin:$PATH"

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [ -f "$HOME/.env" ]; then
    source "$HOME/.env"
fi

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
