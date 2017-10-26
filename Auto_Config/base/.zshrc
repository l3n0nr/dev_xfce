# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/lenonr/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"

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
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
plugins=(git)

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

## Aliases (apelidos) diversos
# entrando no diretório mais usados
alias dev_web='clear && echo "########## LISTA DE ARQUIVOS ##########" && cd /var/www/html/dev_web && ls && echo "######################################"'
alias dev_xfce='clear && echo "########## LISTA DE ARQUIVOS ##########" && cd /home/lenonr/Github/dev_xfce && ls && echo "######################################"'
alias dev_scripts='clear && echo "########## LISTA DE ARQUIVOS ##########" && cd /home/lenonr/Github/dev_scripts && ls && echo "######################################"'
alias dev_sysadmin='clear && echo "########## LISTA DE ARQUIVOS ##########" && cd /home/lenonr/Github/dev_sysadmin && ls && echo "######################################"'
alias home='clear && echo "########## LISTA DE ARQUIVOS ##########" && cd /home/lenonr && ls && echo "######################################"'

#   criando atalhos para atualizar os diretorios do github 
alias pull_git='clear; echo "[*] Verificando Diretório dev_xfce" && cd /home/lenonr/Github/dev_xfce && git pull && echo && echo "[*] Verificando Diretório dev_scripts" && cd /home/lenonr/Github/dev_scripts && git pull && echo && echo "[*] Verificando Diretório dev_web" && cd /var/www/html/dev_web && git pull && echo && echo "[*] Verificando Diretório dev_sysadmin" && cd /home/lenonr/Github/dev_sysadmin && git pull && echo && cd /home/lenonr'

alias push_git='clear; echo "[*] Verificando Diretório dev_xfce" && cd /home/lenonr/Github/dev_xfce && git push && echo && echo "[*] Verificando Diretório dev_scripts" && cd /home/lenonr/Github/dev_scripts && git push && echo && echo "[*] Verificando Diretório dev_web" && cd /var/www/html/dev_web && git push && echo && echo "[*] Verificando Diretório dev_sysadmin" && cd /home/lenonr/Github/dev_sysadmin && git push && echo && cd /home/lenonr'

alias status_git='clear; echo "[*] Verificando Diretório dev_xfce" && cd /home/lenonr/Github/dev_xfce && git status && echo && echo "[*] Verificando Diretório dev_scripts" && cd /home/lenonr/Github/dev_scripts && git status && echo && echo "[*] Verificando Diretório dev_web" && cd /var/www/html/dev_web && git status && echo && echo "[*] Verificando Diretório dev_sysadmin" && cd /home/lenonr/Github/dev_sysadmin && git status && echo && cd /home/lenonr'             

# criando apelido para conectar ao roteador DD-WRT
alias wrt='telnet 10.0.0.87'

# criando apelido para limpar a memória
alias clearmemory='sudo /home/lenonr/Github/dev_scripts/Scripts/ShellScript/reboot/swap.sh'

# criando apelido para realizar backup dos arquivos no HD
alias verificahd='/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/verifica_midias.sh'

# criando apelido para verificar os log's do servidor dev_web
alias loginservidor='cat /var/log/apache2/access.log > /tmp/loginservidor.txt; kate /tmp/loginservidor.txt'

# criando apelido para realizar backup do bashrc
alias backup_bashrc='clear; printf "[*] Realizado backup do bashrc\n"; cat .bashrc > /home/lenonr/Github/dev_xfce/Auto_Config/base/.bashrc ; printf "[+] Backup realizado! \n"'


# boas vindas terminal
/home/lenonr/Github/dev_scripts/Scripts/ShellScript/others/welcome_terminal.sh

