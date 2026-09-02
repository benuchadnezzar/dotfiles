# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSHs compinit
autoload -Uz compinit && compinit

export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Iris Autocomplete
eval "$(iris init zsh)"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"

# asdf version-manager shims
export PATH="${ASDR_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Disable oh-my-zsh's automatic terminal titling, which
# conflicts with the same behavior in tmux/tmuxp
export DISABLE_AUTO_TITLE='true'

# Starship
eval "$(starship init zsh)"
