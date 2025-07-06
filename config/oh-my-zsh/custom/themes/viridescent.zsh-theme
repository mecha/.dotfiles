#! /bin/env zsh

export VIRID_BG="#2c3333"
export VIRID_FG="#e9f5db"
export VIRID_BLACK="#101e18"
export VIRID_WHITE="#ECEFEB"
export VIRID_LIGHT_GRAY="#bbc2cf"
export VIRID_DARK_GRAY="#42464d"
export VIRID_GRAY='#818781'
export VIRID_DARK="#232828"
export VIRID_SEL="#4e5f3d"
export VIRID_DIM="#515b4c"
export VIRID_BRIGHT_MINT="#95d5b2"
export VIRID_MINT="#84a98c"
export VIRID_DARK_MINT="#48534a"
export VIRID_BRIGHT_GREEN="#a1d858"
export VIRID_GREEN="#81af58"
export VIRID_DARK_GREEN="#283120"
export VIRID_BRIGHT_RED="#ff6676"
export VIRID_RED="#e85362"
export VIRID_DARK_RED="#3e2829"
export VIRID_YELLOW="#e3ca65"
export VIRID_DARK_YELLOW="#3c3828"
export VIRID_PURPLE="#a09af8"
export VIRID_DARK_PURPLE="#333242"
export VIRID_ICE="#88c1e9"
export VIRID_DARK_ICE="#2e404d"
export VIRID_CORAL="#e07870"
export VIRID_ORANGE="#f99a47"
export VIRID_BLUE="#409cdc"
export VIRID_CYAN="#4adaf7"
export VIRID_PINK="#de6bdb"
export VIRID_TAN="#d2b487"

function virid_prompt {
    line=$(seq -s ┈ $COLUMNS | tr -d '[:digit:]')
    PROMPT=$'\n'"%F{$VIRID_MINT}$line"$'\r'"┌┈[%F{$VIRID_MINT}"

    if [[ $PWD == "/" ]]; then
        PROMPT+="/"
    elif [[ $PWD == $HOME ]]; then
        PROMPT+="~"
    else
        local head=$(pwd -P | sed "s|^$HOME|~|" | sed -E 's|/(\.+?[^/])[^/]*|/\1|g; s|/[^/]+$||')
        local tail=$(basename "$(pwd -P)")
        PROMPT+="$head/%F{$VIRID_FG}$tail"
    fi

    PROMPT+="%F{$VIRID_MINT}"
    PROMPT+="]┈"

    if [[ "$JOURNAL_SHELL" == "1" ]]; then
        PROMPT+="%F{$VIRID_PURPLE}"
        PROMPT+="[]"
    fi

    PROMPT+="$(git_prompt_info)" # TODO: not working
    PROMPT+=$'\n'"%F{$VIRID_MINT}└┈ %f"
}

precmd_functions+=(virid_prompt)

# ZSH_THEME_GIT_PROMPT_PREFIX="┈┈[%F{$VIRID_YELLOW} "
# ZSH_THEME_GIT_PROMPT_SUFFIX="%F{$VIRID_DIM}]"
# ZSH_THEME_GIT_PROMPT_DIRTY="*"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
