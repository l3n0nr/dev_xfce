#!/bin/bash
#
######################
# FONTES DE PESQUISA #
######################
#
################################################################################
# por oliveiradeflavio(Flávio Oliveira)
# 	<github.com/oliveiradeflavio/scripts-linux>
#
# por gmanson(Gabriel Manson)
# 	<github.com/gmasson/welcome-debian>
#
# por Edivaldo Brito
# 	<http://www.edivaldobrito.com.br/instalando-ide-java-netbeans-8-0-ubuntu-e-derivados>
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
################################################################################
#
####################
# DESENVOLVIDO POR #
####################
#
# por lenonr(Lenon Ricardo) 
#       contato: <lenonrmsouza@gmail.com>
#
#################################################################################
#										#
#	If I have seen further it is by standing on the shoulders of Giants.	#
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)		#
#							~Isaac Newton		#
#										#
#################################################################################
#
#####################################
# versão do script: 2.0.234.0.0.7  #
# ultima ediçao realizada: 23/08/17 #
#####################################
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script;
# 	d = correções necessárias;
# 	e = pendencias
# 	f = desenvolver
# 		-I      - [INTERFACE GRAFICA] - Criar uma interface gráfica, possibilitando ao usuário selecionar as ações que o usuário deseja realizar, selecionando apenas com o espaço;
#                     #dialog/xdialog
# 
#		-II     - [FUNCAO CANCELA PROCESSAMENTO] - Possibilitar ao usuário o cancelamento das ações selecionadas, dentro de um tempo pré-determinado(10 seg.);
#		-III    - [FUNCAO VERIFICA ARQUITETURA] - Verificar a arquitetura do sistema, para a instalação de determinados programas;
#                     #qual a utilidade disso? ##VERIFICAR##
# 
#               -IV     - [FUNCAO GERAL] - Facilitar a instalação dos programas, com a opção de instalar todos disponiveis no script;
#               -V      - [FUNCAO INSTALA TODOS PROGRAMAS] - Implementar uma funcao chamada padrao, onde contenha todos os programas padroes;
#               -VI     - [FUNCAO REMOVE PROGRAMAS] - Possibilitar o usuario digitar o nome do programa que deseja instalar, sendo que o script vai realizar a remoção automaticamente
# 
#               -VII    - [FUNCAO INSTALA PROGRAMAS OPCIONAIS] - Possibilitar a instalar de programas não essenciais para o sistema, como o servidor web.
# 
#               -VIII   - [FUNCAO DESKTOP-NOTEBOOK] - Possibilitar a instalação de programas especificos de acordo com o tipo da máquina, desktop ou notebook. 
#                     #capturando hostname da maquina
#                     hostname=$(hostname)
# 
#                     #verificando variavel
#                     if [[ $hostname == 'desktop' ]]; then
#                         echo "desktop"
#                     elif [[ $hostname == 'notebook' ]]; then
#                         echo "notebook"
#                     else
#                         echo "não sei o que fazer"
#                     fi
#
#####################################
#       [+] - Açao realizada 
#       [*] - Processamento
#       [-] - Erro encontrado
#####################################
#
################################################################################
#
# Script testado em
#	-Xubuntu 16.04
#
# Compativel com
#	-Ubuntu
#	-Fedora
#
################################################################################
# FUNCOES
#
######ATUALIZA SISTEMA
# # [+] Update
# #     [+] Update-Grud
# # [+] Upgrade
# # [+] Kernel 
# #     [+] Remove antigos
# # 
################################################################################
######CORRIGE SISTEMA
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
# # 
################################################################################
######LIMPA SISTEMA
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
################################################################################
######INSTALANDO PROGRAMAS
# # [+] Firefox
# # [+] Steam
# # [+] Xampp
# # [+] Spofity
# # [+] Icones/Temas Mac
# # [+] Codec's
# # [+] Gimp
# # [+] XFCE
# # [+] Java 8
# # [+] Redshift
# # [+] Flux
# # [+] Libreoffice
# # [+] Vlc
# # [+] Clementine
# # [+] Gparted
# # [+] Tlp
# # [+] Rar
# # [+] Git
# # [+] Lm-sensors
# # [+] Stellarium
# # [+] Texmaker
# # [+] Gnome-terminal
# # [+] Reaver
# # [+] NTP
# # [+] Hollywood
# # [+] Synaptic	
# # [+] Virtualbox
# # [+] Citra
# # [+] Mesa - ppa
# # [+] Screenfetch
# # [+] Diolinux_paper(Diolinux Paper Orange Modern)
# # [+] Kdenlive
# # [+] Supertuxkart
# # [+] Cowsay
# # [+] Chromium
# # [+] Sweet Home 3d
# # [+] Kate
# # [+] Inkscape
# # [+] Blender
# # [+] Numix Icon
# # [+] Plank
# # [+] Gnome System Monitor
# # [+] Nautilus
# # [+] Wireshark
# # [+] Gnome-disk-utility
# # [+] Chkrootkit
# # [+] Vivacious
# # [+] Lampp
# # [+] Php
# # [+] Mysql
# # [+] Ftp
# # [+] Quota
# # [+] Flatabulous
# # [+] Gnome System Tools
# # [+] Brightside
# # [+] Square-Beam
# # [+] Liquorix
# # [+] Moka
# # [+] Mousepad
# # [+] Dolphin
# # [+] Mcomix
# # [+] Calibre
# # [+] Adapta
# # [+] VisualGame Boy Advanced
# # [+] Audacity
# # [+] Tor
# # [+] Kstars
# # [+] Celestia
# # [+] Simple Screen Recorder
# # [+] Firewall Basic
# # [+] Mega
# # [+] Open Ssh
# # [+] Figlet

################################################################################	
######REMOVENDO PROGRAMAS
# # [+] Pidgin
# # [+] Thunderbird
# # [+] Parole

################################################################################	
# Reinicialização
# # [+]Reiniciar
################################################################################
#
################################################################################ 
##REALIZANDO VERIFICAÇÕES
    ######VERIFICANDO USUARIO ROOT
   if [[ `id -u` -ne 0 ]]; then
        clear
        echo "Você precisa ter poderes administrativos (root)"
        echo "O script está sendo finalizado ..."
        sleep 3
        exit
    fi
            
################################################################################
#criando função global, que inicia todas as outras
auto_config_ubuntu()
{
    echo "INICIANDO AS TAREFAS"
    #chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]
    echo "----------------------------------------"
    echo "Digite 1 para atualizar o sistema,"
    echo "Digite 2 para corrigir possíveis erros," 
    echo "Digite 3 para realizar uma limpeza," 
    echo "Digite 4 para instalar alguns programas," 
    echo "Digite 5 para remover alguns programas"
    echo "Digite 6 para reiniciar a máquina."
    echo "Digite 7 para sair do script;"
    echo "----------------------------------------" 
    read -n1 -p "Ação:" escolha
    
    ##CHAMANDOS FUNCOES    
    #     
    case $escolha in   
    ################################################################################
    ######ATUALIZA SISTEMA
        1) echo  
        #update
            if [ "$distro" == "Ubuntu" ]; then
                    clear
                    echo "Atualizando os repositórios na máquina"
                    echo "----------------------------------------------------------------------"
                    apt update
                    update-grub
                    
            elif [ "$distro" == "Fedora" ]; then
                    clear
                    echo "Atualizando os repositórios na máquina"
                    echo "----------------------------------------------------------------------"
                    dnf distro-sync 
            fi
            
        #upgrade
            if [ "$distro" == "Ubuntu" ]; then
                    echo "Atualizando os programas da máquina"
                    echo "----------------------------------------------------------------------"
                    apt upgrade -y
                    apt-get dist-upgrade
            elif [ "$distro" == "Fedora" ]; then
                    clear
                    echo "Atualizando os programas da máquina"
                    echo "----------------------------------------------------------------------"
                    dnf update -y 
            fi    
            ;;
        
    ################################################################################
    ######CORRIGE SISTEMA
        2) echo                      
            #atualizando lista de repositorios            
            echo "[+] Atualizando lista de repositorios do sistema"            
            apt update
            
            #atualizando lista de programas do sistema
            echo "[+] Atualizando lista de programas do sistema"            
            apt upgrade -y
            
            if [ "$distro" == "Ubuntu" ]; then
                clear
                echo "Corrigindo possiveis erros no Sistema"
                echo "----------------------------------------------------------------------"
                
                #verificando lista do apt
                apt-get check -y 
                
                #instalando possiveis dependencias 
                apt-get -f install -y
                
                #removendo possiveis dependencias
                apt-get -f remove -y 
                
                #removendo arquivos sobressalentes
                apt-get autoremove -y 
                
                #limpando lista arquivos sobressalentes
                apt-get clean -y 
                
                #corrigindo problemas de dependencias
                apt-get install auto-apt -y 
                
                    #corrigindo repositorio local de dependencias automaticamente
                    auto-apt update-local -y 
                    
                    #atualizando repositorio e seus dependencias
                    auto-apt update -y
                    
                    #atualizando repositorio local
                    auto-apt updatedb -y
            else
                echo "Função incompativel"                    
            fi        
            
        #swap
            if [ "$distro" == "Ubuntu" ]; then
                echo "Configurando a Swap"
                echo "-------------------"
                memoswap=$(grep "vm.swappiness=10" /etc/sysctl.conf)
                memocache=$(grep "vm.vfs_cache_pressure=60" /etc/sysctl.conf)
                background=$(grep "vm.dirty_background_ratio=15" /etc/sysctl.conf)
                ratio=$(grep "vm.dirty_ratio=25" /etc/sysctl.conf)
                clear
                echo "Diminuindo a Prioridade de uso da memória SWAP"
                echo
                if [[ $memoswap == "vm.swappiness=10" ]]; then
                        echo "Otimizando..."
                        /bin/su -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf"
                elif [[ $memocache == "vm.vfs_cache_pressure=60" ]]; then
                        echo "Otimizando..."
                        /bin/su -c "echo 'vm.vfs_cache_pressure=60' >> /etc/sysctl.conf"
                elif [[ $background == "vm.dirty_background_ratio=15" ]]; then
                        echo "Otimizando..."
                        /bin/su -c "echo 'vm.dirty_background_ratio=15' >> /etc/sysctl.conf"
                elif [[ $ratio == "vm.dirty_ratio=25" ]]; then
                        echo "Otimizando..."
                        /bin/su -c "echo 'vm.dirty_ratio=25' >> /etc/sysctl.conf"
                else
                        echo "Não há nada para ser otimizado"
                        echo "Isso porque já foi otimizado anteriormente!"
                fi
            else
                echo "Função incompativel"
            fi
            
        #prelink, preload
            if [ "$distro" == "Ubuntu" ]; then
                echo "Instalando Prelink, Preload e Deborphan"
                #prelink    = otimiza o tempo de boot
                #preload    = reduz o tempo de inicialização das aplicações
                #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas
                echo "-------------------"
                sudo apt install prelink preload -y 1>/dev/null 2>/dev/stdout
                sudo apt-get install deborphan -y
        
                echo "Configurando Deborphan..."
                sudo deborphan | xargs sudo apt-get -y remove --purge &&
                sudo deborphan --guess-data | xargs sudo apt-get -y remove --purge
                
                #configurando o prelink e o preload
                echo ""
                echo "Configurando Prelink e Preload..."
                echo "-------------------"
                        memfree=$(grep "memfree = 50" /etc/preload.conf)
                        memcached=$(grep "memcached = 0" /etc/preload.conf)
                        processes=$(grep "processes = 30" /etc/preload.conf)
                        prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)
                                                
                echo "Ativando o PRELINK"
                echo "-------------------"
                if [[ $prelink == "PRELINKING=unknown" ]]; then
                        echo "adicionando ..."
                        sed -i 's/unknown/yes/g' /etc/default/prelink	
                else
                        echo "Otimização já adicionada anteriormente."
                fi
            else
                echo "Função incompativel"
            fi
        
        #corrigindo pacotes quebrados
            echo "Corrigindo pacotes quebrados"
            echo "----------------------------"
            
            #corrige possiveis erros na instalação de softwares
            dpkg --configure -a
            
            #VERIFICAR AÇÕES
            rm -r /var/lib/apt/lists  
            mkdir -p /var/lib/apt/lists/partial
            
        #corrigindo erros fontes
            echo "Instalando pacotes de fontes"
            echo "----------------------------"
            #baixando pacote
            wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
            
            #instalando pacote
            dpkg -i ttf-mscorefonts-installer_3.6_all.deb
            
            #removendo pacote
            rm -f ttf-mscorefonts-installer_3.6_all.deb
            
        #apport
            rm /var/crash/*
            
        #ntp
            clear
            echo "Corrigindo NTP "
            echo "----------------------------------------------------------------------"
                                
            #instalando software necessario
            apt install ntp ntpdate -y
            
            #parando o serviço NTP para realizar as configuraçoes necessarias
            echo "[+] Parando serviço NTP para realizaçao das configuraçoes necessarias"
                service ntp stop
            
            #configurando script base - NTP
            echo "[*] Realizando alteraçao no arquivo base"
            cat base/ntp.txt > /etc/ntp.conf
            
            #ativando servico novamente
            echo "[+] Ativando serviço NTP"
                service ntp start

            #realizando atualizacao hora/data
            echo "[+] Atualizando hora do servidor"
            echo "[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"
             
            #servidor NIC.BR
            echo "[+] Atualizando servidores, aguarde..."
            echo "[*] NIC.BR"
                ntpdate -q pool.ntp.br
                
            #servidor Ob. Nac.
            echo "[*] Observatorio Nacional"
                ntpdate -q ntp.on.br 
            
            # servidores da rnp
            echo "[*] RNP"
                ntpdate -q ntp.cert-rs.tche.br 

            # servidores da ufrj
            echo "[*] UFRJ"
                ntpdate -q ntps1.pads.ufrj.br 
                
            # servidor da usp
            echo "[*] USP"
                ntpdate -q ntp.usp.br             

            echo "[+] Hora do servidor atualizada!"        
            
        #iniciando sessão automaticamente
            cat base/lightdm.conf > /etc/lightdm/lightdm.conf
            
        #corrige apport - ubuntu 16.04
            cat base/apport > /etc/default/apport
            
        #terminal Personalizado
            cat base/.bashrc > $HOME/.bashrc
            
        #altera arquivo ssh
            cat base/sshd_config > /etc/ssh/sshd_config
            
        #ativando log sudo
            cat base/login.defs > /etc/login.defs
            
        #definindo lista de repositorios padrao
            cat base/sources.list > /etc/apt/sources.list
            
        ;;
                
    ################################################################################
    ######LIMPA SISTEMA
        3) echo
            #removendo kernel antigo
                echo "Removendo os kernel's temporários do sistema"
                echo "--------------------------------------------"

                #removendo kernel's antigos
                dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
                
                #removendo arquivos
                apt autoremove -y                
                                
            #removendo arquivos temporarios
                echo "Removendo arquivos temporários do sistema"
                echo "-----------------------------------------"
                find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+                        
            
            #removendo arquivos obsoletos
                echo "Removendo os arquivos obsoletos do sistema"
                echo "-----------------------------------------"
                apt-get clean -y && apt-get autoclean -y

            #limpando arquivos orfaos
                echo "Removendo Pacotes Órfãos"
                echo "------------------------"
                apt-get remove $(deborphan) -y ; apt-get autoremove -y
            
            #limpando arquivos inuteis
                if [ "$distro" == "Ubuntu" ]; then
                        echo "Removendo Pacotes inúteis"
                        echo "------------------------"
                        apt-get clean -y
                elif [ "$distro" == "Fedora" ]; then
                        echo "Removendo Pacotes inúteis"
                        echo "------------------------"				
                        dnf autoremove -y 
                        dnf clean all 
                fi	
            
            #removendo pacotes antigos
                apt-get autoremove -y
                
            #verificando chkrootkit
                chkrootkit            
                
            #removendo idiomas sobressalentes
                localepurge                            
        ;;
    
    ################################################################################
    ######INSTALA PROGRAMAS
        4) echo            
            #firefox
                clear
                echo "[+] Instalando Firefox"
                echo "----------------------------------------------------------------------"
                apt install firefox -y
            
            #steam
                clear
                echo "[+] Instalando Steam"
                echo "----------------------------------------------------------------------"
                apt install steam -y
            
            #spotify
                clear
                echo "[+] Instalando Spotify"
                echo "----------------------------------------------------------------------"
                #baixando pacote
                sh -c "echo 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list"

                #baixando chave
                apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

                #atualizando lista de repositorios
                apt update -y

                #instalando o spotify
                apt install spotify-client -y
                
            #icones MAC OS-X
                clear
                echo "[+] Instalando icones e temas do MacOS X"
                echo "----------------------------------------------------------------------"
                #adicionando repositorio
                add-apt-repository ppa:noobslab/macbuntu -y

                #atualizando lista de repositorios
                apt update

                #instalando icones do MacOS
                apt-get install macbuntu-os-icons-lts-v7 -y

                #instalando tema do MacOS
                apt-get install macbuntu-os-ithemes-lts-v7 -y
                
            #codecs multimidia
                clear
                echo "[+] Instalando Pacotes Multimidias (Codecs)"
                echo "----------------------------------------------------------------------"
                #instalando pacotes multimidias
                apt install ubuntu-restricted-extras faac faad ffmpeg gstreamer0.10-ffmpeg flac icedax id3v2 lame libflac++6 libjpeg-progs libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar rar unrar unace-nonfree sharutils uudeview mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg libxine1-misc-plugins libxine1-plugins libxine1-x nautilus-script-audio-convert nautilus-scripts-manager tagtool spotify-client prelink deborphan oracle-java7-installer -y --force-yes
                
            #gimp
                clear
                echo "[+] Instalando o Gimp"
                echo "----------------------------------------------------------------------"
                apt install gimp -y
                
            #xfce
                clear
                if [ "$distro" == "Ubuntu" ]; then
                        echo "[+] Instalando Adicionais do XFCE4"
                        echo "----------------------------------------------------------------------"
                        #instalando componentes do XFCE
                        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin smartmontools -y -f -q

                        #dando permissão de leitura, para verificar temperatura do HDD
                        chmod u+s /usr/sbin/hddtemp
                        
                elif [ "$distro" == "Fedora" ]; then
                        echo "[+] Instalando Adicionais do XFCE4"
                        echo "----------------------------------------------------------------------"
                        #instalando componentes do XFCE
                        dnf install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin -y -f -q
                        
                        #dando permissão de leitura, para verificar temperatura do HDD
                        chmod u+s /usr/sbin/hddtemp
                fi
            
            #wine
                clear
                echo "[+] Instalando Wine"
                echo "----------------------------------------------------------------------"
                #adicionado o repositorio
                add-apt-repository ppa:ubuntu-wine/ppa -y

                #instalando o wine
                apt install wine* -y
            
            #playonlinux
                clear
                echo "[+] Instalando o Playonlinux"
                echo "----------------------------------------------------------------------"

                #instalando o playonlinux
                apt install playonlinux* -y                
                
            #redshift
                clear
                echo "[+] Instalando o Redshift"
                echo "----------------------------------------------------------------------"
                #instalando o redshift
                apt install redshift gtk-redshift -y
                
            #fluxgui
                clear
                echo "[+] Instalando o FluxGUI"
                echo "----------------------------------------------------------------------"
                #adicionando repositorio
                add-apt-repository ppa:nathan-renniewaldock/flux -y
                
                #atualizando lista pacotes
                apt update
                
                #instalando flux
                apt install fluxgui* -y
                
            #libreoffice
                clear
                echo "[+] Instalando o Libreoffice"
                echo "----------------------------------------------------------------------"
                
                #adicionando ppa
                add-apt-repository ppa:libreoffice/ppa -y
               
               #instalando libreoffice
                apt install libreoffice* -y                               
            
            #vlc
                clear
                echo "[+] Instalando o VLC"
                echo "----------------------------------------------------------------------"
                apt install vlc -y
                
            #clementine
                clear
                echo "[+] Instalando o Clementine"
                echo "----------------------------------------------------------------------"
                
                #instalando o clementine
                apt install clementine -y
                
            #gparted
                clear
                echo "[+] Instalando o Clementine"
                echo "----------------------------------------------------------------------"
                
                #instalando o gparted
                apt install gparted -y
                
            #tlp
                clear
                echo "[+] Instalando o Tlp"
                echo "----------------------------------------------------------------------"
                
                #instalando o tlp
                apt install tlp -y
                
            #rar
                clear
                echo "[+] Instalando o RAR"
                echo "----------------------------------------------------------------------"
                
                #instalando o rar
                apt install rar* -y
                
            #git
                clear
                echo "[+] Instalando o Git"
                echo "----------------------------------------------------------------------"
                
                #instalando o git
                apt install git-core git gitg -y  
                
            #lm-sensors
                clear
                echo "[+] Instalando o Lm-sensors "
                echo "----------------------------------------------------------------------"
            
                #instalando o lmsensors
                apt install lm-sensors -y
                
            #texmaker
                clear
                clear
                echo "[+] Instalando o Texmaker "
                echo "----------------------------------------------------------------------"
                
                #instalando o texmaker
                apt install texmaker* texlive-full* texlive-latex-extra* -y 
                
            #stellarium
                clear
                echo "[+] Instalando o Stellarium "
                echo "----------------------------------------------------------------------"                                

                #adicinando ppa
                add-apt-repository ppa:stellarium/stellarium-releases -y
                
                #atualizando sistema
                apt update                            
                
                #instalando o stellarium                
                apt install stellarium* -y
            
            #gnome-terminal
                clear
                echo "[+] Instalando o Gnome-Terminal "
                echo "----------------------------------------------------------------------"
                
                #instalando o gnometerminal
                apt install gnometerminal -y
            
            #reaver
                clear
                echo "[+] Instalando o Reaver "
                echo "----------------------------------------------------------------------"
                
                #instalando o reaver
                apt install reaver
                
            #tor
                clear
                echo "[+] Instalando o Tor "
                echo "----------------------------------------------------------------------"
                
                #adicionando repositorio
                    add-apt-repository ppa:webupd8team/tor-browser -y                
                
                #atualizando lista de pacotes
                apt-get update            
                
                #instalando tor
                apt-get install tor-browser -y
                                
            #hollywood
                clear
                echo "[+] Instalando o Hollywood "
                echo "----------------------------------------------------------------------"
                
                #instalando recurso para hackear a matrix
                apt install hollywood -y
            
            #synaptic
                clear
                echo "[+] Instalando o Synaptic "
                echo "----------------------------------------------------------------------"
                
                #instalando o synaptic
                apt install synaptic -y
            
            #dolphin
                clear 
                echo "[+] Instalando o Dolphin "
                echo "----------------------------------------------------------------------"
                
                #adicionando repositorio do dolphin
                add-apt-repository ppa:glennric/dolphin-emu -y
                
                #atualizando lista de repositorios
                apt update 
                
                #corrigindo problemas de dependencias
                apt-get install -f

                #instalando dolphin
                apt install dolphin-emu* -y
                #apt-get install dolphin-emu-master                                            
                
            #citra
                clear 
                echo "[+] Instalando o Citra "
                echo "----------------------------------------------------------------------"
                               
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
                
            #screenfetch
                clear 
                echo "[+] Instalando o Screenfetch "
                echo "----------------------------------------------------------------------"
                
                #instalando o screenfetch
                apt install screenfetch -y
                
            #diolinux paper
                clear 
                echo "[+] Instalando o Diolinux Paper "
                echo "----------------------------------------------------------------------"
            
                #adicionando ppa			
                add-apt-repository ppa:tiagosh/diolinux-paper-orange -y
                add-apt-repository ppa:snwh/pulp -y 

                #atualizando sistema
                apt update

                #instalando tema
                apt install diolinux-paper-orange -y
                
                #instalando adicional
                apt install paper-icon-theme paper-gtk-theme -y
                
            #kdenlive
                clear 
                echo "[+] Instalando o Kdenlive "
                echo "----------------------------------------------------------------------"
                
                #adicionando ppa
                add-apt-repository ppa:sunab/kdenlive-release -y

                #atualizando sistema
                apt update

                #instalando kdenlive	
                apt install kdenlive -y                                            
                
            #chromium
                clear
                echo "[+] Instalando o Chromium"
                echo "----------------------------------------------------------------------"                
                
                #instalando chromium		
                apt install chromium-browser -y
                
            #sweethome3D
                clear
                echo "[+] Instalando o Sweet Home 3D"
                echo "----------------------------------------------------------------------"                
                
                #instalando o sweethome3d
                apt install sweethome3d -y
                
            #kate
                clear
                echo "[+] Instalando o Kate"
                echo "----------------------------------------------------------------------"                
                
                #instalando o kate
                apt install kate -y
            
            #inkscape
                clear
                echo "[+] Instalando o Inkscape"
                echo "----------------------------------------------------------------------"                
                
                #instalando inkscape
                apt-get install inkscape -y 
                
            #blender
                clear
                echo "[+] Instalando o Blender"
                echo "----------------------------------------------------------------------"                
                
                #instalando o blender
                apt-get install blender -y
                
            #cheese
                clear
                echo "[+] Instalando o Cheese"
                echo "----------------------------------------------------------------------"                
                
                #instalando o cheese
                apt-get install cheese -y
                
            #plankdock
                clear
                echo "[+] Instalando o Plank Dock"
                echo "----------------------------------------------------------------------"                
                
                #adicionando ppa
                add-apt-repository ppa:noobslab/apps -y
                
                #atualizando lista repositorios
                apt-get update
                
                #instalando plank
                apt-get install plank* plank-themer -y
            
            #gnomesystemmonitor
                clear
                echo "[+] Instalando o Gnome System Monitor"
                echo "----------------------------------------------------------------------"
            
                #instalando gnomesystemmonitor
                apt install gnome-system-monitor -y
                
            #nautilus
                clear
                echo "[+] Instalando o Nautilus"
                echo "----------------------------------------------------------------------"
                
                #adicionando ppa
                add-apt-repository ppa:gnome3-team/gnome3 -y
                
                #atualizando lista repositorio
                apt update
        
                #instalando o nautilus
                apt install nautilus* -y            
            
            #wireshark
                clear
                echo "[+] Instalando o Wireshark"
                echo "----------------------------------------------------------------------"
                
                #instalando o wireshark
                apt install wireshark -y
                
            #gnomediskutility
                clear
                echo "[+] Instalando o Gnome Disk Utility"
                echo "----------------------------------------------------------------------"
                
                #instalando o gnomediskutility
                apt install gnome-disk-utility* -y
                                
            #chkrootkit
                clear
                echo "[+] Instalando o Chkrootkit"
                echo "----------------------------------------------------------------------"
                
                #instalando o chkrootkit
                apt install chkrootkit -y
            
            #chkrootkit
                clear
                echo "[+] Instalando o Localepurge"
                echo "----------------------------------------------------------------------"
            
                #instalando localepurge
                apt-get install localepurge -y
                
            #liquorix
                clear
                echo "[+] Instalando o Liquorix"
                echo "----------------------------------------------------------------------"
                
                #adicionando enderencos na lista de fontes
                echo "deb http://liquorix.net/debian sid main" | sudo tee /etc/apt/sources.list.d/liquorix.list 
                echo "deb-src http://liquorix.net/debian sid main" | sudo tee -a /etc/apt/sources.list.d/liquorix.list 

                #atualizando o sistema
                apt-get update 

                #instalando o liquorix
                apt-get install '^liquorix-([^-]+-)?keyring.?' -y
                apt-get install linux-image-liquorix-amd64 linux-headers-liquorix-amd64 -y

                #atualizando o grub
                update-grub
                
            #mcomix    
                clear
                echo "[+] Instalando o MCOMIX"
                echo "----------------------------------------------------------------------"
            
                #adicionando repositorio
                add-apt-repository ppa:nilarimogard/webupd8 -y

                #atualizando lista repositorios
                apt-get update

                #instalando mcomix
                apt-get install mcomix -y
                
            #calibre
                clear
                echo "[+] Instalando o Calibre"
                echo "----------------------------------------------------------------------"
                
                #instalando calibre
                apt install calibre -y
                
            #adapta    
                clear
                echo "[+] Instalando o tema Adapta"
                echo "----------------------------------------------------------------------"
                
                #adicionando repositorio
                apt-add-repository ppa:tista/adapta -y

                #atualizando lista repositorios
                apt update

                #instalando adapta
                apt install adapta-gtk-theme                
                
            #visualgameboy
                clear
                echo "[+] Instalando o Visualboyadvance"
                echo "----------------------------------------------------------------------"
                
                #instalando o visualboyadvance
                apt install visualboyadvance-gtk -y
                
            #audacity
                clear
                echo "[+] Instalando o Audacity"
                echo "----------------------------------------------------------------------"
                
                #instalando o audacity
                apt install audacity* -y   
                
            #Kstars
                clear
                echo "[+] Instalando o Kstars"
                echo "----------------------------------------------------------------------"
                
                #instalando o kstars
                apt install kstars* -y
                
            #celestia
                clear
                echo "[+] Instalando o Celestia"
                echo "----------------------------------------------------------------------"
                
                #instalando o celestia
                apt install celestia-gnome celestia* -y
                
            #simple screen recorder
                clear
                echo "[+] Instalando Simple Screen Recorder"
                echo "----------------------------------------------------------------------"
                
                #adicionando fonte
                add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

                #atualizando lista de repositorios
                apt-get update 
                
                #instalando simplescreenrecorder
                apt-get install simplescreenrecorder -y
                apt-get install simplescreenrecorder-lib:i386 -y
            
            #firewall basic
                clear
                echo "[+] Instalando Firewall Basico"
                echo "----------------------------------------------------------------------"
                
                #instalando ufw + gufw
                apt install ufw gufw -y
                
            #mega
                clear
                echo "[+] Instalando Mega"
                echo "----------------------------------------------------------------------"
                                            
                #instalando mega
                dpkg -i base/mega/*.deb
                apt install -fy
                dpkg -i base/mega/*.deb
                
            #openssh
                clear
                clear
                echo "[+] Instalando Openssh"
                echo "----------------------------------------------------------------------"
                
                #instalando openssh
                apt install openssh* -y
            
            #figlet
                clear
                clear
                echo "[+] Instalando Figlet"
                echo "----------------------------------------------------------------------"
                
                #instalando openssh
                apt install figlet -y                                                    
            ;;
    
    ################################################################################
    ######REMOVES PROGRAMAS
        5) echo
            #removendo programas já instalados
                clear
                echo "[+] Removendo pidgin"
                echo "----------------------------------------------------------------------"
                apt purge pidgin* -y
                
                clear
                echo "[+] Removendo Thunderbird"
                echo "----------------------------------------------------------------------"
                apt purge thunderbird* -y
                
                clear
                echo "[+] Removendo Parole"
                echo "----------------------------------------------------------------------"
                apt purge parole* -y
                            
            ;;
    
    ################################################################################
    ######REINICIANDO MAQUINA
        6) echo
            reboot -n
            ;;
        
    ################################################################################
    ######SAINDO SCRIPT
        7) echo 	
            exit
            ;;
    
    ################################################################################
    ######ENTRADA INVALIDA
        *) echo
            echo Alternativa incorreta!!
            sleep 1
            menu
            exit
            ;;
    esac

    echo "TAREFAS FINALIZADAS, SAINDO.."
    clear
}

#mostrando mensagem inicial
menu()
{
    clear
    echo "Bem vindo ao script de automação de tarefas em Linux"
    read -n1 -p "Para continuar escolha s(sim) ou n(não)  " escolha
        case $escolha in
            s|S) echo
                    #verificar distribuição utilizada
                    distro=$(cat /etc/*-release | grep DISTRIB_ID | sed -e "s;DISTRIB_ID=;;")
                    
                    #executando ações para a distribuição Ubuntu
                    if [ "$distro" == "Ubuntu" ]; then
                            clear
                            echo "Você utiliza a distribuição(ou derivação) Ubuntu"
                            echo "Serão executadas ações especificas para esse tipo de distribuição"
                            echo "------------------------------------------------"
                            auto_config_ubuntu

                    #executando ações para a distribuição Fedora	
                    elif [ "$distro" == "Fedora" ]; then
                            clear
                            echo "Você utiliza a distribuição(ou derivação) Red Hat"
                            echo "Serão executadas ações especificas para esse tipo de distribuição"
                            echo "------------------------------------------------"
                            clear
                            auto_config_fedora					
                            
                    #distribuição não identificada	
                    else
                            echo "Disponivel para Fedora e Ubuntu!!!"
                            echo "Script incompativel temporariamente"
                    fi
                    ;;
            n|N) echo
                    echo Finalizando o script...
                    sleep 1
                    exit
                    ;;
            *) echo
                    echo Alternativa incorreta!!
                    sleep 1
                    menu
                    exit
                    ;;
        esac
}

################################################################################
#INICIANDO SCRIPT
menu
################################################################################