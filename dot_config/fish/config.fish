fish_config theme choose "Rosé Pine"

# Set environment variables
set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH
set -gx PAGER bat
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'
set -gx TERMINAL kitty
set -gx NVM_COMPLETION true

# Aliases
alias vi "nvim"
alias ll "eza -l --icons=auto"
alias cat "bat"
alias cz "chezmoi"

# Git aliases
alias gpo "git push origin"
alias gc "git commit"
alias ga "git add"
alias gs "git status"
alias gd "git diff"

# zoxide initialization
zoxide init fish --cmd cd | source
