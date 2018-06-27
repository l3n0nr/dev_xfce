#!/usr/bin/env bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#     DEVELOPMENT BY    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#									      									  #
#	If I have seen further it is by standing on the shoulders of Giants.      #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)	          #
#							~Isaac Newton	      							  #
#									      									  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # ARQUIVOS EXTERNOS
# resources used
# Read file config/references.conf
#
# script compatibility
# Read file /config/compatibility.conf

# variaveis de ambiente
source config/variables.conf

# # Mensagens de Status
#       [+] - Ação realizada;
#       [*] - Processamento;
#       [-] - Não executado;
#       [!] - Mensagem de aviso;
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
## testando usuario
if [[ `id -u` -ne 0 ]]; then
    clear
    printf "############################################################################\n"
    printf "\n"
    $logo
    printf "\n"
    printf "############################################################################ \n"
    printf "[!] O script para funcionar, precisa estar sendo executado como root! \n"
    printf "[!] Favor, logar na conta root e executar o script novamente. \n"
    printf "############################################################################ \n"
    exit 1
fi

# # # # # CRIANDO FUNÇÕES PARA EXECUÇÃO
# criando funcoes para serem executadas como parametros
func_help()
{
    clear
    printf "############################################################################\n"
    printf "\n"
	$logo
	printf "\n"
    printf "############################################################################\n"

    cat README.md
    printf "\n"
    printf "############################################################################\n"
}

#
# # atualiza SISTEMA
    update()
    {
        #atualizando lista de repositorios
        printf "\n[+] atualizando lista de repositorios do sistema"
        printf "\n[+] atualizando lista de repositorios do sistema" >> $arquivo_log
        	apt update
    }

    upgrade()
    {
        # verificando distribuição
        if [ $distro == "Ubuntu" ]; then            
        	#atualizando lista de programas do sistema
        	printf "\n[+] atualizando lista de programas do sistema \n"
	        printf "\n[+] atualizando lista de programas do sistema \n" >> $arquivo_log
	        	apt upgrade -y

	        #atualizando repositorio local
	        printf "\n[+] atualizando repositório local dos programas \n"
	        printf "\n[+] atualizando repositório local dos programas \n" >> $arquivo_log
	        	auto-apt updatedb
		else
        	#atualizando lista de programas do sistem
        	printf "\n[+] atualizando lista de programas do sistema \n"
	        printf "\n[+] atualizando lista de programas do sistema \n" >> $arquivo_log
                ## atualizacao segura
		        apt upgrade -y

                ## atualizacoes com mudanças - atualizacoes completas                
                apt dist-upgrade -y 
                apt full-upgrade -y
		fi
    }

