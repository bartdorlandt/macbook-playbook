# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Based on lukerandall
# conditional logic and coloring
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# function my_git_prompt_info() {
#   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
#   echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
# }

function SERVER_PROMPT() {
    [[ -n $SERVER ]] && echo "%{$fg_bold[magenta]%}($SERVER)%{$reset_color%} "
}

function DATE() {
	date +%H:%M:%S
}

# conditional prompts
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Conditional-Substrings-in-Prompts
# %(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})
# if shell with elevated rights:
    # true: red color
    # false: green color
# %(!.#.$)
# if shell with elevated rights:
    # true: #
    # false: $

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%})%m%{$reset_color%} %{$fg_bold[blue]%}%~%{$reset_color%} $(my_git_prompt_info)%{$reset_color%}$ $(SERVER_PROMPT)
at $(DATE) %B%(!.#.$)%b '
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"
