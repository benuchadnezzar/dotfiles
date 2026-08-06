# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSHs compinit
autoload -Uz compinit && compinit

export DIRENV_LOG_FORMAT=""
eval "$(direnv hook zsh)"

# # append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# # initialise completions with ZSHs compinit
# autoload -Uz compinit && compinit
# source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# # append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# # initialise completions with ZSHs compinit
# autoload -Uz compinit && compinit
# eval "$(direnv hook zsh)"

alias cursor='cursor --reuse-window'

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Iris Autocomplete
eval "$(iris init zsh)"

# Hermes Agent — ensure ~/.local/bin is on PATH
export PATH="$HOME/.local/bin:$PATH"
# asdf version-manager shims
export PATH="${ASDR_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
