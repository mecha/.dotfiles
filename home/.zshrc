#==============================================================================#
# ENV VARS                                                                     #
#==============================================================================#

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export GIT_EDITOR="nvim"
export MANPAGER="less -isg"

export DEV_PATH="$(realpath "$HOME/dev")"
export DEV_TEMPLATES_PATH="$DEV_PATH/devtools/templates"
export DOTFILES_PATH="$DEV_PATH/personal/.dotfiles"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZSH="$XDG_CONFIG_HOME/zsh"
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export ANDROID_HOME=$HOME/Android/Sdk
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export PNPM_HOME="$HOME/.local/share/pnpm"

export PATH="$HOME/go/bin:$PATH"
export PATH="$PNPM_HOME:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export FZF_DEFAULT_OPTS="--reverse"

export GUM_CONFIRM_SHOW_HELP="0"

if [ -f "$HOME/.env" ]; then
    source "$HOME/.env"
fi

#==============================================================================#
# THEME & PLUGINS                                                              #
#==============================================================================#

source "$DOTFILES_PATH/scripts/viridescent.zsh"

plugins=(
    $ZSH/plugins/zsh-completions/zsh-completions.plugin.zsh
    $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    $ZSH/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
)

for plugin in $plugins; do
    if [ -f "$plugin" ]; then
        source "$plugin"
    else
        echo "cannot find plugin: $plugin"
    fi
done

#==============================================================================#
# KEYBINDS                                                                     #
#==============================================================================#

# emacs mode
bindkey -e

# copy command buffer to system clipboard
copy-cmd-buffer() {
    echo -n $BUFFER | wl-copy
    zle -M "Copied to clipboard"
}
zle -N copy-cmd-buffer
bindkey '^xc' copy-cmd-buffer

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#==============================================================================#
# ALIASES                                                                      #
#==============================================================================#

hash -d dev="$DEV_PATH"
hash -d dot="$DOTFILES_PATH"
hash -d config="$XDG_CONFIG_HOME"

alias tam="tmux -u new-session -A -s main"
alias tps="project open"
alias ll="eza -lga --icons --group-directories-first --color=always --git --git-ignore"
alias l="eza -g --icons --group-directories-first --color=always --git --git-ignore"
alias t="eza -T -L 2 --icons --group-directories-first --color=always --git --git-ignore"
alias tt="eza -T -L 3 -lha --icons --group-directories-first --color=always --git --git-ignore"
alias n="nvim"
alias f="fzfn"
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias open='xdg-open'

alias -g C='| wl-copy'

alias -s md='bat'
alias -s txt='bat'
alias -s json='jless'
alias -s yaml='jless'
alias -s yml='jless'
alias -s go="$EDITOR"
alias -s php="$EDITOR"
alias -s js="$EDITOR"
alias -s ts="$EDITOR"
alias -s xml="$EDITOR"
alias -s sqlite="sqlite3"
alias -s pdf="xdg-open"
alias -s html="xdg-open"
alias -s jpg="xdg-open"
alias -s png="xdg-open"
alias -s gif="xdg-open"
alias -s mp4="xdg-open"
alias -s mkv="xdg-open"
alias -s mov="xdg-open"

#==============================================================================#
# MISCELLANEOUS                                                                #
#==============================================================================#

setopt appendhistory
fpath+="$ZSH/plugins/zsh-completions/src"

autoload -U compinit bashcompinit zmv
compinit
bashcompinit

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
