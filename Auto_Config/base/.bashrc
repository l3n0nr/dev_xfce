# *********************************************
# * ~/.bashrc Personalizado para Ubuntu *
# * System: Ubuntu 12.04 – Precise Pangolin *
# * local: /home/user/.bashrc *
# * *
# * Author: Thiago Nalli Valentim *
# * E-Mail: thiago.nalli@gmail.com *
# * Date: 2012-05-24 *
# *********************************************
# ======================================================================
# Adaptado do original de Edinaldo P. Silva para Arch Linux
# URL: http://gnu2all.blogspot.com.br/2011/10/arch-linux-bashrc.html
# ======================================================================
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:               [0.20]        #
# # ultima ediçao realizada:      [12/10/17]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
#-----------------------------------------------
# Configurações Gerais
#-----------------------------------------------

# Se não estiver rodando interativamente, não fazer nada
[ -z "$PS1" ] && return

# Não armazenar as linhas duplicadas ou linhas que começam com espaço no historico
HISTCONTROL=ignoreboth

# Adicionar ao Historico e não substitui-lo
shopt -s histappend

# Definições do comprimento e tamnho do historico.
HISTSIZE=1000
HISTFILESIZE=2000

#===========================================
# Váriavies com as Cores
#===========================================
NONE="\[\033[0m\]" # Eliminar as Cores, deixar padrão)

## Cores de Fonte
K="\[\033[0;30m\]" # Black (Preto)
R="\[\033[0;31m\]" # Red (Vermelho)
G="\[\033[0;32m\]" # Green (Verde)
Y="\[\033[0;33m\]" # Yellow (Amarelo)
B="\[\033[0;34m\]" # Blue (Azul)
M="\[\033[0;35m\]" # Magenta (Vermelho Claro)
C="\[\033[0;36m\]" # Cyan (Ciano - Azul Claro)
# W="\[\033[0;37m\]" # White (Branco)

## Efeito Negrito (bold) e cores
BK="\[\033[1;30m\]" # Bold+Black (Negrito+Preto)
BR="\[\033[1;31m\]" # Bold+Red (Negrito+Vermelho)
# BG="\[\033[1;32m\]" # Bold+Green (Negrito+Verde)
# BY="\[\033[1;33m\]" # Bold+Yellow (Negrito+Amarelo)
BB="\[\033[1;34m\]" # Bold+Blue (Negrito+Azul)
BM="\[\033[1;35m\]" # Bold+Magenta (Negrito+Vermelho Claro)
BC="\[\033[1;36m\]" # Bold+Cyan (Negrito+Ciano - Azul Claro)
# BW="\[\033[1;37m\]" # Bold+White (Negrito+Branco)

## Cores de fundo (backgroud)
BGK="\[\033[40m\]" # Black (Preto)
BGR="\[\033[41m\]" # Red (Vermelho)
BGG="\[\033[42m\]" # Green (Verde)
# BGY="\[\033[43m\]" # Yellow (Amarelo)
BGB="\[\033[44m\]" # Blue (Azul)
BGM="\[\033[45m\]" # Magenta (Vermelho Claro)
BGC="\[\033[46m\]" # Cyan (Ciano - Azul Claro)
BGW="\[\033[47m\]" # White (Branco)

#=============================================
# Configurações referentes ao usuário
#=============================================

## Verifica se é usuário root (UUID=0) ou usuário comum
if [ $UID -eq "0" ]; then

## Cores e efeitos do Usuario root

PS1="$G┌─[$BR\u$G]$BY@$G[$BW${HOSTNAME%%.*}$G]$B:\w\n$G└──>$BR \\$ $NONE"

else

## Cores e efeitos do usuário comum

PS1="$BR┌─[$BG\u$BR]$BY@$BR[$BW${HOSTNAME%%.*}$BR]$B:\w\n$BR└──>$BG \\$ $NONE"

fi # Fim da condição if

## Exemplos de PS1

# PS1="\e[01;31m┌─[\e[01;35m\u\e[01;31m]──[\e[00;37m${HOSTNAME%%.*}\e[01;32m]:\w$\e[01;31m\n\e[01;31m└──\e[01;36m>>\e[00m"

# PS1='\[\e[m\n\e[1;30m\][$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '}

# PS1="\e[01;31m┌─[\e[01;35m\u\e[01;31m]──[\e[00;37m${HOSTNAME%%.*}\e[01;32m]:\w$\e[01;31m\n\e[01;31m└──\e[01;36m>>\e[00m"

# PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "

# PS1='[\u@\h \W]\$ '

#==========================
# DIVERSOS
#==========================

## Habilitando suporte a cores para o ls e outros aliases
## Vê se o arquivo existe
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    ## Aliases (apelidos) para comandos
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi # Fim do if do dircolor

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

# testanco configuracao do teclado
setxkbmap -model abnt2 -layout br -variant abnt2

# habilitando autocompletar
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
