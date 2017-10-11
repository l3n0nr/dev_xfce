#!/bin/bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   FONTES DE PESQUISA  #
# # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# por oliveiradeflavio(Flávio Oliveira)
# 	<github.com/oliveiradeflavio/scripts-linux>
#
# por gmanson(Gabriel Manson)
# 	<github.com/gmasson/welcome-debian>
#
# por Fabiano de Oliveira e Souza
# 	<https://www.vivaolinux.com.br/script/Mantendo-hora-do-servidor-atualizada-com-NTP>
#
# por Lucas Novo Silva
# 	<https://www.vivaolinux.com.br/dica/Erro-de-apt-get-update-no-Ubuntu-1604-Xenial-problemas-nos-repositorios-RESOLVIDO>
#
# por Ricardo Ferreira
# 	<http://www.linuxdescomplicado.com.br/2014/11/saiba-como-acessar-uma-maquina-ubuntu.html>
#
# por Dionatan Simioni
# 	 <http://www.diolinux.com.br/2016/12/drivers-mesa-ubuntu-ppa-update.html>
#    	 <http://www.diolinux.com.br/2016/12/diolinux-paper-orange-modern-theme-for-unity.html>
# 	 <http://www.diolinux.com.br/2014/08/versao-nova-kdenlive-ppa.html>
#
# por Cláudio Novais
#        <http://ubuntued.info/ganhe-espaco-removendo-kernels-antigos>
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # 
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # # 
#
# por lenonr(Lenon Ricardo) 
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#										#
#	If I have seen further it is by standing on the shoulders of Giants.	#
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)		#
#							~Isaac Newton		#
#										#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:           [0.0.145.2.0.4]   #
# # data de criação do script:    [28/09/17]      #
# # ultima ediçao realizada:      [10/10/17]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script;
# 	d = correções necessárias;
# 	e = pendencias    
#               - I     - [FIRMWARE WIFI] - Criar funcao para instalar automaticamente o driver wi-fi para o modelo do computador(Notebook HP Pavilion G4)
#                           - Criar possivel verificação
#                           - Dmidecode | grep "Reference Designation: Broadcom"                    
#                             
#               - II    - [WHICH PROGRAMAS] - Adicionar verificação de alguns programas, antes da instalação.
#                           - Tor-Browser
#                           - Wine
#                           - Icones-macbuntu
# 
# 	f = desenvolver 
# 		- I     - [INTERFACE GRAFICA] - Criar uma interface gráfica, possibilitando ao usuário selecionar as ações que o usuário deseja realizar
#                           - Dialog/Xdialog 
#               - II    - [FUNCAO GERAL] - Facilitar a instalação dos programas, com a opção de instalar todos disponiveis no script;
#               - III   - [FUNCAO REMOVE PROGRAMAS] - Possibilitar o usuario digitar o nome do programa que deseja remover;
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
#       [+] - Açao realizada 
#       [*] - Processamento
#       [-] - Não executado
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # Script testado em
#	- Xubuntu 16.04
#       - Debian 9
#
# # Compativel com
#       - Ubuntu
#       - Debian 9
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # FUNCOES
# 
# # # # # ATUALIZA SISTEMA
# # [+] Update
# #     [+] Update-Grud
# # [+] Upgrade
# # [+] Kernel 
# #     [+] Remove antigos
# # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # CORRIGE SISTEMA
# # [+] Swap
# # [+] Prelink, Preload, Deborphan
# # [+] Pacotes com problemas
# # [+] Fontes
# # [+] Apport
# # [+] NTP
# # [+] Iniciando sessão automaticamente
# # [+] Apport
# # [+] Terminal Personalizado
# # [+] Ssh
# # [+] Log - Sudo
# # [+] Lista de Repositorios padrão
# # [+] Arquivo Hosts
# # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # LIMPA SISTEMA
# # [+] Excluindo pacotes antigos
# # [+] Excluindo pacotes orfaõs
# # [+] Removendo arquivos temporários
# # [+] Arquivos obsoletos
# # [+] Kernel's antigos
# # [+] Removendo arquivos (.bak, ~, tmp) pasta Home
# # [+] Excluindo arquivos inuteis do cache do gerenciador de pacotes
# # [+] Verificando Chkrootkit
# # [+] Removendo idiomas sobressalentes
# # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # INSTALANDO PROGRAMAS
# NAVEGADORES
# # [+] Firefox
# # [+] Chromium
# # [+] Tor
# 
# JOGOS
# # [+] Steam
# # [+] Citra
# # [+] Dolphin
# # [+] VisualGame Boy Advanced
# # [+] Wine
# # [+] PlayonLinux
# 
# ASTRONOMIA
# # [+] Stellarium
# # [+] Kstars
# # [+] Celestia
# 
# MULTIMIDIA
# # [+] Spofity
# # [+] Clementine
# # [+] VLC
# # [+] Kdenlive
# # [+] Sweet Home 3D
# # [+] Audacity
# # [+] Mcomix
# # [+] Simple Screen Recorder
# # [+] Calibre
# # [+] Gimp
# # # [+] PhotoGimp
# 
# DESENVOLVIMENTO
# # [+] Kate
# # [+] Wireshark
# # [+] Git
# # [+] Apache
# # [+] Mysql-server
# # [+] PhpMyAdmin
# 
# OFFICE
# # [+] LibreOffice
# # [+] Texmaker
# 
# PERSONALIZAÇÃO
# # [+] Icones/Temas Mac
# # [+] Codec's
# # [+] XFCE
# # [+] Redshift
# # [+] Gnome-terminal
# # [+] NTP
# # [+] Synaptic	
# # [+] Plank
# # [+] Gnome System Monitor
# # [+] Nautilus
# # [+] Gparted
# # [+] Tlp
# # [+] Rar
# # [+] Screenfetch
# # [+] Gnome-disk-utility
# # [+] Gnome System Tools
# # [+] Brightside
# # [+] Figlet
# # [+] Hardinfo
# # [+] Synapse
# # [+] Nvidia
# # [+] Icones
# 
# OUTROS
# # [+] Firewall Basic
# # [+] Mega
# # [+] Open Ssh
# # [+] Chkrootkit
# # [+] Reaver
# # [+] Lm-sensors
# # [+] Ibus
# # [+] Nmap
# # [+] Htop
# # [+] VirtualBox
# # [+] Tree
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # REMOVENDO PROGRAMAS
# # # GERAL
# # [+] Pidgin
# # [+] Thunderbird
# # [+] Parole
# # [+] Adapta
# # [+] Inkscape
# # [+] Xfburn
# # [+] Blender
# # [+] SmartGit
# # [+] Gitg
# # [+] Meld
# 
# # # NOTEBOOK 
# # [+] Kstars
# # [+] Celestia
# # [+] Steam
# # [+] Spotify
# # [+] Kdenlive
# # [+] Sweet Home 3D
# # [+] Simple Screen Recorder
# # [+] Figlet
# # [+] Transmission
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 	
# 
# Reinicialização
# # [+]Reiniciar
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                               CORPO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# Criando variavel com localização da raiz do usuario
home = "/home/lenonr"
# 
# # # # # CRIANDO FUNÇÕES PARA EXECUÇÃO
# 
# SISTEMA
# ATUALIZAR
# CORRIGIR
# LIMPAR
# INSTALAR
# REMOVER
# REINICIAR
# SAIR
# 
# # # # # # # # # #    
# # DADOS DO SISTEMA
    system()
    {     
        clear
        
        # definindo variavel de verificação
        laco="0"
    
        # definindo quantidade de vezes que o laço sera repetido
        p_vezes="30"
        
        # definindo tempo de atualização do laço
        p_tempo="1"
        
        # mostrando mensagem
        printf "#################################################################################################### \n"
        printf "Essa função irá mostrar dados do sistema, como consumo de memória, utilização do disco e uptime do sistema; \n"
        printf "Você pode escolher a quantidade de vezes que esses dados serão mostrados; \n"
        printf "A forma padrão irá executar $p_vezes vezes em um intervalo de $p_tempo segundos. \n"
        printf "#################################################################################################### \n\n"
        read -n1 -p "Você deseja escolher? (s|sim|S|SIM) / (n|nao|N|NAO): " escolha
        case $escolha in
            s|sim|S|SIM) printf   
                printf "\n"
                read -n1 -p "Digite o valor de vezes que deseja executar essa função: " vezes
                printf "\n"
                read -n1 -p "Agora digite o valor o intervalo de atualização em segundos: " tempo
                
                # enquanto $local for menor ou igual a $vezes, executa
                while [ $laco -le $vezes ]; 
                do
                    clear                                                            
                    printf "################################# \n"
                    printf "A sua distribuição é $distro \n"
                    printf "################################# \n"
                    
                    printf "| Laço nº $laco | Vezes $vezes | Intervalo $tempo | \n"
                    printf "[+] DADOS GERAIS \n"
                    free -mht
                    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
                    
                    printf "\n"
                    df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'       
                                    
                    printf "\n"
                    printf "[+] Espaço de armazenamento \n"
                    df -h
                    
                    printf "\n"
                    printf "[+] Uptime do Sistema \n"
                    uptime
                    
                    # realizando soma na variavel
                    ((laco++))
                    
                    # aguardando tempo para atualização do laço
                    sleep $tempo                                    
                done
            ;;
            n|nao|N|NAO) printf
                # enquanto $local for menor ou igual a $vezes, executa
                while [ $laco -le $p_vezes ]; 
                do
                    clear                                                            
                    printf "################################# \n"
                    printf "A sua distribuição é $distro \n"
                    printf "################################# \n"
                    
                    printf "| Laço nº $laco | Vezes $p_vezes | Intervalo $p_tempo | \n"
                    printf "[+] DADOS GERAIS \n"
                    free -mht
                    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
                    
                    printf "\n"
                    df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'                
                                    
                    printf "\n"
                    printf "[+] Espaço de armazenamento \n"
                    df -h
                    
                    printf "\n"
                    printf "[+] Uptime do Sistema \n"
                    uptime
                    
                    # realizando soma na variavel
                    ((laco++))
                    
                    # aguardando tempo para atualização do laço
                    sleep $p_tempo                                    
                done
            ;;
            *) 
                printf "Digite corretamente!"
                sleep 1
                system    
            ;;
        esac                
    }

