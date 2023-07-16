function pathcumcision {
  PS1="%{%K{#333333}%} "

  if [[ $PWD == "/" ]]; then
    PS1+="%B/"
  else
    if [[ $PWD == $HOME ]]; then
      PS1+="%B~"
    else
      local head=$(pwd -P | sed "s|^$HOME|~|" | sed -E 's|/(\.+?[^/])[^/]*|/\1|g; s|/[^/]+$||')
      local hail=$(pwd -P | xargs basename)
      PS1+="%{%F{#aaaaaa}%}$head/%f%B$hail"
    fi
  fi

  PS1+=" %f%{%F{#333333}%}$(git_prompt_info)%k%f%b "
}

precmd_functions+=(pathcumcision)

ZSH_THEME_GIT_PROMPT_PREFIX="%K{#111111}%f \ue727 "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#ddbb44}%B🞱"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%F{#111111} "
