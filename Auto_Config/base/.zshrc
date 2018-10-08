# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/lenonr/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANGUAGE=en_US.UTF-8  
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# autocompletar 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# testando configuracao do teclado
#setxkbmap -model abnt2 -layout br -variant abnt2
setxkbmap -model pc105 -layout br -variant abnt2

# git
alias repo="source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/auto_alias.sh"
alias push_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/push_git.sh"
alias pull_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/pull_git.sh"
alias status_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh"
alias check_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/check_push.sh"

# outros
## limpa memoria 
alias clearmemory='su root /home/lenonr/Github/dev_sysadmin/others/reboot_swap.sh'

## backup do arquivo zshrc
alias backup_zsh='/home/lenonr/Github/dev_sysadmin/others/backup_zsh.sh'

## reinicia dropbox
alias reboot_dropbox='/home/lenonr/Github/dev_sysadmin/others/dropbox.sh'

## calcula lancamento do foguetes
alias lancamento='/home/lenonr/Github/dev_sysadmin/others/lancamento.sh'

## chama sublime via alias
# alias subl="/opt/sublime_text/sublime_text"
alias subl="/snap/bin/sublime-text.subl"

## mostra informacoes do sistema
alias sistema="/home/lenonr/Github/dev_sysadmin/others/sistema.sh"

## realiza backup via dispositivo externo
alias verificahd="/home/lenonr/Github/dev_sysadmin/others/hdd.sh"

## chama telnet roteador
alias wrt="/home/lenonr/Github/dev_sysadmin/others/wrt.sh"

## verificando maiores arquivos da particao
alias check_sizefile="/home/lenonr/Github/dev_sysadmin/others/check_sizefile.sh"

## checa servicos iniciados no sistema
alias check_services="/home/lenonr/Github/dev_sysadmin/others/check_services.sh"

## executa arquivo pomodo
alias pomodoro="/home/lenonr/Github/dev_sysadmin/others/pomodoro.sh"

## zoeira da DC
alias dc="echo 'Prefiro a Marvel...'"

## chama home personalizado
home()
{	
    local_home='/home/lenonr'

  	clear 

  	# verificando se diretorio existe 
  	if [ -e "$local_home" ]; then 
	  	echo "########## LISTA DE ARQUIVOS ##########" 
	  	cd $local_home
	  	ls
	  	echo "######################################"
  	else
		echo "Diretorio '$local_home' nao existe"
	fi
}

## definindo o idioma automaticamente
LANGUAGE=en_US.UTF-8
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8