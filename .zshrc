export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

# zsh plugins
autoload -Uz compinit;compinit

git_current_branch() {
  git symbolic-ref --short HEAD 2> /dev/null || git rev-parse --short HEAD 2> /dev/null
}

typeset -g suggestion

_zsh_autosuggest_strategy_scripts() {
  if [ -f "package.json" ];then
    local begin=$(echo $1 | cut -d' ' -f1)

    if [[ "$begin" = (npm|yarn|pnpm|y) ]];then
	local input=$(echo $1 | sed -E 's/^(yarn|pnpm|npm|y) //')
	local script=$(jq -r '.scripts | keys_unsorted[]' package.json | grep -m 1 "$input")

	suggestion="${begin} ${script}"
    fi
  fi
}

source ~/.config/zsh-plugins/functions.zsh
source ~/.config/zsh-plugins/git.plugin.zsh
source ~/.config/zsh-plugins/yarn.plugin.zsh
source ~/.config/zsh-plugins/macos.plugin.zsh
source ~/.config/zsh-plugins/jovial.zsh-theme

alias vv=nvim
alias j=z
alias zed="/Applications/Zed.app/Contents/MacOS/cli"
alias d=docker
alias x="eza --icons=auto --classify=auto --color=auto --group-directories-first -hMol --changed --time-style=relative --no-permissions --git"
alias sz="source ~/.zshrc"
alias dco="docker-compose"

eval "$(zoxide init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

ZSH_AUTOSUGGEST_STRATEGY=(history scripts completion)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh

