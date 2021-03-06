# If you come from bash you might have to change your $PATH.
export PATH=$HOME/cli:/usr/local/bin:$PATH

ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"

### POWERLEVEL9K
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor
export EDITOR='code'

### Aliases 
# For a full list of active aliases, run `alias`.

alias zshrc='code ~/.zshrc'
alias gitignore='code ~/.gitignore_global'
alias gitconfig='code ~/.gitconfig'
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
alias dockerclean='docker kill $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi $(docker images -a -q)'

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc


eval "$(direnv hook zsh)"

# rbenv
eval "$(rbenv init -)";

### Teads
function regenProdRedshiftToken(){
  token=$(teads-central redshift get-jdbc --cluster finance --group read-only)
  echo $token
  echo "db.finance-redshift.url=\"$token\"\ndb.finance-redshift.migration.placeholders.flywaySchema = \"flyway\"\ndb.finance-redshift.migration.placeholders.snapshotsSchema = \"snapshots\"\ndb.finance-redshift.migration.placeholders.datamartsSchema = \"datamarts\"\ndb.finance-redshift.migration.placeholders.salesforceSchema = \"salesforce\"\ndb.finance-redshift.migration.onStart = \"validate\"" > /Users/jbistoquet/dev/service-api-domains/domains/finance/finance-impl/src/main/resources/parameters.conf
}
function regenSandboxRedshiftToken(){
  token=$(teads-central redshift get-jdbc --cluster sandbox --group read-write)
  echo $token
  echo "db.finance-redshift.url=\"$token\"\ndb.finance-redshift.copyCredentials=\"aws_access_key_id=KEY;aws_secret_access_key=SECRET\"" > /Users/jbistoquet/dev/service-api-domains/domains/finance/finance-impl/src/main/resources/parameters.conf
}
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jbistoquet/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jbistoquet/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jbistoquet/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jbistoquet/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

alias crane='teads-central crane wrapper'
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jbistoquet/.sdkman"
[[ -s "/Users/jbistoquet/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jbistoquet/.sdkman/bin/sdkman-init.sh"

export PATH="/usr/local/opt/libpq/bin:$PATH"
