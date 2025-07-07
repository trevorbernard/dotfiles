alias ls='eza --group-directories-first --color=always'
alias ll='ls -lag'
alias lt='ls --tree'
alias gst='git status'
alias gdc='git diff --cached'

alias cd='z'

ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(
    history-search-forward
    history-search-backward
    history-beginning-search-forward
    history-beginning-search-backward
    fzf-history-widget
)

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"
