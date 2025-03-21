# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Environment variables
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Keybinds
bindkey -e
bindkey '^Y' autosuggest-accept

# Aliases
alias vi="nvim"
alias vim="nvim"
alias ll="lsd -lA"
alias cat="bat"

# Configs
alias zshconfig="nvim ~/.zshrc"
alias reload="exec zsh"

# Git 
alias gpo="git push origin"
alias gc="git commit"
alias ga="git add"
alias gs="git status"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
source /usr/share/nvm/init-nvm.sh

# Random fuckery
cool() {
    case "$1" in
        on)
            echo 100 | sudo tee /sys/class/hwmon/hwmon5/pwm1 > /dev/null
            echo 80 | sudo tee /sys/class/hwmon/hwmon5/pwm2 > /dev/null
            echo "Fans on"
            ;;
        off)
            echo 0 | sudo tee /sys/class/hwmon/hwmon5/pwm1 > /dev/null
            echo 0 | sudo tee /sys/class/hwmon/hwmon5/pwm2 > /dev/null
            echo "Fans off"
            ;;
        *)
            echo "Usage: cool [on | off]"
            ;;
    esac
}

webdev() {
  if [[ -z "$1" ]]; then
    echo "Usage: webdev <project_name>"
    return 1
  fi
  local PROJECT_DIR="$HOME/Documents/projects/$1"
  if [[ ! -d "$PROJECT_DIR" ]]; then
    echo "Error: Directory '$PROJECT_DIR' does not exist!"
    return 1
  fi
  local SESSION_NAME="$1"
  tmux new-session -d -s "$SESSION_NAME" -c "$PROJECT_DIR" -n js
  tmux new-window -t "$SESSION_NAME":2 -c "$PROJECT_DIR" -n html
  tmux new-window -t "$SESSION_NAME":3 -c "$PROJECT_DIR" -n cmd
  tmux split-window -h -t "$SESSION_NAME":cmd -c "$PROJECT_DIR"
  tmux attach-session -t "$SESSION_NAME"
}
