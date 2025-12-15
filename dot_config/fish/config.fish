fish_config theme choose kanagawa

# -------------------------------
# Environment variables
# -------------------------------
set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH
set -gx PAGER less
set -gx EDITOR nvim
set -gx SUDOEDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER 'nvim +Man!'
set -gx TERMINAL kitty
set -gx NVM_COMPLETION true
set -g fish_greeting

# -------------------------------
# Fisher auto-install + plugins
# -------------------------------
if status is-interactive && not functions --query fisher
    echo "Installing Fisher and plugins..."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher update
end

# -------------------------------
# Aliases
# -------------------------------
alias vi nvim
alias vv "NVIM_APPNAME=nvim-new nvim"
alias ll "eza -l --icons=auto --group-directories-first"
alias la "eza -lA --icons=auto --group-directories-first"
alias cat bat

# -------------------------------
# zoxide initialization
# -------------------------------
zoxide init fish --cmd cd | source