# # # # # # # # # #
# # corrige SISTEMA
    apt_check()
    {
        #verificando lista do apt
        printf "\n[+] Verificando lista do apt"
        printf "\n[+] Verificando lista do apt" >> $arquivo_log
        
        apt-get check -y
    }

    apt_install()
    {
        #instalando possiveis dependencias
        printf "\n[+] instalando dependências pendentes"
        printf "\n[+] instalando dependências pendentes" >> $arquivo_log

        apt-get install -fy
    }

    apt_remove()
    {
        #removendo possiveis dependencias
        printf "\n[+] Removendo possíveis dependências obsoletas"
        printf "\n[+] Removendo possíveis dependências obsoletas" >> $arquivo_log

        apt-get remove -fy
    }

    apt_clean()
    {
        #limpando lista arquivos sobressalentes
        printf "\n[+] limpando arquivos sobressalentes"
        printf "\n[+] limpando arquivos sobressalentes" >> $arquivo_log
        
        rm -rf /var/lib/dpkg/info/*.*

        apt-get clean 
        apt-get install -f

        update
    }

    apt_auto()
    {
        #corrigindo problemas de dependencias
        printf "\n[+] Corrigindo problemas de dependências"
        printf "\n[+] Corrigindo problemas de dependências" >> $arquivo_log
        
        apt-get install auto-apt -y
    }

    apt_update_local()
    {
        #corrigindo repositorio local de dependencias automaticamente
        printf "\n[+] Corrigindo repositório local de dependências automaticamente"
        printf "\n[+] Corrigindo repositório local de dependências automaticamente" >> $arquivo_log
        
        auto-apt update-local
        apt list --upgradable
    }

    pacotes_quebrados()
    {
        #corrigindo pacotes quebrados
        printf "\n[+] Corrigindo pacotes quebrados"
        printf "\n[+] Corrigindo pacotes quebrados" >> $arquivo_log

        #corrige possiveis erros na instalação de softwares
        dpkg --configure -a

        # corrigindo problema nos pacotes
        apt install -f 
        apt update --fix-missing 
        apt-get --fix-broken install

        # atualizando versao dos pacotes instalados
        apt list --upgradable

        #VERIFICAR AÇÕES
        rm -r /var/lib/apt/lists
        mkdir -p /var/lib/apt/lists/partial
    }    

    atualiza_db()
    {
    	# variavel de verificação
        local var_locate=$(which locate)

        if [[ ! -e $var_locate ]]; then
            printf "\n"
            printf "[+] instalando Locate"
            printf "[+] instalando Locate" >> $arquivo_log

        	apt install locate -y
        fi

        printf "\n[+] atualizando base de dados do sistema"        
        printf "\n[+] atualizando base de dados do sistema" >> $arquivo_log

    	updatedb
    }

# # # # # # # # # #
# # config SISTEMA    
    swap()
    {        
        ## realizando testes em /etc/sysctl.conf
        memoswap=$(grep vm.swappiness /etc/sysctl.conf)
        memocache=$(grep vm.vfs_cache_pressure /etc/sysctl.conf)
        background=$(grep "vm.dirty_background_ratio" /etc/sysctl.conf)
        ratio=$(grep "vm.dirty_ratio" /etc/sysctl.conf)

        [[ $memoswap == "" ]] && echo vm.swappiness=$swappiness >> /etc/sysctl.conf && \
        [[ $memocache == "" ]] && echo vm.vfs_cache_pressure=$cache_pressure >> /etc/sysctl.conf && \
        [[ $background == "" ]] && echo vm.dirty_background_ratio=$dirty_background_ratio >> /etc/sysctl.conf && \
        [[ $ratio == "" ]] && echo vm.dirty_ratio=$dirty_ratio >> /etc/sysctl.conf && \
                printf "\n[+] Swap otimizada \n" && printf "\n[+] Swap otimizada \n" >> $arquivo_log || \
                printf "\n[-] Não há nada para ser otimizado - Swap \n" && printf "\n[-] Não há nada para ser otimizado - Swap \n" >> $arquivo_log        
    }

    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas        

        echo "[*] configurando Deborphan... " 
        deborphan | xargs apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #configurando o prelink e o preload
        echo "[*] configurando Prelink e Preload... "
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)

        printf "[*] Ativando o PRELINK "

        if [[ $prelink == "PRELINKING=unknown" ]]; then
            printf "adicionando ... \n"
            sed -i 's/unknown/yes/g' /etc/default/prelink
        else
            printf "\n[-] Otimização já adicionada anteriormente."
        fi
    }


    install_fonts()
    {
        #corrigindo erros fontes
        printf "\n[+] instalando pacotes de fontes"
        printf "\n[+] instalando pacotes de fontes" >> $arquivo_log

        apt install ttf-mscoreinstall_fonts-installer install_fonts-noto ttf-freefont -f 
    }    

    config_ntp()
    {
        printf "\n[+] configurando o NTP"
        printf "\n[+] configurando o NTP" >> $arquivo_log

        #parando o serviço NTP para realizar as configuraçoes necessarias
        printf "\n[*] Parando serviço NTP para realizaçao das configuraçoes necessarias"           
            service ntp stop

        #configurando script base - NTP
        printf "\n[*] Realizando alteraçao no arquivo base "
        cat base/ntp.txt > /etc/ntp.conf

        #ativando servico novamente
        printf "\n[+] Ativando serviço NTP"        
            service ntp start

        #realizando atualizacao hora/data
        printf "\n[+] atualizando hora do servidor"
        printf "\n[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"

        printf "\n[+] atualizando servidores, aguarde..."
        printf "\n[*] NIC.BR\n"
            ntpdate -q pool.ntp.br

        if [[ $? == "0" ]]; then
            printf "\n[+] Hora do computador sincronizada!\n"
            printf "\n[+] Hora do computador sincronizada!\n" >> $arquivo_log
        else
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n"
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n" >> $arquivo_log
        fi    
    }

    apport()
    {
        printf "\n[+] Removendo possiveis erros com o apport \n"
        printf "\n[+] Removendo possiveis erros com o apport \n" >> $arquivo_log

        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport
    }   

    arquivo_hosts()
    {
        printf "\n[+] Alterando arquivo Hosts"
        printf "\n[+] Alterando arquivo Hosts" >> $arquivo_log
        echo; echo

        ## gerando arquivo
        echo "127.0.0.1   $(hostname)" > base/hosts/hosts
        cat base/hosts/base >> base/hosts/hosts
        cat base/hosts/spotify >> base/hosts/hosts

        ## copiando arquivo para /etc/hosts
        cat base/hosts/hosts > /etc/hosts               
    }

    chaveiro()
    {
        printf "\n[+] Removendo o chaveiro da sessão"
        printf "\n[+] Removendo o chaveiro da sessão" >> $arquivo_log

        apt-get remove gnome-keyring -y
    }   

    autologin()
    {       
        if [[ $boolean_autologin == "1" ]]; then
            local var_autologin="/usr/share/lightdm/lightdm.conf.d/01_debian.conf"

            # verificando se existe "autologin-user=$usuario" no arquivo '/etc/lightdm/lightdm.conf'
            # var_autologin=$(cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario")        
            # cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario" > /dev/null        

            cat $var_autologin | grep "autologin-user=$autor" > /dev/null

            # se saida do echo $? for 1, entao realiza modificacao
            # if [[ $var_autologin == "1" ]]; then
            if [[ $? == "1" ]]; then    
                if [[ $distro == "Debian" ]]; then             
                    printf "\n[+] Habilitando login automatico" 
                    printf "\n[+] Habilitando login automatico" >> $arquivo_log

                    echo "autologin-user=$autor" >> $var_autologin
                    echo "autologin-user-timeout=0" >> $var_autologin

                    printf "\n[*] Reconfigurando lightdm, aguarde!" 
                    dpkg-reconfigure lightdm 

                    if [[ $? == "0" ]]; then
                        printf "\n[+] configuraçao atualizada com sucesso"
                    else
                        printf "\n[-] Erro na configuracao - Autologin"
                    fi

                elif [[ $distro == "Ubuntu" ]]; then 
                    printf "\n[+] Iniciando sessão automaticamente"
                    printf "\n[+] Iniciando sessão automaticamente" >> $arquivo_log

                    cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
                else
                    printf "\n[-] Erro autologin"
                    printf "\n[-] Erro autologin" >> $arquivo_log
                fi  
            else
                printf "[-] Login ja esta habilitado"
                printf "[-] Login ja esta habilitado" >> $arquivo_log
            fi
        else
            printf "\n[-] O login automatico esta desabilitado! Verificar script."
            printf "\n[-] O login automatico esta desabilitado! Verificar script. " >> $arquivo_log
        fi      
    }    

    icones_temas()
    {       
        if [ -e $var_breeze ]; then             
            printf "\n[-] Voce ja possui os arquivos Breeze!"
            printf "\n[-] Voce ja possui os arquivos Breeze!" >> $arquivo_log
        else            
            printf "\n[+] Copiando icones Breeze"
            printf "\n[+] Copiando icones Breeze" >> $arquivo_log

            cp -r ../config/Interface/icons/Breeze /usr/share/icons
        fi

        if [ -e $var_flatremix ]; then 
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!"
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!" >> $arquivo_log
        else            
            printf "\n[+] Copiando icones Flat_Remix_Light"
            printf "\n[+] Copiando icones Flat_Remix_Light" >> $arquivo_log

            cp -r ../config/Interface/icons/Flat_Remix_Light /usr/share/icons
        fi

        if [ -e $var_papirus ]; then 
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!"
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!" >> $arquivo_log
        else            
            printf "\n[+] Copiando icones Papirus_Light"
            printf "\n[+] Copiando icones Papirus_Light" >> $arquivo_log

            cp -r ../config/Interface/icons/Papirus_Light /usr/share/icons
        fi

        if [ -e $var_icones_macos ]; then 
            printf "\n[-] Voce ja possui os arquivos MacOS X!"
            printf "\n[-] Voce ja possui os arquivos MacOS X!" >> $arquivo_log
        else    
            printf "\n[+] Copiando icones MacOS X"
            printf "\n[+] Copiando icones MacOS X" >> $arquivo_log

            cp -r ../config/Interface/themes/* /usr/share/themes
        fi
    }    
    
    config_idioma()
    {   
        if [[ $distro == "Debian" ]]; then    
            [[ $(grep $language /etc/default/locale) == "" ]] \
                && printf "\n\n[*] Realizando configuraçao de idioma" && cat base/language > $arq_language && locale-gen \
                || printf "\n\n[-] configuraçao do idioma ja realizada anteriormente!"
        fi

        printf "\n"
    }

# # # # # # # # # #
# # limpa SISTEMA
    arquivos_temporarios()
    {
        printf "\n"
        printf "\n[+] Removendo arquivos temporários do sistema" 
        printf "\n[+] Removendo arquivos temporários do sistema" >> $arquivo_log

    	find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+
    }

    pacotes_orfaos()
    {
        printf "\n[+] Removendo Pacotes Órfãos"
        printf "\n[+] Removendo Pacotes Órfãos" >> $arquivo_log

        apt-get remove $(deborphan) -y 
    }

    funcao_chkrootkit()
    {
        printf "\n"
        printf "\n[+] Verificando Chkrootkit"
        printf "\n[+] Verificando Chkrootkit" >> $arquivo_log

        chkrootkit
    }

    func_localepurge()
    {
        printf "\n "
        printf "\n[+] Removendo idiomas extras" 
        printf "\n[+] Removendo idiomas extras" >> $arquivo_log

        localepurge
    }

# # # # # # # # # #
# # instala PROGRAMAS
    install_firefox()
    {   
        printf "\n"
        printf "\n[+] instalando Firefox"
        printf "\n[+] instalando Firefox" >> $arquivo_log

		if [[ $distro == "Ubuntu" ]]; then
        	apt install firefox -y
        elif [[ $distro == "Debian" ]]; then
            snap install firefox
        fi            
    }

    install_chromium()
    {              
        local var_chromium=$(which chromium)        
        local var_chromium1=$(which chromium-browser)

        if [[ $distro == "Debian" ]]; then 
            if [[ ! -e $var_chromium ]]; then
                printf "\n[+] instalando o Chromium"
                printf "\n[+] instalando o Chromium" >> $arquivo_log

                apt install chromium* -y
            else
                printf "\n[+] Chromium ja esta instalado"
                printf "\n[+] Chromium ja esta instalado" >> $arquivo_log                
            fi  
        elif [[ $distro == "Ubuntu" ]]; then 
            if [[ ! -e $var_chromium1 ]]; then
                printf "\n[+] instalando o Chromium"
                printf "\n[+] instalando o Chromium" >> $arquivo_log

                snap install chromium
            else
                printf "\n[+] Chromium ja esta instalado"
                printf "\n[+] Chromium ja esta instalado" >> $arquivo_log                
            fi  
        else
            printf "\n[-] Erro instalação Chromium"
            printf "\n[-] Erro instalação Chromium" >> $arquivo_log
        fi 
    }

    install_tor()
    {
        # variavel de verificação
        local var_tor=$(which tor)

        if [[ ! -e $var_tor ]]; then
            printf "\n"
            printf "\n[+] instalando o Tor"
            printf "\n[+] instalando o Tor" >> $arquivo_log

            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
                # ubuntu 16.04
                #adicionando repositorio
                add-apt-repository ppa:webupd8team/tor-browser -y

                #atualizando lista de pacotes
                update

                #instalando tor
                apt-get install tor tor-browser -y

            elif [ $distro == "Debian" ]; then
                # modo manual - baixar o arquivo e pa... \o
                ## verificar comandos
                ## manualmente - funciona de boas! 
                ## elaborando script
                printf ""                
            else
                printf "\n[-] ERRO TOR"
                printf "\n[-] ERRO TOR" >> $arquivo_log
            fi

        else
            printf "\n"
            printf "[+] Tor já está instalado! \n" 
        fi           
    }

    install_steam()
    {
        printf "\n"
        printf "\n[+] instalando Steam"
        printf "\n[+] instalando Steam" >> $arquivo_log

		# instalando dependencias steam - DEBIAN 9
		if [[ $distro == "Debian" ]]; then 
			# adicionando arquitetura/dependencia      	
			dpkg --add-architecture i386		

			# atualizando sistema			
			update

			# instalando nvidia - dependencias debian
			apt install libgl1-nvidia-glx:i386 libc6-i386 libgl1-mesa-dev \
                        libxtst6:i386 libxrandr2:i386 libglib2.0-0:i386 \
                        libgtk2.0-0:i386 libpulse0:i386 libgdk-pixbuf2.0-0:i386 -y \
                        steam-launcher -y		                        
		fi		

        apt install steam -y
    }

    install_spotify()
    {
        # variavel de verificação
        local var_spotify=$(which spotify)

        if [[ ! -e $var_spotify ]]; then
            printf "\n"
            printf "\n[+] instalando Spotify" >> $arquivo_log

            if [[ $distro == "Ubuntu" ]]; then 
				snap install spotify 		         
			elif [[ $distro == "Debian" ]]; then 
                snap install spotify                  
			fi			            	
        else
            printf "[+] Spofity já está instalado! \n"
        fi
    }   

    install_codecs()
    {
        printf "\n"
        printf "\n[+] instalando Pacotes Multimidias (Codecs)"
        printf "\n[+] instalando Pacotes Multimidias (Codecs)" >> $arquivo_log

        if [[ $distro == "Ubuntu" ]]; then
            #instalando pacotes multimidias
            apt install ubuntu-restricted-extras -y
        fi

        apt install faac faad ffmpeg gstreamer0.10-ffmpeg \
                    flac icedax id3v2 lame libflac++6 libjpeg-progs \
                    libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec \
                    mpeg3-utils mpegdemux mpg123 mpg321 regionset sox \
                    uudeview vorbis-tools x264 arj p7zip p7zip-full \
                    unace-nonfree sharutils uudeview \
                    mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 \
                    libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool \
                    libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg \
                    libxine1-misc-plugins libxine1-plugins libxine1-x \
                    tagtool libavcodec-extra ffmpeg \
                    rar unrar oracle-java7-installer lame libavcodec-extra libav-tools -y --force-yes    
    }

    install_funcao_gimp()
    {
     	# variavel de verificação
        local var_gimp=$(which gimp)

        if [[ ! -e $var_gimp ]]; then
            printf "\n"
            printf "\n[+] instalando o Gimp"
            printf "\n[+] instalando o Gimp" >> $arquivo_log

            apt install gimp -y
        else
            printf "\n"
            printf "[+] Gimp já está instalado na sua máquina! \n"
        fi
    }

    install_xfce4()
    {
        printf "\n"
        printf "\n[+] instalando adicionais do XFCE" 
        printf "\n[+] instalando adicionais do XFCE" >> $arquivo_log

        #instalando componentes do XFCE
        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin \
                    xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin \
                    xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin \
                    xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin \
                    xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin \
                    xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin \
                    xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin \
                    xfce4-xkb-plugin xfce4-mount-plugin smartmontools -fyq

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp

        ## xfpanel-switch
        # variavel de verificação
        local var_xfpanel=$(which xfpanel-switch)

        if [[ ! -e $var_xfpanel ]]; then
            printf "\n"
            printf "\n[+] instalando Xfpanel-switch"
            printf "\n[+] instalando Xfpanel-switch" >> $arquivo_log

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb
        else
            printf "[+] Xfpanel-switch ja esta instalado \n"            
        fi

        ## whisker-menu
        ## variavel de verificacao
        local var_whiskermenu=$(which xfce4-popup-whiskermenu)

        if [[ ! -e $var_whiskermenu ]]; then
            printf "\n"
            printf "\n[+] instalando Whisker-menu"
            printf "\n[+] instalando Whisker-menu" >> $arquivo_log

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb
        else
            printf "[+] Whisker-menu ja esta instalado \n"            
        fi
    }

    install_wine()
    {
    	# variavel de verificação
        local var_wine=$(which wine)

        if [[ ! -e $var_wine ]]; then
            printf "\n"
            printf "\n[+] instalando o Wine" >> $arquivo_log

            if [[ $distro == "Ubuntu" ]]; then
                # adicionado o repositorio
                add-apt-repository ppa:ubuntu-wine/ppa -y

                # chamando funcao já criada
                update

                apt install wine -y
            elif [[ $distro == "Debian" ]]; then
            	# adicionando sistema multi-arch
            	dpkg --add-architecture i386
		
				# atualizando repositorios
				update

                apt-get install libgl1-mesa-glx:i386 libasound2:i386 libasound2-plugins:i386  \
                                ttf-mscoreinstall_fonts-installer:i386 \
                                wine-development -y
            else
            	printf "\n[-] Erro ao instalar Wine"
            	printf "\n[-] Erro ao instalar Wine" >> $arquivo_log
            fi
        else
            printf "\n"
            printf "[+] Wine já está instalado na sua máquina! \n"
        fi
    }

    install_playonlinux()
    {
        printf "\n"
        printf "\n[+] instalando o PlayonLinux"
        printf "\n[+] instalando o PlayonLinux" >> $arquivo_log

        apt install playonlinux -y
    }

    install_redshift()
    {
        printf "\n"
        printf "\n[+] instalando o Redshift"
        printf "\n[+] instalando o Redshift" >> $arquivo_log

        apt install redshift gtk-redshift -y        
    }

    install_libreoffice()
    {
		# se habilitar verificação, novas atualizações não serão instaladas.
		# libreoffice ja vem instalado por padrao na formataçao
# 		
# 		variavel de verificação 		
#         var_libreoffice=$(which libreoffice)
#
#         if [[ ! -e $var_libreoffice ]]; then
            printf "\n"
            printf "\n[+] instalando o Libreoffice"
            printf "\n[+] instalando o Libreoffice" >> $arquivo_log

            if [[ $distro == "Ubuntu" ]]; then
                #adicionando ppa
                add-apt-repository ppa:libreoffice/ppa -y

                #chamando funcao já definida
                update
            fi

            #instalando libreoffice
            apt-get install libreoffice libreoffice-style-breeze -y
#         else
#             printf "[+] Libreoffice já está instalado! \n"
#         fi
    }

    install_vlc()
    {
        printf "\n"
        printf "\n[+] instalando o VLC"
        printf "\n[+] instalando o VLC" >> $arquivo_log

        apt install vlc -y
    }

    install_clementine()
    {
        printf "\n"
        printf "\n[+] instalando o Clementine"
        printf "\n[+] instalando o Clementine" >> $arquivo_log

        apt install clementine -y
    }

    install_gparted()
    {
        printf "\n"
        printf "\n[+] instalando o Gparted"
        printf "\n[+] instalando o Gparted" >> $arquivo_log

        apt install gparted -y
    }

    install_tlp()
    {
        printf "\n"
        printf "\n[+] instalando o Tlp"
        printf "\n[+] instalando o Tlp" >> $arquivo_log

        apt install tlp -y
    }

    install_git()
    {
        printf "\n"
        printf "\n[+] instalando o Git"
        printf "\n[+] instalando o Git" >> $arquivo_log

        apt install git-core git -y
    }

    install_lm-sensors()
    {
        printf "\n"
        printf "\n[+] instalando o Lm-sensors"
        printf "\n[+] instalando o Lm-sensors" >> $arquivo_log

        apt install lm-sensors -y
    }

    install_stellarium()
    {
        # variavel de verificação
        local var_stellarium=$(which stellarium)

        if [[ ! -e $var_stellarium ]]; then
            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
                printf "\n"
                printf "\n[+] instalando o Stellarium"
                printf "\n[+] instalando o Stellarium" >> $arquivo_log

                #adicinando ppa
                add-apt-repository ppa:stellarium/stellarium-releases -y

                #atualizando sistema
                update
            fi

            #instalando o stellarium
            apt install stellarium* -y
        else
            printf "[+] Stellarium já está instalado!"
        fi
    }

    install_reaver()
    {
        printf "\n"
        printf "\n[+] instalando o Reaver"
        printf "\n[+] instalando o Reaver" >> $arquivo_log

        apt install reaver -y
    }  

    install_dolphin()
    {
        printf "\n"
        printf "\n[+] instalando o Dolphin"
        printf "\n[+] instalando o Dolphin" >> $arquivo_log

        if [[ $distro == "Ubuntu" ]]; then
            #adicionando repositorio do dolphin
            add-apt-repository ppa:glennric/dolphin-emu -y

            #atualizando lista de repositorios
            update

            #corrigindo problemas de dependencias
            apt-get install -f
        fi

        #instalando dolphin
        apt install dolphin-emu -y
    }

    install_visualgameboy()
    {
        printf "\n"
        printf "\n[+] instalando o Visual Game Boy"
        printf "\n[+] instalando o Visual Game Boy" >> $arquivo_log 

        if [[ $distro == "Ubuntu" ]]; then
        	apt install visualboyadvance-gtk -y
        elif [[ $distro == "Debian" ]]; then
        	apt install visualboyadvance -y
        else
        	printf "[-] ERRO - VisualGame"
        	printf "[-] ERRO - VisualGame" >> $arquivo_log
        fi
    }

    install_neofetch()
    {
        printf "\n"
        printf "\n[+] instalando o neofetch"
        printf "\n[+] instalando o neofetch" >> $arquivo_log

        apt install neofetch -y
    }

    install_kdenlive()
    {
        # variavel de verificação
        local var_kdenlive=$(which kdenlive)

        if [[ ! -e $var_kdenlive ]]; then
            printf "\n"
            printf "\n[+] instalando o Kdenlive"
            printf "\n[+] instalando o Kdenlive" >> $arquivo_log

            if [[ $distro == "Ubuntu" ]]; then
                #adicionando ppa
                add-apt-repository ppa:sunab/kdenlive-release -y

                #atualizando sistema
                update
            fi

            #instalando kdenlive
            apt install kdenlive -y
        else
            printf "[+] Kdenlive já está instalado!"
        fi
    }

    install_sweethome3d()
    {
        printf "\n"
        printf "\n[+] instalando Sweet Home 3D"
        printf "\n[+] instalando Sweet Home 3D" >> $arquivo_log

        apt install sweethome3d -y
    }

    install_cheese()
    {
        printf "\n"
        printf "\n[+] instalando o Cheese"
        printf "\n[+] instalando o Cheese" >> $arquivo_log

        apt install cheese -y
    }

    install_plank()
    {
        # variavel de verificação
        local var_plank=$(which plank)

        if [[ ! -e $var_plank ]]; then
            printf "\n"
            printf "\n[+] instalando o Plank Dock"
            printf "\n[+] instalando o Plank Dock" >> $arquivo_log

            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
                #adicionando ppa
                add-apt-repository ppa:noobslab/apps -y

                #atualizando lista repositorios
                update

                #instalando plank
            	apt-get install plank* plank-themer -y
            fi

            #instalando plank
            apt-get install plank* -y
        else
            printf "[+] Plank já está instalado! \n"
        fi
    }

    install_gnome_system_monitor()
    {
        printf "\n"
        printf "\n[+] instalando o Gnome System Monitor"
        printf "\n[+] instalando o Gnome System Monitor" >> $arquivo_log

        apt install gnome-system-monitor -y
    }

    install_nautilus()
    {
        # variavel de verificação
        local var_nautilus=$(which nautilus)

        if [[ ! -e $var_nautilus ]]; then
            printf "\n"
            printf "\n[+] instalando o Nautilus"
            printf "\n[+] instalando o Nautilus" >> $arquivo_log

            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
                #adicionando ppa
                add-apt-repository ppa:gnome3-team/gnome3 -y

                #atualizando lista repositorio
                update                
            fi

            #instalando o nautilus
            apt install nautilus* -y

        else
            printf "[+] Nautilus já está instalado! \n"
        fi
    }

    install_wireshark()
    {
        printf "\n"
        printf "\n[+] instalando o Wireshark"
        printf "\n[+] instalando o Wireshark" >> $arquivo_log

        apt install wireshark wireshark-gtk -y
    }

    install_gnome_disk_utility()
    {
        printf "\n"
        printf "\n[+] instalando o Gnome Disk Utility"
        printf "\n[+] instalando o Gnome Disk Utility" >> $arquivo_log

        apt install gnome-disk-utility -y
    }

    install_audacity()
    {
        printf "\n"
        printf "\n[+] instalando o Audacity"
        printf "\n[+] instalando o Audacity" >> $arquivo_log

        apt install audacity -y
    }

    install_simple_screen_recorder()
    {
        # variavel de verificação
        local var_simplescreenrecorder=$(which simplescreenrecorder)

        if [[ ! -e $var_simplescreenrecorder ]]; then
            printf "\n"
            printf "\n[*] instalando o Simple Screen Recorder"
            printf "\n[*] instalando o Simple Screen Recorder" >> $arquivo_log

            if [[ $distro == "Ubuntu" ]]; then
                #adicionando fonte
                add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

                #atualizando lista de repositorios
                apt-get update
            fi

            #instalando simplescreenrecorder
            apt-get install simplescreenrecorder simplescreenrecorder-lib:i386 -y
        else
            printf "[+] Simple Screen Recorder já está instalado! \n"
        fi
    }

    install_mega()
    {       
        # variavel de verificação
        local var_mega=$(which megasync)

        if [[ ! -e $var_mega ]]; then        
            printf "\n"
            printf "\n[+] instalando o MEGA"
            printf "\n[+] instalando o MEGA" >> $arquivo_log
            
            if [[ $distro == "Ubuntu" ]]; then
	            # instalando mega
	            dpkg -i base/packages/mega/*.deb

	            # corrigindo dependencias
	            apt install -fy

	            # instalando mega
	            dpkg -i base/packages/mega/*.deb
	        elif [[ $distro == "Debian" ]]; then
				# instalando megasync
				apt install megasync -y
	        fi
        else
            printf "[+] MEGA Sync já está instalado! \n"
        fi
    }

    install_openssh()
    {
        printf "\n"
        printf "\n[+] instalando o OpenSSH"
        printf "\n[+] instalando o OpenSSH" >> $arquivo_log

        apt install openssh* -y
    }

    install_figlet()
    {
        printf "\n"
        printf "\n[+] instalando o Figlet"
        printf "\n[+] instalando o Figlet" >> $arquivo_log

        apt install figlet -y
    }

    install_chkrootkit()
    {
        printf "\n"
        printf "\n[+] instalando o Chkrootkit"
        printf "\n[+] instalando o Chkrootkit" >> $arquivo_log

        apt install chkrootkit -y
    }

    install_localepurge()
    {
        printf "\n"
        printf "\n[+] instalando o Localepurge"
        printf "\n[+] instalando o Localepurge" >> $arquivo_log

        apt-get install localepurge -y
    }

    install_hardinfo()
    {
        printf "\n"
        printf "\n[+] instalando o Hardinfo"
        printf "\n[+] instalando o Hardinfo" >> $arquivo_log

        apt install hardinfo -y
    }

    install_nvidia()
    {
        # variavel de verificação
        local var_nvidia=$(which nvidia-settings)

        if [[ ! -e $var_nvidia ]]; then
            if [ $distro == "Ubuntu" ]; then
    		    printf "\n"
    		    printf "\n[+] instalando o driver da Placa Nvidia"
    		    printf "\n[+] instalando o driver da Placa Nvidia" >> $arquivo_log

    		    apt-add-repository ppa:graphics-drivers/ppa -y
    		    apt-add-repository ppa:ubuntu-x-swat/x-updates -y
    		    apt-add-repository ppa:xorg-edgers/ppa -y

    		    update

    		    apt install nvidia-current nvidia-settings -y  
            elif [[ $distro == "Debian" ]]; then
                # adicionando repositorio
        		echo "deb http://httpredir.debian.org/debian/ stretch main contrib non-free" >> /etc/apt/sources.list

                # atualizando sistema
        	    update

                # instalando driver
        	    apt install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-driver
            else
                printf "\nDistribuiçao desconhecida"
            fi
        else
            printf "[+] Nvidia já está instalado no sistema! \n"
        fi
    }

    install_virtualbox()
    {
        # variavel de verificação
        local var_virtualbox=$(which virtualbox)

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_virtualbox ]]; then    
            printf "\n"
            printf "[*] instalando Virtualbox \n"

            if [ $distro == "Ubuntu" ]; then
                apt install virtualbox-5.1 -y
            elif [ $distro == "Debian" ]; then      
                # instalando virtualbox
                apt install virtualbox -y              
            fi            
        else
            printf "[+] VirtualBox já está instalado! \n"
        fi
    }

    install_ristretto()
    {
    	printf "\n"
        printf "\n[+] instalando o Ristretto"
        printf "\n[+] instalando o Ristretto" >> $arquivo_log	

        apt install ristretto -y
    }

    install_tree()
    {
        printf "\n"
        printf "\n[+] instalando o Tree"
        printf "\n[+] instalando o Tree" >> $arquivo_log

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        local var_pulseeeffects=$(which pulseeffects)

        if [[ ! -e $var_pulseeeffects ]]; then
            printf " \n"
            printf "\n[+] instalando o Pulse Effects"
            printf "\n[+] instalando o Pulse Effects" >> $arquivo_log

            if [ $distro == "Ubuntu" ]; then
	            # adicionando via flatpak
	            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	            # instalando via flatpak
	            flatpak install flathub com.github.wwmm.pulseeffects	        
	        elif [ $distro == "Debian" ]; then
                echo
	        fi
        else
            printf "\n"
            printf "[+] Pulse Effects já está instalado"
            printf "\n"
        fi
    }
    
    install_terminator()
    {
        printf " \n"
        printf "\n[+] instalando o Terminator"
        printf "\n[+] instalando o Terminator" >> $arquivo_log
        
        apt install terminator -y
    }

    install_aircrack()
    {
        printf " \n"
        printf "\n[+] instalando o Aircrack-ng"
        printf "\n[+] instalando o Aircrack-ng" >> $arquivo_log

        apt install aircrack-ng -y
    }

    install_snap()
    {
        printf "\n"
        printf "\n[+] instalando o Snap"
        printf "\n[+] instalando o Snap" >> $arquivo_log

        apt install snapd -y      
    }

    install_ntp()
    {
        printf "\n"
        printf "\n[+] instalando o NTP"
        printf "\n[+] instalando o NTP" >> $arquivo_log

        #instalando software necessario
        apt install ntp ntpdate -y
    }

    install_xclip()
    {
        printf "\n"
        printf "\n[+] instalando o Xclip"
        printf "\n[+] instalando o Xclip" >> $arquivo_log

        apt install xclip -y
    }

    install_espeak()
    {
    	printf "\n"
        printf "\n[+] instalando o Speak"
        printf "\n[+] instalando o Speak" >> $arquivo_log

        apt install espeak -y	
    }

    install_ibus()
    {
        printf "\n"
        printf "\n[+] instalando o Ibus"
        printf "\n[+] instalando o Ibus" >> $arquivo_log

        apt install ibus -y
    }

    install_nmap()
    {
        printf "\n"
        printf "\n[+] instalando o Nmap"
        printf "\n[+] instalando o Nmap" >> $arquivo_log

        apt install nmap -y
    }

    install_htop()
    {
        printf "\n"
        printf "\n[+] instalando o Htop" >> $arquivo_log

        apt install htop -y
    }

    install_gnome_calculator()
    {
        printf "\n"
        printf "\n[+] instalando o Gnome Calculator"
        printf "\n[+] instalando o Gnome Calculator" >> $arquivo_log

        apt install gnome-calculator -y
    }

    install_tuxguitar()
    {
        # variavel de verificação
        local var_tuxguitar=$(which tuxguitar-vs)

        # criando verificação para instalar o tuxguitar
        if [[ ! -e $var_tuxguitar ]]; then
            printf "\n"
            printf "\n[+] instalando Tux Guitar"
            printf "\n[+] instalando Tux Guitar" >> $arquivo_log                

            if [ $distro == "Ubuntu" ]; then
              snap install tuxguitar-vs
            elif [ $distro == "Debian" ]; then
                apt install tuxguitar timidity -y
            fi
        else
            printf "[+] TuxGuitar já está instalado \n"
        fi
    }

    install_musescore()
    {
        # variavel de verificação
        local var_musescore=$(which musescore)

        # criando verificação para instalar o musescore
        if [[ ! -e $var_musescore ]]; then
            printf "\n"
            printf "\n[+] instalando Muse Score"
            printf "\n[+] instalando Muse Score" >> $arquivo_log

            if [ $distro == "Ubuntu" ]; then
              snap install musescore
            elif [ $distro == "Debian" ]; then
                apt install musescore -y 
            fi
        else
            printf "\n"
            printf "\n[+] O Musescore já está instalado no seu sistema."
        fi
    }

    install_zsh()
    {
        # variavel de verificação
        local var_zsh=$(which zsh)

        printf "\n"
        printf "\n[+] instalando o ZSH"
        printf "\n[+] instalando o ZSH" >> $arquivo_log


		# criando verificação para instalar zsh
        if [[ ! -e $var_zsh ]]; then
	        apt install zsh zsh-common -y
	    fi
    }

    install_docker()
    {
        # variavel de verificação
        local var_docker=$(which docker)

        # criando verificação para instalar o docker
        if [[ ! -e $var_docker ]]; then
            printf "\n"
            printf "\n[+] instalando o Docker" >> $arquivo_log

            apt install docker-compose -y

            if [[ $distro == "Ubuntu" ]]; then
        		apt install docker-io -y
        	elif [[ $distro == "Debian" ]]; then            
                # instalando docker
                printf "\n[*] instalando docker"
                printf "\n[*] instalando docker" >> $arquivo_log
    
                curl -fsSL https://get.docker.com/ | sh                
            else
            	printf "\n"
            fi
        else
            printf "\n"
            printf "\n[+] O Docker já está instalado no seu sistema."
        fi
    }

    install_sublime()
    {
         # variavel de verificação
        local var_sublime=$(which subl)

        # criando verificação para instalar o docker
        if [[ ! -e $var_sublime ]]; then
            printf "\n"

            # printf "\n[*] Baixando o Sublime"
            # printf "\n[*] Baixando o Sublime" >> $arquivo_log

            # wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb

            # printf "\n[*] instalando o Sublime"
            # printf "\n[*] instalando o Sublime" >> $arquivo_log

            # dpkg -i sublime-text_build-3083_amd64.deb

            # # removendo arquivo da pasta posinstalacao - caso nao exista problemas na instalacao do programa            
            # rm sublime-text_build-3083_amd64.deb


            if [ $distro == "Ubuntu" ]; then
                # wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - 
                # apt install apt-transport-https -y 
                # echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
                
                # update  
                
                # apt install sublime-text -y

                printf "\n[*] Baixando o Sublime"
                printf "\n[*] Baixando o Sublime" >> $arquivo_log

                wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb

                printf "\n[*] instalando o Sublime"
                printf "\n[*] instalando o Sublime" >> $arquivo_log

                dpkg -i sublime-text_build-3083_amd64.deb

                # removendo arquivo da pasta posinstalacao - caso nao exista problemas na instalacao do programa            
                rm sublime-text_build-3083_amd64.deb
                
            elif [ $distro == "Debian" ]; then
     			apt install sublime-text -y
            fi            
        else
            printf "\n"
            printf "\n[-] Sublime ja esta instalado"
            printf "\n[-] Sublime ja esta instalado" >> $arquivo_log            
        fi
    }

    install_firmware()
    {
        printf "\n"
        printf "\n[+] instalando os firmware's non-free"        
        printf "\n[+] instalando os firmware's non-free" >> $arquivo_log        
        
        apt install firmware-linux firmware-linux-nonfree \
        			xserver-xorg-input-synaptics blueman  \
        			firmware-brcm80211 -y			
    }     

    install_compton()
    {
    	printf "\n"
        printf "\n[+] instalando o Compton"        
        printf "\n[+] instalando o Compton" >> $arquivo_log        

    	apt install compton compton-conf -y

        printf "\n[*] configurando Compton"        
        printf "\n[*] configurando Compton" >> $arquivo_log                

        cat base/compton.conf >> $HOME/.config/compton.conf

        if [[ $? == "0" ]]; then
            printf "\n[*] configuraçao atualizada Compton"        
            printf "\n[*] configuraçao atualizada Compton" >> $arquivo_log                            
        else
            printf "\n[-] ERRO - configuraçao atualizada Compton"        
            printf "\n[-] ERRO - configuraçao atualizada Compton" >> $arquivo_log                            
        fi
    }

    install_python()
    {        
        printf "\n"
        printf "\n[+] instalando o Pip" 
        printf "\n[+] instalando o Pip" >> $arquivo_log        

        apt install python3.5 python-pip -y

    	if [ $distro == "Debian" ]; then
 			apt install pipsi -y # instalando pip
        fi   
    }

    install_youtubedl()
    {
        printf "\n"
        printf "\n[+] instalando o Youtube-DL" 
        printf "\n[+] instalando o Youtube-DL" >> $arquivo_log 

        apt install youtube-dl -y
    }

    install_yad()
    {
		printf "\n"
        printf "\n[+] instalando o YAD" 
        printf "\n[+] instalando o YAD" >> $arquivo_log 

        apt install yad -y    	
    }

    install_dropbox()
    {
        printf "\n"
        printf "\n[+] instalando Dropbox"
        printf "\n[+] instalando Dropbox" >> $arquivo_log

        apt install nautilus-dropbox -y
    }

    install_transmission()
    {
        local var_transmission=$(which transmission-gtk)

        # verificando se transmission está instalado
        if [[ ! -e $var_transmission ]]; then
            printf "\n"
            printf "\n[+] instalando o Transmission"
            printf "\n[+] instalando o Transmission" >> $arquivo_log    

            apt install transmission-gtk -y
        fi
    }

    install_xfburn()
    {
        printf "\n"
        printf "\n[+] instalando XFBurn"
        printf "\n[+] instalando XFBurn" >> $arquivo_log

        apt install xfburn -y
    }

    install_wavemon()
    {
        printf "\n"
        printf "\n[+] instalando o Wavemon"        
        printf "\n[+] instalando o Wavemon" >> $arquivo_log        

        apt install wavemon -y
    }

    install_mugshot()
    {
        printf "\n"
        printf "\n[+] instalando o Mugshot"        
        printf "\n[+] instalando o Mugshot" >> $arquivo_log        

        apt install mugshot -y
    }

    install_simplescan()
    {
        printf "\n"
        printf "\n[+] instalando o Simple-scan"        
        printf "\n[+] instalando o Simple-scan" >> $arquivo_log        

        apt install simple-scan -y
    }

    install_wireshark()
    {
        printf "\n"
        printf "\n[+] instalando o Wireshark"
        printf "\n[+] instalando o Wireshark" >> $arquivo_log

        apt install wireshark -y
    }

    install_prelink()
    {
        printf "\n[*] instalando Prelink"
        printf "\n[*] instalando Prelink" >> $arquivo_log

        apt install prelink -y         
    }   

    install_prelink()
    {
        #instalando prelink, preload, deborphan para um melhor performance do sistema
        printf "\n[*] instalando Preload"
        printf "\n[*] instalando Preload" >> $arquivo_log

        apt install preload -y         
    }   

    install_deborphan()
    {
        printf "\n[*] instalando Deborphan"
        printf "\n[*] instalando Deborphan" >> $arquivo_log

        apt-get install deborphan -y
    }


# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_atualiza()
{
    notify-send -u normal "atualizando sistema" -t 10000

    clear

    update
    upgrade
}

func_corrige()
{
    notify-send -u normal "Corrigindo sistema" -t 10000

    apt_check
    apt_install
    apt_remove
    apt_clean        
    
    pacotes_quebrados      

    atualiza_db   

	if [[ $v_hostname == 'notebook' ]]; then               
        if [ $distro == "Ubuntu" ]; then        
            apt_update_local
            apt_auto            
        elif [ $distro == "Debian" ]; then              
            printf ""   
        fi
    elif [[ $v_hostname == 'desktop' ]]; then        
        if [ $distro == "Ubuntu" ]; then           
            apt_update_local
            apt_auto
            apport
        elif [ $distro == "Debian" ]; then      
            printf ""   
        fi
    else
        printf "\n[-] ERRO corrige!"
    fi

    # realizando atualização
    update
}

func_config()
{
    notify-send -u normal "configurando o sistema" -t 10000	

    apport
    config_ntp  

    swap
    prelink_preload_deborphan

    autologin
    arquivo_hosts
    chaveiro

    icones_temas
    config_idioma
}

func_limpa()
{
    notify-send -u normal "limpando sistema" -t 10000

    clear   

    pacotes_orfaos
    funcao_chkrootkit
    func_localepurge
}

func_instala()
{
    notify-send -u normal "instalando programas no sistema" -t 10000	

	install_firefox
	install_chromium	
	install_tor

	install_codecs
	install_vlc
	install_clementine
	install_spotify	   
	install_funcao_gimp
	install_musescore
	install_simple_screen_recorder
	install_sweethome3d   
	install_tuxguitar  
	install_wine
    install_playonlinux              
    install_stellarium
    install_libreoffice 

	install_xfce4
    install_lm-sensors    
    install_nautilus
    install_openssh    
    install_reaver
    install_redshift
    install_ristretto    
    install_neofetch
    install_lm-sensors    
    install_tlp	   

    install_mega
    install_pulseeffects

    install_zsh          
    install_ibus
    install_openssh
    install_figlet        
    install_xclip 
    install_nmap
    install_snap    
    install_gparted
    install_espeak      
    install_tree        
    install_chkrootkit    
    install_htop         
    install_hardinfo
    install_nmap    
    install_figlet           
    install_gnome_disk_utility
    install_gnome_system_monitor    
    install_gnome_calculator
    install_compton
    install_xfburn
    install_mugshot
    install_simplescan 
    install_git
	install_python    
	install_sublime
    install_terminator
    install_youtubedl
    install_yad       
	install_ntp 
	install_localepurge  

    install_prelink
    install_preload
    install_deborphan    

	if [[ $v_hostname == 'notebook' ]]; then		
        install_cheese
        install_aircrack  
        install_wavemon	   

		if [ $distro == "Ubuntu" ]; then		
			# nenhuma acao, por enquanto
			echo
		elif [ $distro == "Debian" ]; then				
	    	install_firmware  		    
		fi
	elif [[ $v_hostname == 'desktop' ]]; then         
		install_visualgameboy
	    install_dolphin

		install_audacity
    	install_kdenlive
        install_nvidia      
                
        install_transmission        
	else
		printf "\n[-] ERRO instala!"
	fi
}

func_instala_outros()
{      
    install_fonts
    install_wireshark 

    # verificando computador
    if [[ $v_hostname == 'desktop' ]]; then
        install_virtualbox
        install_steam        
    fi
}

func_remove()
{
	notify-send -u normal "Removendo programas no sistema" -t 10000

	printf "\n\n[+] Removendo programas" >> $arquivo_log
    apt purge thunderbird parole inkscape* blender* \
              exfalso* quodlibet* xterm* pidgin* meld* gtkhash* \
              xsane* imagemagick* chromium-bsu* owncloud* -y
    
    if [[ $v_hostname == 'notebook' ]]; then
    	apt purge kstars* steam* kdenlive* \
    	          transmission* smartgit* gitg* -y
    else
    	printf "\n"	   
    fi
}

func_formatado()
{
    # atualizando sistema
    func_atualiza

    # instalando programas
    func_instala    
    
    # removendo programas pré-instalados, desnecessários
    func_remove

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # desligando a maquina apos configuração
    halt -p
}

func_todas()
{
# atualizando sistema
    func_atualiza

    # instalando programas
    func_instala

    # instalando programas extras - talvez precise da interacao do usuario
    func_instala_outros

    # removendo programas pré-instalados, desnecessários
    func_remove

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # configurando o sistema
    func_config

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza
}

func_vetor()
{
    # percorrendo vetor atualiza
    for (( i = 0; i <= ${#atualiza[@]}; i++ )); do             
        # saindo do script
        if [[ ${atualiza[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${atualiza[$i]}

            # saindo do script
            exit 0                
        fi
    done

    # percorrendo vetor corrige
    for (( i = 0; i <= ${#corrige[@]}; i++ )); do 
        # saindo do script
        if [[ ${corrige[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${corrige[$i]}

            # saindo do script
            exit 0                
        fi
    done

    # percorrendo vetor config
    for (( i = 0; i <= ${#config[@]}; i++ )); do 
        # saindo do script
        if [[ ${config[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${config[$i]}

            # saindo do script
            exit 0                
        fi
    done

    # percorrendo vetor limpa
    for (( i = 0; i <= ${#limpa[@]}; i++ )); do 
        # saindo do script
        if [[ ${limpa[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${limpa[$i]}

            # saindo do script
            exit 0                
        fi
    done

    # percorrendo vetor instala
    for (( i = 0; i <= ${#instala[@]}; i++ )); do 
        # saindo do script
        if [[ ${instala[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${instala[$i]}

            # saindo do script
            exit 0                
        fi
    done   

    # percorrendo vetor instala outros
    for (( i = 0; i <= ${#instala_outros[@]}; i++ )); do 
        # saindo do script
        if [[ ${instala_outros[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${instala_outros[$i]}

            # saindo do script
            exit 0                
        fi
    done   

    # mostrando ajuda para o usuario - vetores individuais
    if [[ "$escolha_vetor" = "ajuda" ]]; then
        if [[ "$help_vetor" = "atualiza" ]]; then
            printf "\n--------"
            printf "\nAtualiza"
            printf "\n--------\n"
            for (( i = 0; i <= ${#atualiza[@]}; i++ )); do             
                echo ${atualiza[$i]}
            done    

			sleep $aguarda

            exit 0            
        fi
        
        if [[ "$help_vetor" = "corrige" ]]; then
            printf "\n--------"
            printf "\nCorrige"
            printf "\n--------\n"
            for (( i = 0; i <= ${#corrige[@]}; i++ )); do             
                echo ${corrige[$i]}
            done

            sleep $aguarda

            exit 0
        fi

        if [[ "$help_vetor" = "config" ]]; then
            printf "\n------"
            printf "\nConfig"
            printf "\n------\n"
            for (( i = 0; i <= ${#config[@]}; i++ )); do             
                echo ${config[$i]}
            done

			sleep $aguarda

            exit 0
        fi

        if [[ "$help_vetor" = "limpa" ]]; then
            printf "\n-----"
            printf "\nLimpa"
            printf "\n-----\n"
            for (( i = 0; i <= ${#limpa[@]}; i++ )); do             
                echo ${limpa[$i]}
            done

            sleep $aguarda

            exit 0
        fi

        if [[ "$help_vetor" = "instala" ]]; then
            printf "\n-------"
            printf "\nInstala"
            printf "\n-------\n"
            for (( i = 0; i <= ${#instala[@]}; i++ )); do             
                echo ${instala[$i]}
            done

            sleep $aguarda

            exit 0
        fi

        if [[ "$help_vetor" = "instala_outros" ]]; then
            printf "\n--------------"
            printf "\nInstala Outros"
            printf "\n--------------\n"
            for (( i = 0; i <= ${#instala_outros[@]}; i++ )); do             
                echo ${instala_outros[$i]}
            done

            sleep $aguarda

            exit 0
        fi

        # vetores agrupados
        if [[ "$help_vetor" -eq "help" ]]; then
            printf "\n--------"
            printf "\nAtualiza"
            printf "\n--------\n"
            for (( i = 0; i <= ${#atualiza[@]}; i++ )); do             
                echo ${atualiza[$i]}
            done

            sleep $aguarda

            printf "\n--------"
            printf "\nCorrige"
            printf "\n--------\n"
            for (( i = 0; i <= ${#corrige[@]}; i++ )); do             
                echo ${corrige[$i]}
            done

			sleep $aguarda

            printf "\n------"
            printf "\nConfig"
            printf "\n------\n"
            for (( i = 0; i <= ${#config[@]}; i++ )); do             
                echo ${config[$i]}
            done

            sleep $aguarda

            printf "\n-----"
            printf "\nLimpa"
            printf "\n-----\n"
            for (( i = 0; i <= ${#limpa[@]}; i++ )); do             
                echo ${limpa[$i]}
            done

            sleep $aguarda

            printf "\n-------"
            printf "\nInstala"
            printf "\n-------\n"
            for (( i = 0; i <= ${#instala[@]}; i++ )); do             
                echo ${instala[$i]}
            done

            sleep $aguarda

			printf "\n--------------"
            printf "\nInstala Outros"
            printf "\n--------------\n"
            for (( i = 0; i <= ${#instala_outros[@]}; i++ )); do             
                echo ${instala_outros[$i]}
            done

			sleep $aguarda

            exit 0               
        fi
    fi
}

version()
{
	echo "versao do script: $versao"
    echo "Autor do script: $autor"
    echo "Contato: Email: '$email'; Twitter: '$twitter'"
}

func_interface_zenity()
{
	f_verifica()
	{
		[[ $? == "1" ]] && \
			zenity --notification \
				   --text "Script finalizado, antes do esperado!" && exit 1
	}

	valor=$(zenity --list --title="Automatizar de tarefas" \
        	   --text="Deseja executar o script, de forma..."  \
        	   --column="Marque" --column="Modo" \
        	   --radiolist \
        	   TRUE Automatica \
        	   FALSE Manual \
    ) ; f_verifica	
    
    if [[ $valor == "Automatica" ]]; then
            escolha=$(
            	zenity --list --title="Automatizar de tarefas" \
	        	   --text="O que deseja fazer?"  \
	        	   --width "150" \
	        	   --height "300" \
	        	   --column="Select" --column="Acao" \
	        	   --radiolist \
    	        	   	TRUE Todas \
                        FALSE atualizar \
                        FALSE Corrigir \
                        FALSE configurar \
                        FALSE limpar \
                        FALSE instalar \
                        FALSE Remover \
            ) ; f_verifica

            # executa funcao X e saida do script
			[[ $escolha == "Todas" ]] && func_todas && exit 0 ||
			[[ $escolha == "atualizar" ]] && func_atualiza && exit 0 ||
			[[ $escolha == "Corrigir" ]] && func_corrige && exit 0 ||
            [[ $escolha == "configurar" ]] && func_config && exit 0 ||
			[[ $escolha == "limpar" ]] && func_limpa && exit 0 ||
			[[ $escolha == "instalar" ]] && func_instala && exit 0 ||
			[[ $escolha == "Remover" ]] && func_remove && exit 0
	elif [[ $valor == "Manual" ]]; then
		escolha=$(zenity --list --title="Automatizar de tarefas" \
        	   --text="O que deseja fazer?"  \
        	   --width "150" \
        	   --height "200" \
        	   --column "" --column="Marque" \
        	   --radiolist \
                    TRUE atualiza \
                    FALSE corrige \
                    FALSE config \
                    FALSE limpa \
                    FALSE instala \
        ) ; f_verifica        

        for (( i = 0; i <= ${#vetor[@]}; i++ )); do  
            if [[ ${vetor[$i]} == $escolha ]]; then   
                if [[ $escolha == "atualiza" ]]; then                        	
                    for (( i = 0; i < ${#atualiza[@]}; i++ )); do	                        	                       
                    	acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${atualiza[$i]}"
                        ) ; f_verifica
                    done
                elif [[ $escolha == "corrige" ]]; then
                	for (( i = 0; i < ${#corrige[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${corrige[$i]}"                                        	
                        ) ; f_verifica
                    done
                elif [[ $escolha == "config" ]]; then
                    for (( i = 0; i < ${#config[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${config[$i]}"                                         
                        ) ; f_verifica
                    done
                elif [[ $escolha == "limpa" ]]; then
                	for (( i = 0; i < ${#limpa[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${limpa[$i]}"                                        	
                        ) ; f_verifica
                    done
                elif [[ $escolha == "instala" ]]; then
                	for (( i = 0; i < ${#instala[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${instala[$i]}"                                        	
                        ) ; f_verifica
                    done
                else
                	echo "ERRO"
                fi

                    # for chave in ${!atualiza[@]}; do 
                    # for chave in ${vetor[$i]}; do                                                                                

                    # done              
						
                        # copy[$chave]=${original[$chave]}

						# tamanho=${#array[@]}
						# echo "$chave = ${atualiza[$chave]}"; 

						# copy=${$atualiza[*]}
						# echo "$chave"; 

						# escolha=$(
			# 				zenity --title="Modo manual" \
			# 					--width="300" --height=250 \
			# 					--list \
			# 					--text="Selecione as açoes" \
   #                              --column "" --column="Marque" --column="Acao" \                                    
								# --separator=" " \
                                # --checklist FALSE 1 "atualiza" \
						# )
						# escolha=$(
						# 	dialog  --stdout --separate-output \
   #                              --checklist "escolha algo" \
   #                              0 0 0 \
   #                          	"$chave" "${atualiza[$chave]}" off \
   #                          )
                    # done     

  #                   # echo ${copy[*]}

  #               elif [[ $escolha == 1 ]]; then                    
  #                   printf ""
  #               elif [[ $escolha == 2 ]]; then
  #                   printf ""
  #               elif [[ $escolha == 3 ]]; then
  #                   for chave in ${instala[@]}; do 
					# 	# echo "$chave = ${instala[$chave]}"; 
					# 	echo "$chave";
					# done
  #               elif [[ $escolha == 4 ]]; then
  #                   printf ""
  #               else
  #                   printf ""
  #               fi        
                break;                                                    
            fi
        done        
        # esac
    else
        echo
    fi
}


#mostrando mensagem inicial
menu()
{
    clear    

    # executando menu
    auto_config
}

main()
{
    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    # INICIANDO SCRIPT
    # paramentros iniciais
    escolha_vetor=$2 # recebe para vetor
    help_vetor=$3	 # recebe para ajuda
  
  	## mostra intro e sai
  	[[ $# -eq 0 ]] && func_help && exit 0

    for i in "$@"; 
    do    	
    	## mostra mensagem e sai
    	[[ $1 == "vetor" ]] && [[ $2 == "" ]] && clear && echo $mensagem_ajuda && exit 0

    	# armazena log no arquivo
	    [[ $? = 0 ]] && date > $arquivo_log

        # verificando o que foi digitado
        case $i in
            todas) func_todas;;
            formatado) func_formatado;;
            atualiza) func_atualiza;;
            corrige) func_corrige;;
            config) func_config;;
            limpa) func_limpa;;
            instala) func_instala;;
            remove) func_remove;;
            nvidia) nvidia;;
    		versao) version;;
            vetor) func_vetor;;
    		interface) func_interface_zenity;;
            *) clear && echo $mensagem_erro && exit 1
        esac    

        [[ $? = 0 ]] && date >> $arquivo_log
    done
}

## chamando script
main $@

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #