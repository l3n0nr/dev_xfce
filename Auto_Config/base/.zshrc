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
ENABLE_CORRECTION="true"

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
# export LANG=en_US.UTF-8

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

LOCAL_HOME='/home/lenonr'
LOCAL_WRT='10.0.0.87'
LOCAL_HDD='/media/lenonr/BACKUP/Arquivos/Filmes'

## Alias diversos
# alias para verificar os log's do servidor dev_web - apache
alias loginservidor='cat /var/log/apache2/access.log > /tmp/loginservidor.txt; kate /tmp/loginservidor.txt'

# alias para reiniciar swap
alias clearmemory='sudo /home/lenonr/Github/dev_scripts/Scripts/ShellScript/reboot/swap/reinicia_swap.sh'

# criando apelido para realizar backup do bashrc
alias backup_zsh='clear; cd $LOCAL_HOME; printf "[*] Realizado backup do zshrc\n"; cat .zshrc > /home/lenonr/Github/dev_xfce/Auto_Config/base/.zshrc ; printf "[+] Backup realizado! \n"'

# testando configuracao do teclado
setxkbmap -model abnt2 -layout br -variant abnt2

# calculando tempo lançamento foguetes
alias lancamento='/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/calc_lancamento.sh'

# autocompletar 
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# reiniciando o dropbox
alias reboot_dropbox="/home/lenonr/Github/dev_scripts/Scripts/ShellScript/dropbox/dropbox.sh"

# download videos - youtubedl
alias yt="/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/youtubedl.sh"

# git
alias repo="source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/auto_alias.sh"
alias push_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/push_git.sh"
alias pull_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/pull_git.sh"
alias status_git="/home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh"

home()
{	
  	clear 

  	# verificando se diretorio existe 
  	if [ -e "$LOCAL_HOME" ]; then 
	  	echo "########## LISTA DE ARQUIVOS ##########" 
	  	cd $LOCAL_HOME
	  	ls
	  	echo "######################################"
  	else
		echo "Diretorio '$LOCAL_HOME' nao existe"
	fi
}

wrt()
{
  	# verificando conexao
  	ping -c1 $LOCAL_WRT

  	clear 

  	# verificando se diretorio existe 
  	if [ $? -eq 0 ]; then
  		echo "########################"
  		printf "CONECTANDO AO SERVIDOR\n"
  		echo "########################\n"
	  	telnet $LOCAL_WRT
  	else
		echo "IP do servidor '$LOCAL_WRT' nao encontrado"
	fi
}

verificahd()
{	
  	clear 

  	# verificando se diretorio existe 
  	if [ -e "$LOCAL_HDD" ]; then 
	  	/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/verifica_midias.sh
  	else
		echo "Conecte o HDD ao computador!"
	fi
}