# # # # # # # # # #    
# # ATUALIZA SISTEMA
    update()
    {
    
        #atualizando lista de repositorios            
        printf "[+] Atualizando lista de repositorios do sistema \n"   
        
        apt update 
        
        # verificando distribuição
        if [ "$distro" == "Ubuntu" ]; then	                
	        #atualizando repositorio e seus dependencias
        	printf "[+] Atualizando lista de programas e suas dependências \n" 
        	
	        auto-apt update                
        fi                                
    }
    
    upgrade()
    {            
        # verificando distribuição
        if [ "$distro" == "Ubuntu" ]; then
        	#atualizando lista de programas do sistema
	        printf "[+] Atualizando lista de programas do sistema \n"  
	        
	        apt upgrade -y 
        
	        #atualizando repositorio local
	        printf "[+] Atualizando repositório local dos programas \n"  
	        
	        auto-apt updatedb
	else
        	#atualizando lista de programas do sistema
	        printf "[+] Atualizando lista de programas do sistema \n"  
	        
	        apt upgrade -y 
	fi
    }

# # # # # # # # # # 
# # CORRIGE SISTEMA            
    apt_check()
    {        
        #verificando lista do apt
        printf "\n"
        printf "[+] Verificando lista do apt \n"
        
        apt-get check -y
    }
    
    apt_install()
    {
        #instalando possiveis dependencias 
        printf "\n"
        printf "[+] Instalando dependências pendentes \n"
        
        apt-get -f install -y
    }
    
    apt_remove()
    {
        #removendo possiveis dependencias
        printf "\n"
        printf "[+] Removendo possíveis dependências obsoletas \n"
        
        apt-get -f remove -y   
        apt-get autoremove -y    
    }    
    
    apt_clean()
    {
        #limpando lista arquivos sobressalentes
        printf "\n"
        printf "[+] Limpando arquivos sobressalentes \n "
        
        apt-get clean -y   
    }
    
    apt_auto()
    {
        #corrigindo problemas de dependencias
        printf "\n"
        printf "[+] Corrigindo problemas de dependências \n"
        
        apt-get install auto-apt -y 
    }
    
    apt_update_local()
    {        
        #corrigindo repositorio local de dependencias automaticamente
        printf "\n"
        printf "[+] Corrigindo repositório local de dependências automaticamente \n"
        
        auto-apt update-local    
    }
    
    swap()
    {
        #configurando a swap para uma melhor performance
        printf "\n"
        printf "[+] Configurando a Swap"        
        memoswap=$(grep "vm.swappiness=10" /etc/sysctl.conf)
        memocache=$(grep "vm.vfs_cache_pressure=60" /etc/sysctl.conf)
        background=$(grep "vm.dirty_background_ratio=15" /etc/sysctl.conf)
        ratio=$(grep "vm.dirty_ratio=25" /etc/sysctl.conf)        
        printf "[+] Diminuindo a Prioridade de uso da memória SWAP"
        if [[ $memoswap == "vm.swappiness=10" ]]; then
                printf "[*] Otimizando... \n"
                /bin/su -c "printf 'vm.swappiness=10' >> /etc/sysctl.conf" 
        elif [[ $memocache == "vm.vfs_cache_pressure=60" ]]; then
                printf "[*] Otimizando... \n"
                /bin/su -c "printf 'vm.vfs_cache_pressure=60' >> /etc/sysctl.conf" 
        elif [[ $background == "vm.dirty_background_ratio=15" ]]; then
                printf "[*] Otimizando... \n"
                /bin/su -c "printf 'vm.dirty_background_ratio=15' >> /etc/sysctl.conf"
        elif [[ $ratio == "vm.dirty_ratio=25" ]]; then
                printf "[*] Otimizando... \n"
                /bin/su -c "printf 'vm.dirty_ratio=25' >> /etc/sysctl.conf"
        else
                printf "[-] Não há nada para ser otimizado \n"
                printf "[-] Isso porque já foi otimizado anteriormente! \n"
        fi    
    }
    
    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas
        
        #instalando prelink, preload, deborphan para um melhor performance do sistema
        printf "\n"
        printf "[*] Instalando Prelink, Preload e Deborphan \n"                        
        printf "------------------- \n"
        
        apt install prelink preload -y 1>/dev/null 2>/dev/stdout
        apt-get install deborphan -y 
        
        printf "[*] Configurando Deborphan... \n"
        deborphan | xargs sudo apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #configurando o prelink e o preload
        printf "[*] Configurando Prelink e Preload... \n"
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)
        
        printf "[*] Ativando o PRELINK \n"
        printf "------------------- \n"
        if [[ $prelink == "PRELINKING=unknown" ]]; then
                printf "adicionando ... \n"
                sed -i 's/unknown/yes/g' /etc/default/prelink	
        else
                printf "[-] Otimização já adicionada anteriormente. \n"
        fi
    }
    
    funcao_dpkg()
    {
        #corrigindo pacotes quebrados
        printf "\n"
        printf "[+] Corrigindo pacotes quebrados \n"

        #corrige possiveis erros na instalação de softwares
        dpkg --configure -a 

        #VERIFICAR AÇÕES
        rm -r /var/lib/apt/lists 
        mkdir -p /var/lib/apt/lists/partial 
    }
    
    fonts()
    {
        #corrigindo erros fontes
        printf "\n"
        printf "[+] Instalando pacotes de fontes \n"
        
        #baixando pacote
        wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb 
        
        #instalando pacote
        dpkg -i ttf-mscorefonts-installer_3.6_all.deb 
        
        #removendo pacote
        rm -f ttf-mscorefonts-installer_3.6_all.deb
        rm -f ttf-mscorefonts-installer_3.6_all.deb.1
    }
    
    ntp()
    {        
        printf "\n"
        printf "[+] Corrigindo NTP \n"
                            
        #instalando software necessario
        apt install ntp ntpdate -y 
        
        #parando o serviço NTP para realizar as configuraçoes necessarias
        printf "\n"
        printf "[+] Parando serviço NTP para realizaçao das configuraçoes necessarias \n"
            service ntp stop
        
        #configurando script base - NTP
        printf "\n"
        printf "[*] Realizando alteraçao no arquivo base \n"
        cat base/ntp.txt > /etc/ntp.conf
        
        #ativando servico novamente
        printf "\n"
        printf "[+] Ativando serviço NTP \n"
            service ntp start

        #realizando atualizacao hora/data
        printf "\n"
        printf "[+] Atualizando hora do servidor \n"
        printf "[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"
            
        #servidor NIC.BR
        printf "\n"
        printf "[+] Atualizando servidores, aguarde...\n"
        printf "[*] NIC.BR \n"
            ntpdate -q pool.ntp.br
            
        #servidor Ob. Nac.
        printf "\n"
        printf "[*] Observatorio Nacional \n"
            ntpdate -q ntp.on.br 
        
        # servidores da rnp
        printf "\n"
        printf "[*] RNP \n"
            ntpdate -q ntp.cert-rs.tche.br 

        # servidores da ufrj
        printf "\n"
        printf "[*] UFRJ \n"
            ntpdate -q ntps1.pads.ufrj.br 
            
        # servidor da usp
        printf "\n"
        printf "[*] USP \n"
            ntpdate -q ntp.usp.br             

        printf "\n"
        printf "[+] Hora do servidor atualizada! \n"        
    }
    
    apport()
    {
        printf "\n"
        printf "[+] Removendo possiveis erros com o apport \n"
        rm /var/crash/*
        
        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport 
    }
    
    lightdm()
    {
        printf "\n"
        printf "[+] Iniciando sessão automaticamente \n"
        
        cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
    }
    
    terminal_cool()
    {
        #terminal Personalizado
        printf "\n"
        printf "[+] Deixando o terminal personalizado \n"
        
        cat base/.bashrc > $home/.bashrc    
    }
            
    sshd_config()
    {
        #altera arquivo ssh
        printf "\n"
        printf "[+] Alterando regras no acesso SSH \n"
        
        cat base/sshd_config > /etc/ssh/sshd_config    
    }                
            
    log_sudo()
    {
        printf "\n"
        printf "[+] Ativando log's do sudo \n"
        
        cat base/ubuntu/login.defs > /etc/login.defs    
    }
    
    repositorios_padrao()
    {
        # verificando distribuição
        if [ "$distro" == "Ubuntu" ]; then
            printf "\n"
            printf "[+] Alterando lista de repositórios padrão \n"
            
            cat base/ubuntu/sources.list > /etc/apt/sources.list    
        else
            printf "\n"
            printf "[+] Alterando lista de repositórios padrão \n"
            
            cat base/debian/sources.list > /etc/apt/sources.list    
        fi
    }
    
    arquivo_hosts()
    {
        printf "\n"
        printf "[+] Altera arquivo de Hosts \n\n"
        
        cat base/hosts > /etc/hosts
    }
    
# # # # # # # # # # 
# # LIMPA SISTEMA   
    kernel()
    {
        printf "\n"
        printf "[+] Removendo os kernel's temporários do sistema \n"
        
        #removendo kernel's antigos
        dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge  
    }
    
    arquivos_temporarios()
    {    
        printf "\n"
        printf "[+] Removendo arquivos temporários do sistema \n"
        
        find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+                            
    }
    
    pacotes_orfaos()
    {
        printf "\n"
        printf "[+] Removendo Pacotes Órfãos \n"
        
        apt-get remove $(deborphan) -y ; apt-get autoremove -y    
    }
        
    funcao_chkrootkit()
    {
        printf "\n"
        printf "[+] Verificando Chkrootkit \n"        
        
        chkrootkit
    }
    
    localpurge()
    {   
        printf "\n"
        printf "Removendo idiomas extras \n"
        
        localepurge       
    }                    
    
# # # # # # # # # # 
# # INSTALA PROGRAMAS  
    firefox()
    {                
        printf "\n"
        printf "[+] Instalando Firefox \n"
        
        apt install firefox -y        
    }
    
    chromium()
    {    
        printf "\n"
        printf "[+] Instalando o Chromium \n"
        
        apt install chromium-browser -y
    }
    
    
    steam()
    {    
        printf "\n"
        printf "[+] Instalando Steam \n"
        
        apt install steam -y 
    }
    
    spotify()
    {    
        # variavel de verificação 
        var_spotify=$(which spotify)  

        printf "\n"                
        printf "[+] Verificando se existe Spotify já está instalado \n"
        
        if [[ ! -e $var_spotify ]]; then        
            printf "\n"
            printf "[+] Instalando Spotify \n"
        
            #baixando pacote
            sh -c "printf 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list"

            #baixando chave
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

            #chamando função update
            update 

            #instalando o spotify
            apt install spotify-client -y 
        else
            printf "[+] Spofity já está instalando! \n"
        fi
    }

    icones_mac()
    {            
        printf "\n"
        printf "[+] Instalando icones e temas do MacOS X \n"
        
        #adicionando repositorio
        add-apt-repository ppa:noobslab/macbuntu -y 

        # chamando funcao update já criada
        update 

        #instalando icones do MacOS
        apt-get install macbuntu-os-icons-lts-v7 -y 

        #instalando tema do MacOS
        apt-get install macbuntu-os-ithemes-lts-v7 -y 
    }
    
    codecs()
    {
        printf "\n"
        printf "[+] Instalando Pacotes Multimidias (Codecs) \n"
        
        #instalando pacotes multimidias
        apt install ubuntu-restricted-extras faac faad ffmpeg gstreamer0.10-ffmpeg flac icedax id3v2 lame libflac++6 libjpeg-progs libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar rar unrar unace-nonfree sharutils uudeview mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg libxine1-misc-plugins libxine1-plugins libxine1-x nautilus-script-audio-convert nautilus-scripts-manager tagtool spotify-client prelink deborphan oracle-java7-installer -y --force-yes
    }


    funcao_gimp()
    {
        printf "\n"
        printf "[+] Instalando o Gimp \n"
        apt install gimp -y 
        
        printf "\n"
        printf "[+] Instalando o PhotoGimp \n"
        
        printf "[*] Removendo arquivo existente \n"
#         rm -r /home/lenonr/.gimp-2.8
        rm -r $home/.gimp-2.8
                
        printf "[*] Inserindo novo arquivo \n"        
        cp -r base/.gimp-2.8/ $home
        
        printf "[+] Novo arquivo adicionado \n"
    }
    
    xfce4()
    {
        printf "\n"
        printf "[+] Instalando adicionais do XFCE \n"
    
        #instalando componentes do XFCE
        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin smartmontools -y -f -q

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp     
    }
    
    wine()
    {
        printf "\n"
        printf "[+] Instalando o Wine \n"
        
        #adicionado o repositorio
        add-apt-repository ppa:ubuntu-wine/ppa -y
        
        #chamando funcao já criada
        update

        apt install wine* -y
    }
    
    playonlinux()
    {
        printf "\n"
        printf "[+] Instalando o PlayonLinux \n"        
        
        apt install playonlinux* -y 
    }
    
    redshift()
    {
        printf "\n"
        printf "[+] Instalando o Redshift \n"        
        
        apt install redshift gtk-redshift -y
    }
    
    libreoffice()
    {
        # variavel de verificação 
        var_libreoffice=$(which libreoffice) 

        printf "\n"                
        printf "[+] Verificando se existe LibreOffice já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_libreoffice ]]; then                
            printf "\n"
            printf "[+] Instalando o Libreoffice \n"
            
            #adicionando ppa
            add-apt-repository ppa:libreoffice/ppa -y
            
            #chamando funcao já definida
            update
            
            #instalando libreoffice
            apt install libreoffice* -y
        else
            printf "[+] Libreoffice já está instalado! \n"
        fi
    }
    
    vlc()
    {
        printf "\n"
        printf "[+] Instalando o VLC \n"        
        
        apt install vlc -y 
    }
    
    clementine()
    {
        printf "\n"
        printf "[+] Instalando o Clementine \n"        
        
        apt install clementine -y 
    }
    
    gparted()
    {
        printf "\n"
        printf "[+] Instalando o Gparted \n"        
        
        apt install gparted -y    
    }
    
    tlp()
    {
        printf "\n"
        printf "[+] Instalando o Tlp \n"        
        
        apt install tlp -y 
    }
    
    rar()
    {
        printf "\n"
        printf "[+] Instalando o Rar \n"
        
        apt install rar -y 
    }
    
    install_git()
    {
        printf "\n"
        printf "[+] Instalando o Git \n"
        
        apt install git-core git -y 
    }
    
    lm-sensors()
    {
        printf "\n"
        printf "[+] Instalando o Lm-sensors \n"
        
        apt install lm-sensors -y 
    }    
    
    stellarium()
    {
        # variavel de verificação 
        var_stellarium=$(which stellarium) 

        printf "\n"                
        printf "[+] Verificando se existe Stellarium já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_stellarium ]]; then                    
            printf "\n"
            printf "[+] Instalando o Stellarium \n"
        
            #adicinando ppa
            add-apt-repository ppa:stellarium/stellarium-releases -y 

            #atualizando sistema
            update                            

            #instalando o stellarium                
            apt install stellarium* -y 
        else
            printf "[+] Stellarium já está instalado!"
        fi
    }
    
    texmaker()
    {
        printf "\n"
        printf "[+] Instalando o Texmaker \n"
        
        apt install texmaker* texlive-full* texlive-latex-extra* -y 
    }    
    
    kstars()
    {
        printf "\n"
        printf "[+] Instalando o Kstars \n"
        
        apt install kstars* -y
    } 
    
    celestia()
    {
        printf "\n"
        printf "[+] Instalando o Celestia \n"
        
        apt install celestia-gnome celestia* -y
    }
    
    gnome_terminal()
    {
        printf "\n"
        printf "[+] Instalando Gnome-terminal \n"
        
        apt install gnometerminal -y
    }
    
    reaver()
    {
        printf "\n"
        printf "[+] Instalando o Reaver \n"
        
        apt install reaver -y
    }
    
    tor()
    {
        printf "\n"
        printf "[+] Instalando o Tor \n"
        
        #adicionando repositorio
        add-apt-repository ppa:webupd8team/tor-browser -y                
        
        #atualizando lista de pacotes
        update            
        
        #instalando tor
        apt-get install tor-browser -y
    }
    
    synaptic()
    {
        printf "\n"
        printf "[+] Instalando o Synaptic \n"
        
        apt install synaptic -y
    }
    
    dolphin()
    {
        printf "\n"
        printf "[+] Instalando o Dolphin \n"
        
        #adicionando repositorio do dolphin
        add-apt-repository ppa:glennric/dolphin-emu -y
        
        #atualizando lista de repositorios
        update 
        
        #corrigindo problemas de dependencias
        apt-get install -f

        #instalando dolphin
        apt install dolphin-emu* -y
    }
    
    citra()
    {
        printf "\n"
        printf "[+] Instalando o Citra \n"
        
        #adicionando bibliotecas necessarias
        apt-get install libsdl2-dev -y

        #Qt
        apt-get install qtbase5-dev libqt5opengl5-dev -y

        #GCC
        apt-get install build-essential -y

        #Cmake
        apt-get install cmake -y

        #Clang
        apt-get install clang libc++-dev -y

        #copiando repositorio
        git clone --recursive https://github.com/citra-emu/citra
        
        #entrando na pasta
        cd citra
        
        #construindo o citra
        mkdir build && cd build
        cmake ..
        make
        make install
        
        #removendo pasta citra
        rm -r citra/
    }
    
    visual_game_boy()
    {
        printf "\n"
        printf "[+] Instalando o Visual Game Boy \n"
        
        apt install visualboyadvance-gtk -y
    }
    
    screenfetch()
    {
        printf "\n"
        printf "[+] Instalando o Screenfetch \n"
        
        apt install screenfetch -y
    }
    
    kdenlive()
    {
        # variavel de verificação 
        var_kdenlive=$(which kdenlive) 

        printf "\n"                
        printf "[+] Verificando se existe Kdenlive está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_kdenlive ]]; then                        
            printf "\n"
            printf "[+] Instalando o Kdenlive \n"
            
            #adicionando ppa
            add-apt-repository ppa:sunab/kdenlive-release -y

            #atualizando sistema
            update

            #instalando kdenlive	
            apt install kdenlive -y
        else
            printf "[+] Kdenlive já está instalado!"
        fi
    } 
    
    sweethome3d()
    {
        printf "\n"
        printf "[+] Instalando Sweet Home 3D \n"
        
        apt install sweethome3d -y
    }
    
    kate()
    {
        printf "\n"
        printf "[+] Instalando o Kate \n"
        
        apt install kate -y
    }
    
    cheese()
    {
        printf "\n"
        printf "[+] Instalando o Chesse \n"
        
        apt install cheese -y
    }
    
    plank()
    {
        # variavel de verificação 
        var_plank=$(which plank) 

        printf "\n"                
        printf "[+] Verificando se existe Plank já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_plank ]]; then                        
            printf "\n"
            printf "[+] Instalando o Plank Dock \n"
            
            
            # verificando distribuição
            if [ "$distro" == "Ubuntu" ]; then        
                #adicionando ppa
                add-apt-repository ppa:noobslab/apps -y
            
                #atualizando lista repositorios
                update
            fi
            
            #instalando plank
            apt-get install plank* plank-themer -y
        else
            printf "[+] Plank já está instalado! \n"
        fi
    }
    
    gnome_system_monitor()
    {
        printf "\n"
        printf "[+] Instalando o Gnome System Monitor \n"
        
        apt install gnome-system-monitor -y
    }
     
    nautilus()
    {   
        # variavel de verificação 
        var_nautilus=$(which nautilus) 

        printf "\n"                
        printf "[+] Verificando se existe Nautilus já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_nautilus ]]; then                            
            printf "\n"
            printf "[+] Instalando o Nautilus \n"
            
            # verificando distribuição
            if [ "$distro" == "Ubuntu" ]; then                                
                #adicionando ppa
                add-apt-repository ppa:gnome3-team/gnome3 -y
                
                #atualizando lista repositorio
                update

                #instalando o nautilus
                apt install nautilus* -y   
            else
                #instalando o nautilus
                apt install nautilus* -y   
            fi
        else
            printf "[+] Nautilus já está instalado! \n"
        fi        
    }
    
    wireshark()
    {
        printf "\n"
        printf "[+] Instalando o Wireshark \n"
        
        apt install wireshark -y
    }
    
    gnome_disk_utility()
    {
        printf "\n"
        printf "[+] Instalando o Gnome Disk Utility \n"
        
        apt install gnome-disk-utility* -y
    }
    
    calibre()
    {
        printf "\n"
        printf "[+] Instalando o Calibre \n"
        
        apt install calibre -y       
    }
    
    audacity()
    {
        printf "\n"
        printf "[+] Instalando o Audacity \n"
        
        apt install audacity* -y   
    }    
    
    mcomix()
    {
        printf "\n"
        printf "[+] Instalando o MComix \n"
    
        #adicionando repositorio
        add-apt-repository ppa:nilarimogard/webupd8 -y

        #atualizando lista repositorios
        apt-get update

        #instalando mcomix
        apt-get install mcomix -y                                     
    }
    
    simple_screen_recorder()
    {
        # variavel de verificação 
        var_simplescreenrecorder=$(which simplescreenrecorder) 

        printf "\n"                
        printf "[+] Verificando se existe Simple Screen Recorder já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_simplescreenrecorder ]]; then            
            printf "\n"
            printf "[*] Instalando o Simple Screen Recorder \n"
            
            #adicionando fonte
            add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

            #atualizando lista de repositorios
            apt-get update 
            
            #instalando simplescreenrecorder
            apt-get install simplescreenrecorder -y
            apt-get install simplescreenrecorder-lib:i386 -y
        else
            printf "[+] Simple Screen Recorder já está instalado! \n"
        fi
    }
    
    mega()
    {
        printf "\n"
        printf "[+] Instalando o MEGA \n"
    
        #instalando mega
        dpkg -i base/ubuntu/mega/*.deb
        apt install -fy
        dpkg -i base/ubuntu/mega/*.deb
    }
    
    openssh()
    {
        printf "\n"
        printf "[+]'Instalando o OpenSSH \n"
        
        apt install openssh* -y
    }
    
    figlet()
    {
        printf "\n"
        printf "[+] Instalando o Figlet \n"
        
        apt install figlet -y
    }   
    
    install_chkrootkit()
    {
        printf "\n"
        printf "[+] Instalando o Chkrootkit \n"
        
        apt install chkrootkit -y
    }
    
    localepurge()
    {
        printf "\n"
        printf "[+] Instalando o Localepurge \n"
        
        apt-get install localepurge -y                                           
    }
    
    firewall_basic()
    {
        printf "\n"
        printf "[+] Instalando o Firewall UFW + GUFW \n"
    
        apt install ufw gufw -y                                    
    }
    
    hardinfo()
    {
        printf "\n"
        printf "[+] Instalando o Hardinfo \n"
        
        apt install hardinfo -y
    }
    
    synaptic()
    {
        # variavel de verificação 
        var_synapse=$(which synapse) 

        printf "\n"                
        printf "[+] Verificando se existe Synapse já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_synapse ]]; then                            
            printf "\n"
            printf "[+] Instalando o Synaptic \n"
            
            add-apt-repository ppa:synapse-core/testing -y
            update        
            apt-get install synapse -y
        else
            printf "[+] Synapse já está instalado no sistema! \n"
        fi
    }
    
    nvidia()
    {
        # variavel de verificação 
        var_nvidia=$(which nvidia-settings) 

        printf "\n"                
        printf "[+] Verificando se existe Nvidia já está instalado \n"

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_nvidia ]]; then                                
            printf "\n"
            printf "[+] Instalando o driver da Placa Nvidia \n"
            
            apt-add-repository ppa:ubuntu-x-swat/x-updates -y
            apt-add-repository ppa:xorg-edgers/ppa -y
            update
            apt install nvidia-current nvidia-settings -y
            
            printf "\n"
            printf "[+] Arquivo de configuração Nvidia \n"
            cat base/ubuntu/.nvidia-settings-rc > $home/.nvidia-settings-rc    
        else
            printf "[+] Nvidia já está instalado no sistema! \n"
        fi
    }
    
    icones()
    {
        printf "\n"
        printf "[+] Instalando os icones \n"
        
        # copiando arquivos para as pastas
        printf "[*] Movendo icones para pasta \n"
        cp -r base/icons/* /usr/share/icons
        
        printf "[+] Arquivos movidos! \n"
    }       
    
    brightside()
    {
        printf "\n"
        printf "[+] Instalando o Brightside \n"
    
        apt install brightside -y
    }
    
    virtualbox()
    {
        # variavel de verificação 
        var_virtualbox=$(which virtualbox) 
        
        printf "\n"                
        printf "[+] Verificando se existe VirtualBox já está instalado \n"
        
        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_virtualbox ]]; then        
            printf "\n"        
            printf "[*] Realizando download \n"
            wget download.virtualbox.org/virtualbox/5.1.28/virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb
            
            printf "[*] Instalando o VirtualBox \n"
            dpkg -i virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb
            
            printf "[*] Corrigindo problemas de dependências \n"
            apt install -f
            
            printf "[*] Removendo Virtualbox \n"
            rm virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb
            
            printf "[+] Virtualbox instalado com sucesso! \n"
        else
            printf "[+] VirtualBox já está instalado! \n"
        fi
    }
    
    install_tree()
    {
        printf "\n"
        printf "[+] Instalando Tree \n"
    
        apt install tree* -y
    }
    
# # # # # # # # # # 
# # PROGRAMAS NÃO ESSENCIAIS
    
    apache()
    {
        printf "\n"
        printf "[+] Instalando o Apache \n"
    
        apt install apache2 -y    
    }
    
    mysql()
    {
        printf "\n"
        printf "[+] Instalando o Mysql Server \n"
        
        apt install mysql-server -y
    }
    
    phpmyadmin()
    {
        printf "\n"
        printf "[+] Instalando o PhpMyAdmin \n"
    
        apt install phpmyadmin -y            
    }
    
    ibus()
    {
        printf "\n"
        printf "[+] Instalando o Ibus \n"
        
        apt install ibus -y
    }
    
    install_nmap()
    {
        printf "\n"
        printf "[+] Instalando o Nmap \n"
        
        apt install nmap -y
    }
    
    htop()
    {
        printf "\n"
        printf "[+] Instalando o Htop \n"
        
        apt install htop -y
    }
    
    install_sudo()
    {
        printf "\n"
        printf "[+] Instalando o Sudo \n"    

        apt install sudo -y
    }
    
       
# # # # # # # # # # 

##REALIZANDO VERIFICAÇÕES
    ######VERIFICANDO USUARIO ROOT
   if [[ `id -u` -ne 0 ]]; then
        clear
        printf "[-] Você precisa ter poderes administrativos (root) \n"
        printf "[-] O script está sendo finalizado... \n"
        sleep 3
        exit
    fi
            
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#criando função global, que inicia todas as outras
auto_config_ubuntu()
{
    ##CHAMANDOS FUNCOES    
    #     
    case $escolhaauto_config in   
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### DADOS DOS SISTEMA
        0) printf
            system
            
            auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### ATUALIZA SISTEMA
        1) printf  
            clear
            update
            upgrade            
            
            auto_config
        ;;
        
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### CORRIGE SISTEMA
        2) printf                                      
            clear
            # # verificando nome para máquina para executar funções especificas
            #capturando hostname da maquina
            hostname=$(hostname)

            #verificando variavel
            if [[ $hostname == 'desktop' ]]; then
                clear
                apt_check
                apt_install
                apt_remove
                apt_clean
                apt_auto
                apt_update_local
                swap
                prelink_preload_deborphan
                funcao_dpkg
                fonts
                ntp
                apport
                terminal_cool
                sshd_config
                repositorios_padrao
                log_sudo
                lightdm
            elif [[ $hostname == 'notebook' ]]; then 
                clear
                apt_check
                apt_install
                apt_remove
                apt_clean
                apt_auto
                apt_update_local
                swap
                prelink_preload_deborphan
                funcao_dpkg
                fonts
                ntp
                apport
                terminal_cool
                sshd_config
                repositorios_padrao
                log_sudo                    
#                 lightdm
            else                
                clear
                apt_check
                apt_install
                apt_remove
                apt_clean
                apt_auto
                apt_update_local
                swap
                prelink_preload_deborphan
                funcao_dpkg
                fonts
                ntp
                apport
                terminal_cool
                sshd_config
                repositorios_padrao
                log_sudo
                arquivo_hosts
            fi
            
            # realizando atualização
            update
            
            auto_config        
        ;;
                
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### LIMPA SISTEMA
        3) printf
            clear
            
            #verificando variavel
            if [[ $hostname == 'desktop' ]]; then                        
    #           kernel
#                 arquivos_temporarios
                pacotes_orfaos
                funcao_chkrootkit
                localpurge                                 
            else
#                 kernel
#                 arquivos_temporarios
                pacotes_orfaos
                funcao_chkrootkit
                localpurge                                             
            fi
            
            auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### INSTALA PROGRAMAS
        4) printf  
            clear   
            
            # # verificando nome para máquina para executar funções especificas
            #capturando hostname da maquina
            hostname=$(hostname)
            
            if [[ $hostname == 'notebook' ]]; then             
#               PERSONALIZAÇÃO
                icones_mac
                codecs
                xfce4
                redshift
                gnome_terminal
                ntp
                synaptic
                plank
                gnome_system_monitor
                nautilus
                gparted
                tlp
                rar
                screenfetch
                gnome_disk_utility
                gnome_system_monitor
                brightside
#                 figlet
                hardinfo
                synaptic
                icones
            
#               NAVEGADORES
                firefox
                chromium
                tor
                
#               JOGOS
#                 steam
#                 citra
#                 dolphin
                visual_game_boy
                wine
                playonlinux
                
#               ASTRONOMIA
                stellarium
#                 celestia
#                 kstars
                
#               MULTIMIDIA
#                 spotify
                clementine
                vlc
#                 kdenlive
#                 sweethome3d                
                audacity
                mcomix
#                 simple_screen_recorder
                calibre
                
#               DESENVOLVIMENTO
                kate
                install_git
                
#               IMAGEM
                funcao_gimp
                
#               OFFICE
                libreoffice
                texmaker
                                
#               OUTROS
                firewall_basic
                mega
                openssh
                install_chkrootkit
                reaver
                sensors 
                install_nmap
                htop
                install_tree
                
            else 
#               PERSONALIZAÇÃO
                nvidia
                icones_mac
                codecs
                xfce4
                redshift
                gnome_terminal
                ntp
                synaptic
                plank
                gnome_system_monitor
                nautilus
                gparted
                tlp
                rar
                screenfetch
                gnome_disk_utility
                gnome_system_monitor
                brightside
                figlet
                hardinfo
                synaptic                
                icones
            
#               NAVEGADORES
                firefox
                chromium
                tor
                
#               JOGOS                
#                 citra
#                 dolphin
                visual_game_boy
                wine
                playonlinux
                
#               ASTRONOMIA
                stellarium
                celestia
                kstars
                
#               MULTIMIDIA
#                 spotify
#                 clementine
                vlc
                kdenlive
                sweethome3d                
                audacity
#                 mcomix
                simple_screen_recorder
#                 calibre
                
#               DESENVOLVIMENTO
                kate                
                install_git
                
#               IMAGEM
                funcao_gimp
                
#               OFFICE
                libreoffice
                texmaker               
                
#               OUTROS
                firewall_basic
                mega
                openssh
                install_chkrootkit
                reaver
                sensors  
                install_nmap
                htop
                install_tree
            fi
            
            auto_config
        ;;
            
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### PROGRAMAS NÃO ESSENCIAIS
        5) printf                    
            # desenvolvimento
            apache
            mysql
            phpmyadmin
            
            # verificando computador
            if [[ $hostname == 'desktop' ]]; then            
                # desenvolvimento
                wireshark
                
                # outros
                virtualbox
                
                # jogos
                steam            
            fi
                
            # teclado
            ibus
            
            # chamando o menu novamente
            auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### REMOVES PROGRAMAS
        6) printf                    
                clear
                printf "[+] Removendo pidgin \n"
                apt purge pidgin -y
                
                printf "\n"
                printf "[+] Removendo Thunderbird \n"
                
                apt purge thunderbird -y
                
                
                printf "\n"
                printf "[+] Removendo Parole \n"
                
                apt purge parole -y
                                    
                                    
                printf "\n"
                printf "[+] Removendo XBurn \n"
                
                apt purge xfburn -y
                
                
                printf "\n"
                printf "[+] Removendo o Inkscape \n"
                
                apt purge inkscape* -y
                
                
                printf "\n"
                printf "[+] Removendo o Adapta \n"
                
                apt purge adapta-gtk-theme* -y
                
                
                printf "\n"
                printf "[+] Removendo o Blender \n"            
                
                apt purge blender* -y
                
                
            hostname=$(hostname)            
            if [[ $hostname == 'notebook' ]]; then                                             
                printf "[+] Removendo pidgin \n"
                
                apt purge pidgin* -y
                
                
                printf "\n"
                printf "[+] Removendo Thunderbird \n"
                
                apt purge thunderbird* -y
                
                
                printf "\n"
                printf "[+] Removendo Parole \n"
                
                apt purge parole* -y                
                
                
                printf "\n"
                printf "[+] Removendo o Kstars \n"
                
                apt purge kstars* -y
                
                printf "\n"
                printf "[+] Removendo o Celestia \n"
                apt purge celestia* -y
                
                
                
                printf "\n"
                printf "[+] Removendo a Steam \n"
                
                apt purge steam* -y
                
                                
#                 printf ""
#                 printf "[+] Removendo o Dolphin"
#                 dolphin


                printf "\n"
                printf "[+] Removendo o Spotify \n"
                
                apt purge spotify* -y
                
                                
                printf "\n"
                printf "[+] Removendo o Kdenlive \n"
                
                apt purge kdenlive* -y
                
                
                printf "\n"
                printf "[+] Removendo o Sweet Home 3D \n"
                
                apt purge sweethome3d* -y
                
                
                printf "\n"
                printf "[+] Removendo o Simple Screen Recorder \n"
                
                apt purge simplescreenrecorder* -y
                
                
                printf "\n"
                printf "[+] Removendo o Figlet \n"
                
                apt purge figlet* -y
                
                
                printf "\n"
                printf "[+] Removendo o Transmission \n"
                
                apt purge transmission* -y        
                
                
                printf "\n"
                printf "[+] SmartGit \n"                 
                
                apt purge smartgit -y 
                
                
                printf "\n"
                printf "[+] Removendo o Gitg \n"
                
                apt purge gitg -y
                
                
                printf "\n"
                printf "[+] Removendo o Meld \n"
                
                apt purge meld -y
                
                
            else
                printf "\n"
            fi
            
            auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### SAINDO DO SCRIPT
        7) printf 
                exit
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ######ENTRADA INVALIDA
        *) printf
            printf "Alternativa incorreta!! \n"
            sleep 1
            menu
            exit
        ;;
    esac

    printf "TAREFAS FINALIZADAS, SAINDO.. \n"
    clear
}

auto_config_debian()
{        
    ##CHAMANDOS FUNCOES    
    #     
    case $escolhaauto_config in   
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ######DADOS DO SISTEMA
        0) printf  
                system            
                auto_config
        ;;
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### ATUALIZA SISTEMA
        1) printf  
                clear    
                update
                upgrade
                
                auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### CORRINDO PROBLEMAS
        2) printf  
                apt_install
                fonts
                ntp
                terminal_cool
                sshd_config
                repositorios_padrao
                arquivo_hosts
                
                auto_config
        ;;
        
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### REALIZANDO LIMPEZA
        3) printf  
                auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### INSTALANDO PROGRAMAS
        4) printf  
                nautilus
                redshift
                plank
                git
                openssh
                icones
                brightside
                
                install_sudo
                install_nmap
                htop
                #firmware-wifi
                
                #verificando variavel
                if [[ $hostname == 'notebook' ]]; then
                    printf "\n"
                    printf "[+] Instalando firmware Wifi \n"
                    
                    apt install firmware-brcm80211 -y                                        
                fi
                
                #xfpanel          
                
                auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### PROGRAMAS NAO ESSENCIAIS
        5) printf 
                # desenvolvimento
                apache
                mysql
                phpmyadmin
                
                # teclado
                ibus
                
                auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### REMOVENDO PROGRAMAS
        6) printf      
                printf "\n"
                printf "[+] Removendo XBurn \n"
                
                apt purge xfburn -y
                
                
                printf "\n"
                printf "[+] Removendo Mutt \n"
                
                apt purge mutt -y
                
                
                auto_config
        ;;
    
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ###### SAINDO DO SCRIPT
        7) echo 
                exit            
        ;;    
        
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    ######ENTRADA INVALIDA
        *) echo
            printf Alternativa incorreta!!
            sleep 1
            menu
            exit
        ;;
        
    esac

    printf "TAREFAS FINALIZADAS, SAINDO..\n"
    sleep 5
    clear
}


auto_config()
{
#     # verificar distribuição utilizada
#     cat /etc/*-release | grep ID | sed -e "s;ID=;;" | sed -e "s;DISTRIB_;;" | sed -e "s;VERSION_;;" | sed -e "s;ID_LIKE=;;" > distro.txt
# 
#     # verificando distribuição
#     distro=$(sed '2!d' distro.txt)
#     
#     # apagando arquivo
#     rm distro.txt                          

    # verificando distro | forma alterativa
    distro=$(lsb_release -i | cut -f2)
    
    clear
    echo "INICIANDO AS TAREFAS"
    #chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]
    echo "----------------------------------------"
#     echo "Digite 0 para verificar dados do sistema"
    echo "Digite 1 para atualizar o sistema,"
    echo "Digite 2 para corrigir possíveis erros," 
    echo "Digite 3 para realizar uma limpeza," 
    echo "Digite 4 para instalar alguns programas,"     
    echo "Digite 5 para instalar programas não essenciais,"
    echo "Digite 6 para remover alguns programas,"    
    echo "Digite 7 para sair do script,"
    echo "----------------------------------------" 
    read -n1 -p "Ação:" escolhaauto_config
    
    #executando ações para a distribuição Ubuntu
    if [ "$distro" == "Ubuntu" ]; then
        clear
        auto_config_ubuntu                    
    #executando ações para a distribuição Fedora	
    elif [ "$distro" == "Debian" ]; then
        clear
        auto_config_debian
    else
        printf "Disponivel para Debian ou Ubuntu!!! \n"
        printf "Script incompativel infelizmente \n";
    fi                        

}

#mostrando mensagem inicial
menu()
{
    clear
    printf "Bem vindo ao script de automação de tarefas no Linux(Debian + Ubuntu) \n"
    printf "    
   / \ | | | |_   _/ _ \ / ___/ _ \| \ | |  ___|_ _/ ___|   \ \   / / || |  
  / _ \| | | | | || | | | |  | | | |  \| | |_   | | |  _ ____\ \ / /| || |_ 
 / ___ \ |_| | | || |_| | |__| |_| | |\  |  _|  | | |_| |_____\ V / |__   _|
/_/   \_\___/  |_| \___/ \____\___/|_| \_|_|   |___\____|      \_/     |_|
    "
    
    printf "\n"
    read -n1 -p "Para continuar escolha s(sim) ou n(não) para sair. " escolhamenu
        case $escolhamenu in
            s|S) echo                      
                    # executando script
                    auto_config
                    ;;
            n|N) echo
                    # saindo do script
                    printf Finalizando o script...
                    sleep 1
                    exit
                    ;;
            *) echo
                    # restaurando menu
                    printf Alternativa incorreta!!
                    sleep 1
                    menu
                    exit
                    ;;
        esac
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
menu
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
