fish_config theme choose "Rosé Pine"

# Set environment variables
set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH
set -gx PAGER bat
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'
set -gx TERMINAL kitty
set -gx NVM_COMPLETION true
set -g fish_greeting

# Aliases
alias vi "nvim"
alias ll "eza -l --icons=auto --group-directories-first"
alias la "eza -lA --icons=auto --group-directories-first"
alias cat "bat"

# zoxide initialization
zoxide init fish --cmd cd | source
