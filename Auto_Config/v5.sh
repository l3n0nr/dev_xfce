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
# # Atualiza sistema
    update()
    {
        #Atualizando lista de repositorios
        printf "\n[*] Atualizando lista de repositorios do sistema"
        printf "\n[*] Atualizando lista de repositorios do sistema" >> $arquivo_log
        	apt update
    }

    upgrade()
    {
        # verificando distribuição
        if [ $distro = "Ubuntu" ]; then            
        	#Atualizando lista de programas do sistema
        	printf "\n[*] Atualizando lista de programas do sistema \n"
	        printf "\n[*] Atualizando lista de programas do sistema \n" >> $arquivo_log
	        	apt upgrade -y

	        #Atualizando repositorio local
	        printf "\n[*] Atualizando repositório local dos programas \n"
	        printf "\n[*] Atualizando repositório local dos programas \n" >> $arquivo_log
	        	auto-apt updatedb
		else
        	#Atualizando lista de programas do sistem
        	printf "\n[*] Atualizando lista de programas do sistema \n"
	        printf "\n[*] Atualizando lista de programas do sistema \n" >> $arquivo_log
                ## atualizacao segura
		        apt upgrade -y
                
                if [[ $agressive_mode == "1" ]]; then
	                ## atualizacoes com mudanças - atualizacoes completas                
	                # MODE VIDA LOKA ON - Os usuarios do ~Debian Stable~, podem pirar na batatinha... huehuehue
	                apt dist-upgrade -y 
	                apt full-upgrade -y	
                fi
		fi
    }

# # # # # # # # # #
# # corrige SISTEMA
    apt_check()
    {
        #verificando lista do apt
        printf "\n[*] Verificando lista do apt"
        printf "\n[*] Verificando lista do apt" >> $arquivo_log
        
        apt-get check -y
    }

    apt_install()
    {
        #Instalando possiveis dependencias
        printf "\n[*] Instalando dependências pendentes"
        printf "\n[*] Instalando dependências pendentes" >> $arquivo_log

        apt-get install -fy
    }

    apt_remove()
    {
        #removendo possiveis dependencias
        printf "\n[*] Removendo possíveis dependências obsoletas"
        printf "\n[*] Removendo possíveis dependências obsoletas" >> $arquivo_log

        apt-get remove -fy
    }

    apt_clean()
    {
        #Limpando lista arquivos sobressalentes
        printf "\n[*] Limpando arquivos sobressalentes"
        printf "\n[*] Limpando arquivos sobressalentes" >> $arquivo_log
        
        rm -rf /var/lib/dpkg/info/*.*

        apt-get clean 
        apt-get install -f

        update
    }

    apt_auto()
    {
        #corrigindo problemas de dependencias
        printf "\n[*] Corrigindo problemas de dependências"
        printf "\n[*] Corrigindo problemas de dependências" >> $arquivo_log
        
        apt-get install auto-apt -y
    }

    apt_update_local()
    {
        #corrigindo repositorio local de dependencias automaticamente
        printf "\n[*] Corrigindo repositório local de dependências automaticamente"
        printf "\n[*] Corrigindo repositório local de dependências automaticamente" >> $arquivo_log
        
        auto-apt update-local
        apt list --upgradable
    }

    pacotes_quebrados()
    {
        #corrigindo pacotes quebrados
        printf "\n[*] Corrigindo pacotes quebrados"
        printf "\n[*] Corrigindo pacotes quebrados" >> $arquivo_log

        #corrige possiveis erros na instalação de softwares
        dpkg --configure -a

        # corrigindo problema nos pacotes
        apt install -f 
        apt update --fix-missing 
        apt-get --fix-broken install

        # Atualizando versao dos pacotes instalados
        apt list --upgradable

        #VERIFICAR AÇÕES
        rm -r /var/lib/apt/lists
        mkdir -p /var/lib/apt/lists/partial
    }    

    atualiza_db()
    {
        printf "\n[*] Atualizando base de dados do sistema"        
        printf "\n[*] Atualizando base de dados do sistema" >> $arquivo_log

    	updatedb
    }

    ## LAST_ATUALIZA

# # # # # # # # # #
# # config SISTEMA    
    swap()
    {        
        ## realizando testes em /etc/sysctl.conf
        memoswap=$(grep vm.swappiness /etc/sysctl.conf)
        memocache=$(grep vm.vfs_cache_pressure /etc/sysctl.conf)
        background=$(grep "vm.dirty_background_ratio" /etc/sysctl.conf)
        ratio=$(grep "vm.dirty_ratio" /etc/sysctl.conf)

        [[ $memoswap = "" ]] && echo vm.swappiness=$swappiness >> /etc/sysctl.conf && \
        [[ $memocache = "" ]] && echo vm.vfs_cache_pressure=$cache_pressure >> /etc/sysctl.conf && \
        [[ $background = "" ]] && echo vm.dirty_background_ratio=$dirty_background_ratio >> /etc/sysctl.conf && \
        [[ $ratio = "" ]] && echo vm.dirty_ratio=$dirty_ratio >> /etc/sysctl.conf && \
                printf "\n[+] Swap otimizada \n" && printf "\n[+] Swap otimizada \n" >> $arquivo_log || \
                printf "\n[-] Não há nada para ser otimizado - Swap \n" && printf "\n[-] Não há nada para ser otimizado - Swap \n" >> $arquivo_log        
    }

    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas        

		echo "[*] Configurando Deborphan... "
        echo "[*] Configurando Deborphan... " >> $arquivo_log

        deborphan | xargs apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #Configurando o prelink e o preload
        echo "[*] Configurando Prelink e Preload... "
        echo "[*] Configurando Prelink e Preload... " >> $arquivo_log        
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)

		printf "[*] Ativando o PRELINK"
        printf "[*] Ativando o PRELINK" >> $arquivo_log

        if [[ $prelink = "PRELINKING=unknown" ]]; then
            printf "adicionando ... \n"
            sed -i 's/unknown/yes/g' /etc/default/prelink
        else
        	printf "\n[-] Otimização já adicionada anteriormente."
            printf "\n[-] Otimização já adicionada anteriormente." >> $arquivo_log
        fi
    }


    install_fonts()
    {
        #corrigindo erros fontes
        printf "\n[*] Instalando pacotes de fontes"
        printf "\n[*] Instalando pacotes de fontes" >> $arquivo_log

        apt install ttf-mscoreinstall_fonts-installer install_fonts-noto ttf-freefont -f 
    }    

    config_ntp()
    {
        printf "\n[*] Configurando o NTP"
        printf "\n[*] Configurando o NTP" >> $arquivo_log

        #parando o serviço NTP para realizar as configuraçoes necessarias
        printf "\n[*] Parando serviço NTP para realizaçao das configuraçoes necessarias"           
            service ntp stop

        #Configurando script base - NTP
        printf "\n[*] Realizando alteraçao no arquivo base "
        cat base/ntp.txt > /etc/ntp.conf

        #ativando servico novamente
        printf "\n[*] Ativando serviço NTP"        
            service ntp start

        #realizando atualizacao hora/data
        printf "\n[*] Atualizando hora do servidor"
        printf "\n[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"

        printf "\n[*] Atualizando servidores, aguarde..."
        printf "\n[*] NIC.BR\n"
            ntpdate -q $ntp_server

        if [[ $? = "0" ]]; then
            printf "\n[+] Hora do computador sincronizada!\n"
            printf "\n[+] Hora do computador sincronizada!\n" >> $arquivo_log
        else
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n"
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n" >> $arquivo_log
        fi    
    }

    apport()
    {
        printf "\n[*] Removendo possiveis erros com o apport \n"
        printf "\n[*] Removendo possiveis erros com o apport \n" >> $arquivo_log

        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport
    }   

    arquivo_hosts()
    {
        printf "\n[*] Alterando arquivo Hosts"
        printf "\n[*] Alterando arquivo Hosts" >> $arquivo_log
        echo; echo

        ## gerando arquivo
        echo "127.0.0.1   $(hostname)" > base/hosts/hosts
        cat base/hosts/base >> base/hosts/hosts
        cat base/hosts/spotify >> base/hosts/hosts

        ## copiando arquivo para /etc/hosts
        cat base/hosts/hosts > /etc/hosts               

        ## removendo hosts apos configuracao
        rm base/hosts/hosts
    }

    chaveiro()
    {
        printf "\n[*] Removendo o chaveiro da sessão"
        printf "\n[*] Removendo o chaveiro da sessão" >> $arquivo_log

        apt-get remove gnome-keyring -y
    }   

    autologin()
    {       
        if [[ $boolean_autologin = "1" ]]; then
            local var_autologin="/usr/share/lightdm/lightdm.conf.d/01_debian.conf"

            # verificando se existe "autologin-user=$usuario" no arquivo '/etc/lightdm/lightdm.conf'
            # var_autologin=$(cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario")        
            # cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario" > /dev/null        

            cat $var_autologin | grep "autologin-user=$autor" > /dev/null

            # se saida do echo $? for 1, entao realiza modificacao
            # if [[ $var_autologin = "1" ]]; then
            if [[ $? = "1" ]]; then    
                if [[ $distro = "Debian" ]]; then             
                    printf "\n[*] Habilitando login automatico" 
                    printf "\n[*] Habilitando login automatico" >> $arquivo_log

                    echo "autologin-user=$autor" >> $var_autologin
                    echo "autologin-user-timeout=0" >> $var_autologin

                    printf "\n[*] Reconfigurando lightdm, aguarde!" 
                    dpkg-reconfigure lightdm 

                    if [[ $? = "0" ]]; then
                    	printf "\n[*] Configuracao atualizada com sucesso" 
                        printf "\n[*] Configuracao atualizada com sucesso" >> $arquivo_log
                    else
                    	printf "\n[-] Erro na Configuracao - Autologin"
                        printf "\n[-] Erro na Configuracao - Autologin" >> $arquivo_log
                    fi

                elif [[ $distro = "Ubuntu" ]]; then 
                    printf "\n[*] Iniciando sessão automaticamente"
                    printf "\n[*] Iniciando sessão automaticamente" >> $arquivo_log

                    cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
                else
                    printf "\n[-] Erro autologin"
                    printf "\n[-] Erro autologin" >> $arquivo_log
                fi  
            else
                printf "\n[-] Login ja esta habilitado"
                printf "\n[-] Login ja esta habilitado" >> $arquivo_log
            fi
        else
            printf "\n[-] O login automatico esta desabilitado! Verificar script."
            printf "\n[-] O login automatico esta desabilitado! Verificar script. " >> $arquivo_log
        fi      
    }    

    icones_temas()
    {       
    	# personalizacao icones
	    local var_icones_macos="/usr/share/themes/MacBuntu-OS"
	    local var_breeze="/usr/share/icons/Breeze"
	    local var_flatremix="/usr/share/icons/Flat_Remix_Light"
	    local var_papirus="/usr/share/icons/Papirus_Light"

        if [ -z $var_breeze ]; then             
            printf "\n[-] Voce ja possui os arquivos Breeze!"
            printf "\n[-] Voce ja possui os arquivos Breeze!" >> $arquivo_log
        else            
            printf "\n[*] Copiando icones Breeze"
            printf "\n[*] Copiando icones Breeze" >> $arquivo_log

            cp -r ../Config/Interface/icons/Breeze /usr/share/icons
        fi

        if [ -z $var_flatremix ]; then 
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!"
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!" >> $arquivo_log
        else            
            printf "\n[*] Copiando icones Flat_Remix_Light"
            printf "\n[*] Copiando icones Flat_Remix_Light" >> $arquivo_log

            cp -r ../Config/Interface/icons/Flat_Remix_Light /usr/share/icons
        fi

        if [ -z $var_papirus ]; then 
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!"
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!" >> $arquivo_log
        else            
            printf "\n[*] Copiando icones Papirus_Light"
            printf "\n[*] Copiando icones Papirus_Light" >> $arquivo_log

            cp -r ../Config/Interface/icons/Papirus_Light /usr/share/icons
        fi

        if [ -z $var_icones_macos ]; then 
            printf "\n[-] Voce ja possui os arquivos MacOS X!"
            printf "\n[-] Voce ja possui os arquivos MacOS X!" >> $arquivo_log
        else    
            printf "\n[*] Copiando icones MacOS X"
            printf "\n[*] Copiando icones MacOS X" >> $arquivo_log

            cp -r ../Config/Interface/themes/* /usr/share/themes
        fi
    }    

    ## LAST_CONFIG
    
    config_idioma()
    {   
        if [[ $distro = "Debian" ]]; then    
            [[ $(grep $language /etc/default/locale) = "" ]] \
                && printf "\n\n[*] Realizando configuraçao de idioma" && cat base/language > $arq_language && locale-gen \
                || printf "\n\n[-] Configuracao do idioma ja realizada anteriormente!"
        fi
    }

# # # # # # # # # #
# # limpa SISTEMA
    arquivos_temporarios()
    {
        printf "\n[*] Removendo arquivos temporários do sistema" 
        printf "\n[*] Removendo arquivos temporários do sistema" >> $arquivo_log

    	find ~/.thumbnails -which f -atime +2 -exec rm -Rf {} \+
    }

    pacotes_orfaos()
    {
        printf "\n[*] Removendo Pacotes Órfãos"
        printf "\n[*] Removendo Pacotes Órfãos" >> $arquivo_log

        apt-get remove $(deborphan) -y 
    }

    funcao_chkrootkit()
    {
        printf "\n[*] Verificando Chkrootkit"
        printf "\n[*] Verificando Chkrootkit" >> $arquivo_log

        chkrootkit
    }

    func_localepurge()
    {
        printf "\n[*] Removendo idiomas extras" 
        printf "\n[*] Removendo idiomas extras" >> $arquivo_log

        localepurge
    }

    ## LAST_LIMPA

# # # # # # # # # #
# # INSTALA PROGRAMAS
    install_firefox()
    {   
        printf "\n[*] Instalando Firefox"
        printf "\n[*] Instalando Firefox" >> $arquivo_log

        local var_firefox=$(type firefox > /dev/null)
        
		if [[ $distro = "Ubuntu" ]]; then
        	apt install firefox -y
        elif [[ $distro = "Debian" ]]; then
            if [[ $var_firefox = "1" ]]; then        
                snap install firefox
            else
                snap refresh firefox
            fi
        fi            
    }

    install_chromium()
    {              
        local var_chromium=$(type chromium > /dev/null)        
        local var_chromium1=$(type chromium-browser > /dev/null)

        if [[ $distro = "Debian" ]]; then 
            if [[ $var_chromium = "1" ]]; then
                printf "\n[*] Instalando o Chromium"
                printf "\n[*] Instalando o Chromium" >> $arquivo_log

                # navegador + pacotes de idiomas
                apt install chromium chromium-l10n -y
            else
                printf "\n[*] Chromium ja esta instalado"
                printf "\n[*] Chromium ja esta instalado" >> $arquivo_log                
            fi  
        elif [[ $distro = "Ubuntu" ]]; then 
            if [[ $var_chromium1 = "1" ]]; then
                printf "\n[*] Instalando o Chromium"
                printf "\n[*] Instalando o Chromium" >> $arquivo_log

                snap install chromium
            else
                snap refresh chromium
            fi  
        else
            printf "\n[-] Erro instalação Chromium"
            printf "\n[-] Erro instalação Chromium" >> $arquivo_log
        fi 
    }

    install_tor()
    {
        local var_tor=$(type tor > /dev/null)

        if [[ $var_tor = "1" ]]; then
            printf "\n[*] Instalando o Tor"
            printf "\n[*] Instalando o Tor" >> $arquivo_log

            # verificando distribuição
            if [ $distro = "Ubuntu" ]; then
                # ubuntu 16.04
                #adicionando repositorio
                add-apt-repository ppa:webupd8team/tor-browser -y

                #Atualizando lista de pacotes
                update

                #Instalando tor
                apt-get install tor tor-browser -y

            elif [ $distro = "Debian" ]; then
                # manualmente - funciona de boas -
                # baixar do site, pasta /opt! 
                ## elaborando script - daqui a pouco ele aparece aqui! hehehe
                echo
            else
                printf "\n[-] ERRO TOR"
                printf "\n[-] ERRO TOR" >> $arquivo_log
            fi

        else
            printf "\n[-] Tor já está instalado! \n" 
            printf "\n[-] Tor já está instalado! \n" >> $arquivo_log
        fi           
    }

    install_steam()
    {
    	local var_steam=$(type steam > /dev/null)

        if [[ $var_steam = "1" ]]; then
	        printf "\n[*] Instalando Steam"
	        printf "\n[*] Instalando Steam" >> $arquivo_log

			# Instalando dependencias steam - DEBIAN 9
			if [[ $distro = "Debian" ]]; then 
				# adicionando arquitetura/dependencia      	
				dpkg --add-architecture i386		

				# Atualizando sistema			
				update

				# Instalando nvidia - dependencias debian
				apt install libgl1-mesa-dev libxtst6:i386 libxrandr2:i386 \
							libglib2.0-0:i386 libgtk2.0-0:i386 libpulse0:i386 \
							libgdk-pixbuf2.0-0:i386 steam-launcher -y		                        
			fi		

	        apt install steam -y
	    else
			printf "\n[-] Steam já está instalado!" 
            printf "\n[-] Steam já está instalado!" >> $arquivo_log
	    fi
    }

    install_spotify()
    {
        # variavel de verificação
        local var_spotify=$(type spotify > /dev/null)

        if [[ $var_spotify = "1" ]]; then
            printf "\n[*] Instalando Spotify"
            printf "\n[*] Instalando Spotify" >> $arquivo_log

            snap install spotify
        else            
            printf "\n[-] Atualizando Spofity! \n"
            printf "\n[-] Atualizando Spofity! \n" >> $arquivo_log

            snap refresh spotify
        fi
    }   

    install_codecs()
    {
        printf "\n[*] Instalando Pacotes Multimidias (Codecs)"
        printf "\n[*] Instalando Pacotes Multimidias (Codecs)" >> $arquivo_log

        if [[ $distro = "Ubuntu" ]]; then
            #Instalando pacotes multimidias
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
                    oracle-java7-installer lame libavcodec-extra libav-tools -y --force-yes    
    }

    install_funcao_gimp()
    {
     	# variavel de verificação
        local var_gimp=$(type gimp > /dev/null)

        if [[ $var_gimp = "1" ]]; then
            printf "\n[*] Instalando o Gimp"
            printf "\n[*] Instalando o Gimp" >> $arquivo_log

            apt install gimp -y
        else
            printf "\n[-] Gimp já está instalado na sua máquina!"
            printf "\n[-] Gimp já está instalado na sua máquina!" >> $arquivo_log
        fi
    }

    install_xfce4()
    {
        # variaveis
        local var_xfpanel=$(type xfpanel-switch > /dev/null)        
        local var_whiskermenu=$(type xfce4-popup-whiskermenu > /dev/null)


        printf "\n[*] Instalando adicionais do XFCE" 
        printf "\n[*] Instalando adicionais do XFCE" >> $arquivo_log

        #Instalando componentes do XFCE
        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin \
                    xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-fsguard-plugin \
                    xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin \
                    xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin \
                    xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin \
                    xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin \
                    xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin \
                    xfce4-xkb-plugin xfce4-mount-plugin smartmontools -fyq

        # adicionais para serem utilizados
        apt install hddtemp         

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp        

        if [[ -z $var_xfpanel ]]; then
            printf "\n[*] Instalando Xfpanel-switch"
            printf "\n[*] Instalando Xfpanel-switch" >> $arquivo_log

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb
        else
            printf "\n[-] Xfpanel-switch ja esta instalado"
            printf "\n[-] Xfpanel-switch ja esta instalado" >> $arquivo_log
        fi      

        if [[ -z $var_whiskermenu ]]; then
            printf "\n[*] Instalando Whisker-menu"
            printf "\n[*] Instalando Whisker-menu" >> $arquivo_log

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb
        else
            printf "\n[-] Whisker-menu ja esta instalado"
            printf "\n[-] Whisker-menu ja esta instalado" >> $arquivo_log
        fi
    }

    install_wine()
    {
    	# variavel de verificação
        local var_wine=$(type wine > /dev/null)

        if [[ $var_wine = "1" ]]; then
        	printf "\n[*] Instalando o Wine"
            printf "\n[*] Instalando o Wine" >> $arquivo_log

            if [[ $distro = "Ubuntu" ]]; then
                # adicionado o repositorio
                add-apt-repository ppa:ubuntu-wine/ppa -y

                # chamando funcao já criada
                update                

                # instalando wine
                apt install wine -y
            elif [[ $distro = "Debian" ]]; then
            	# adicionando sistema multi-arch
            	dpkg --add-architecture i386
		
					# baixando chave
					wget -nc https://dl.winehq.org/wine-builds/Release.key

					# instalando chave
					apt-key add Release.key

					# removendo chave
					rm Release.key

				# atualizando sistema
				update

				# instalando wine
				apt install --install-recommends winehq-stable -y
            else
            	printf "\n[-] Erro ao instalar Wine"
            	printf "\n[-] Erro ao instalar Wine" >> $arquivo_log
            fi            
        else
            printf "\n[-] Wine já está instalado na sua máquina!"
            printf "\n[-] Wine já está instalado na sua máquina!" >> $arquivo_log
        fi
    }

    install_playonlinux()
    {
        local var_playonlinux=$(type playonlinux > /dev/null)

        if [[ $var_playonlinux = "1" ]]; then
            printf "\n[*] Instalando o PlayonLinux"
            printf "\n[*] Instalando o PlayonLinux" >> $arquivo_log

            apt install playonlinux -y
        else
            printf "\n[*] PlayonLinux ja esta instalado"
            printf "\n[*] PlayonLinux ja esta instalado" >> $arquivo_log
        fi        
    }

    install_redshift()
    {
        printf "\n[*] Instalando o Redshift"
        printf "\n[*] Instalando o Redshift" >> $arquivo_log

        apt install redshift gtk-redshift -y        
    }

    install_libreoffice()
    {
        printf "\n[*] Instalando o Libreoffice"
        printf "\n[*] Instalando o Libreoffice" >> $arquivo_log

        if [[ $distro = "Ubuntu" ]]; then
            #adicionando ppa
            add-apt-repository ppa:libreoffice/ppa -y

            #chamando funcao já definida
            update
        fi

        #Instalando libreoffice
        apt-get install libreoffice libreoffice-style-breeze -y
    }

    install_vlc()
    {
        printf "\n[*] Instalando o VLC"
        printf "\n[*] Instalando o VLC" >> $arquivo_log

        apt install vlc -y
    }

    install_clementine()
    {
        printf "\n[*] Instalando o Clementine"
        printf "\n[*] Instalando o Clementine" >> $arquivo_log

        apt install clementine -y
    }

    install_gparted()
    {
        printf "\n[*] Instalando o Gparted"
        printf "\n[*] Instalando o Gparted" >> $arquivo_log

        apt install gparted -y
    }

    install_tlp()
    {
        printf "\n[*] Instalando o Tlp"
        printf "\n[*] Instalando o Tlp" >> $arquivo_log

        apt install tlp -y
    }

    install_git()
    {
        printf "\n[*] Instalando o Git"
        printf "\n[*] Instalando o Git" >> $arquivo_log

        apt install git-core git -y
    }

    install_lm-sensors()
    {
        printf "\n[*] Instalando o Lm-sensors"
        printf "\n[*] Instalando o Lm-sensors" >> $arquivo_log

        apt install lm-sensors -y
    }

    install_stellarium()
    {
        # variavel de verificação
        local var_stellarium=$(type stellarium > /dev/null)

        if [[ $var_stellarium = "1" ]]; then
            # verificando distribuição
            if [ $distro = "Ubuntu" ]; then
                printf "\n[*] Instalando o Stellarium"
                printf "\n[*] Instalando o Stellarium" >> $arquivo_log

                #adicinando ppa
                add-apt-repository ppa:stellarium/stellarium-releases -y

                #Atualizando sistema
                update
            fi

            #Instalando o stellarium
            apt install stellarium* -y
        else
            printf "\n[-] Stellarium já está instalado!"
            printf "\n[-] Stellarium já está instalado!" >> $arquivo_log
        fi
    }

    install_reaver()
    {
        printf "\n[*] Instalando o Reaver"
        printf "\n[*] Instalando o Reaver" >> $arquivo_log

        apt install reaver -y
    }  

    install_dolphin()
    {
        printf "\n[*] Instalando o Dolphin"
        printf "\n[*] Instalando o Dolphin" >> $arquivo_log

        if [[ $distro = "Ubuntu" ]]; then
            #adicionando repositorio do dolphin
            add-apt-repository ppa:glennric/dolphin-emu -y

            #Atualizando lista de repositorios
            update

            #corrigindo problemas de dependencias
            apt-get install -f
        fi

        #Instalando dolphin
        apt install dolphin-emu -y
    }

    install_visualgameboy()
    {
        printf "\n[*] Instalando o Visual Game Boy"
        printf "\n[*] Instalando o Visual Game Boy" >> $arquivo_log 

        if [[ $distro = "Ubuntu" ]]; then
        	apt install visualboyadvance-gtk -y
        elif [[ $distro = "Debian" ]]; then
        	apt install visualboyadvance -y
        else
        	printf "[-] ERRO - VisualGame"
        	printf "[-] ERRO - VisualGame" >> $arquivo_log
        fi
    }

    install_neofetch()
    {
        printf "\n[*] Instalando o Neofetch"
        printf "\n[*] Instalando o Neofetch" >> $arquivo_log

        apt install neofetch -y
    }

    install_sweethome3d()
    {
        printf "\n[*] Instalando Sweet Home 3D"
        printf "\n[*] Instalando Sweet Home 3D" >> $arquivo_log

        apt install sweethome3d -y
    }

    install_cheese()
    {
        printf "\n[*] Instalando o Cheese"
        printf "\n[*] Instalando o Cheese" >> $arquivo_log

        apt install cheese -y
    }

    install_plank()
    {
        # variavel de verificação
        local var_plank=$(type plank > /dev/null)

        if [[ $var_plank = "1" ]]; then
            printf "\n[*] Instalando o Plank Dock"
            printf "\n[*] Instalando o Plank Dock" >> $arquivo_log

            # verificando distribuição
            if [ $distro = "Ubuntu" ]; then
                #adicionando ppa
                add-apt-repository ppa:noobslab/apps -y

                #Atualizando lista repositorios
                update

                #Instalando plank
            	apt-get install plank* plank-themer -y
            fi

            #Instalando plank
            apt-get install plank* -y
        else
            printf "\n[-] Plank já está instalado!"
            printf "\n[-] Plank já está instalado!" >> $arquivo_log
        fi
    }

    install_gnome_system_monitor()
    {
        printf "\n[*] Instalando o Gnome System Monitor"
        printf "\n[*] Instalando o Gnome System Monitor" >> $arquivo_log

        apt install gnome-system-monitor -y
    }

    install_nautilus()
    {
        # variavel de verificação
        local var_nautilus=$(type nautilus > /dev/null)

        if [[ $var_nautilus = "1" ]]; then
            printf "\n[*] Instalando o Nautilus"
            printf "\n[*] Instalando o Nautilus" >> $arquivo_log

            # verificando distribuição
            if [ $distro = "Ubuntu" ]; then
                #adicionando ppa
                add-apt-repository ppa:gnome3-team/gnome3 -y

                #Atualizando lista repositorio
                update                
            fi

            #Instalando o nautilus
            apt install nautilus* -y

        else
            printf "\n[-] Nautilus já está instalado!"
            printf "\n[-] Nautilus já está instalado!" >> $arquivo_log
        fi
    }

    install_wireshark()
    {
        printf "\n[*] Instalando o Wireshark"
        printf "\n[*] Instalando o Wireshark" >> $arquivo_log

        apt install wireshark wireshark-gtk -y
    }

    install_gnome_disk_utility()
    {
        printf "\n[*] Instalando o Gnome Disk Utility"
        printf "\n[*] Instalando o Gnome Disk Utility" >> $arquivo_log

        apt install gnome-disk-utility -y
    }

    install_audacity()
    {
        printf "\n[*] Instalando o Audacity"
        printf "\n[*] Instalando o Audacity" >> $arquivo_log

        apt install audacity -y
    }

    install_simple_screen_recorder()
    {
        # variavel de verificação
        local var_simplescreenrecorder=$(type simplescreenrecorder > /dev/null)

        if [[ $var_simplescreenrecorder = "1" ]]; then
            printf "\n[*] Instalando o Simple Screen Recorder"
            printf "\n[*] Instalando o Simple Screen Recorder" >> $arquivo_log

            if [[ $distro = "Ubuntu" ]]; then
                #adicionando fonte
                add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

                #Atualizando lista de repositorios
                apt-get update
            fi

            #Instalando simplescreenrecorder
            apt-get install simplescreenrecorder -y
        else
            printf "\n[-] Simple Screen Recorder já está instalado!"
            printf "\n[-] Simple Screen Recorder já está instalado!" >> $arquivo_log
        fi
    }

    install_mega()
    {       
        # variavel de verificação
        local var_mega=$(type megasync > /dev/null)

        if [[ $var_mega = "1" ]]; then        
            printf "\n[*] Instalando o MEGA"
            printf "\n[*] Instalando o MEGA" >> $arquivo_log
            
            if [[ $distro = "Ubuntu" ]]; then
	            # Instalando mega
	            dpkg -i base/packages/mega/*.deb

	            # corrigindo dependencias
	            apt install -fy

	            # Instalando mega
	            dpkg -i base/packages/mega/*.deb
	        elif [[ $distro = "Debian" ]]; then
				# Instalando megasync
				apt install megasync -y
	        fi
        else
            printf "\n[-] MEGA Sync já está instalado!"
            printf "\n[-] MEGA Sync já está instalado!" >> $arquivo_log
        fi
    }

    install_openssh()
    {
        printf "\n[*] Instalando o OpenSSH"
        printf "\n[*] Instalando o OpenSSH" >> $arquivo_log

        apt install openssh-client openssh-server -y
    }

    install_figlet()
    {
        printf "\n[*] Instalando o Figlet"
        printf "\n[*] Instalando o Figlet" >> $arquivo_log

        apt install figlet -y
    }

    install_chkrootkit()
    {
        printf "\n[*] Instalando o Chkrootkit"
        printf "\n[*] Instalando o Chkrootkit" >> $arquivo_log

        apt install chkrootkit -y
    }

    install_localepurge()
    {
        printf "\n[*] Instalando o Localepurge"
        printf "\n[*] Instalando o Localepurge" >> $arquivo_log

        apt-get install localepurge -y
    }

    install_hardinfo()
    {
        printf "\n[*] Instalando o Hardinfo"
        printf "\n[*] Instalando o Hardinfo" >> $arquivo_log

        apt install hardinfo -y
    }

    install_nvidia()
    {
        # variavel de verificação
        local var_nvidia=$(type nvidia-settings > /dev/null)

        if [[ $var_nvidia = "1" ]]; then
            if [ $distro = "Ubuntu" ]; then
    		    printf "\n[*] Instalando o driver da Placa Nvidia"
    		    printf "\n[*] Instalando o driver da Placa Nvidia" >> $arquivo_log

    		    apt-add-repository ppa:graphics-drivers/ppa -y
    		    apt-add-repository ppa:ubuntu-x-swat/x-updates -y
    		    apt-add-repository ppa:xorg-edgers/ppa -y

    		    update

    		    apt install nvidia-current nvidia-settings -y  
            elif [[ $distro = "Debian" ]]; then
                # Instalando driver
        	    apt install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-driver
            else
                printf "\n[-] ERRO - NVIDIA"
                printf "\n[-] ERRO - NVIDIA" >> $arquivo_log
            fi
        else
            printf "\n[-] Nvidia já está instalado no sistema!"
            printf "\n[-] Nvidia já está instalado no sistema!" >> $arquivo_log
        fi
    }

    install_virtualbox()
    {
        # variavel de verificação
        local var_virtualbox=$(type virtualbox > /dev/null)

        # criando verificação para instalar o virtualbox
        if [[ $var_virtualbox = "1" ]]; then    
        	printf "\n[*] Instalando Virtualbox \n"
            printf "\n[*] Instalando Virtualbox \n" >> $arquivo_log

            if [ $distro = "Ubuntu" ]; then
                #instalando virtualbox
                apt install virtualbox-5.1 -y

            elif [ $distro = "Debian" ]; then     
                # adicionando repositorio
                sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" >> /etc/apt/sources.list.d/virtualbox.list' 

                # baixando chave
                wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -

                # atualizando sistema
                update
                
                # instalando dependencias necessarias
                apt install dkms build-essential linux-headers-$(uname -r)

                # instalando virtualbox
                apt install virtualbox-5.2 -y    

                # adicionando usuario
                gpasswd -a $autor vboxusers          
            fi            
        else
            printf "[-] VirtualBox já está instalado! \n"
            printf "[-] VirtualBox já está instalado! \n" >> $arquivo_log
        fi
    }

    install_ristretto()
    {
        printf "\n[*] Instalando o Ristretto"
        printf "\n[*] Instalando o Ristretto" >> $arquivo_log

        apt install ristretto -y
    }

    install_tree()
    {
        printf "\n[*] Instalando o Tree"
        printf "\n[*] Instalando o Tree" >> $arquivo_log

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        local var_pulseeeffects=$(type pulseeffects > /dev/null)
		local var_flatpak=$(type flatpak > /dev/null)

        # criando verificação para instalar o pulseeffects
        if [[ $var_flatpak = "1" ]]; then
	        if [[ $var_pulseeeffects = "1" ]]; then
	            printf "\n[*] Instalando o Pulse Effects"
	            printf "\n[*] Instalando o Pulse Effects" >> $arquivo_log

	            # adicionando via flatpak
	            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	            # Instalando via flatpak
	            flatpak install flathub com.github.wwmm.pulseeffects -y                

                if [ $distro = "Debian" ]; then                  
                    local pulse_audio="/etc/pulse/daemon.conf"
                    local flat_volume="flat-volumes = no"
                    local verifica_pulse=$(grep $flat_volume $pulse_audio)        

                    # executando caso nao encontre $flat_volume
                    [[ $verifica_pulse = "" ]] && echo $flat_volume >> $pulse_audio && \
                                                  printf "\n[+] Arquivo $pulse_audio modificado!" && printf "\n[+] Arquivo $pulse_audio modificado!" >> $arquivo_log || \
                                                  printf "\n[-] Arquivo $pulse_audio nao foi modificado!" && printf "\n[-] Arquivo $pulse_audio nao foi modificado!" >> $arquivo_log

                    ######## COMENTARIO                        
                    ## Se houve erro no servidor do pulseaudio, basta reinstalo com o comando:
                    # apt install --reinstall pulseaudio
                fi
	        else                
	            printf "\n[*] Atualizando pulseeffects"
	            printf "\n[*] Atualizando pulseeffects" >> $arquivo_log

                flatpak update com.github.wwmm.pulseeffects -y                
	        fi            
	    else
			printf "\n[-] O Pulse Effects, precisa do flatpak para ser instalado!"
            printf "\n[-] O Pulse Effects, precisa do flatpak para ser instalado!" >> $arquivo_log
	    fi
    }
    
    install_terminator()
    {
        printf "\n[*] Instalando o Terminator"
        printf "\n[*] Instalando o Terminator" >> $arquivo_log
        
        apt install terminator -y
    }

    install_aircrack()
    {
        printf "\n[*] Instalando o Aircrack-ng"
        printf "\n[*] Instalando o Aircrack-ng" >> $arquivo_log

        apt install aircrack-ng -y
    }

    install_snap()
    {
        printf "\n[*] Instalando o Snap"
        printf "\n[*] Instalando o Snap" >> $arquivo_log

        apt install snapd -y      
    }

    install_ntp()
    {
        printf "\n[*] Instalando o NTP"
        printf "\n[*] Instalando o NTP" >> $arquivo_log

        apt install ntp ntpdate -y
    }

    install_xclip()
    {
        printf "\n[*] Instalando o Xclip"
        printf "\n[*] Instalando o Xclip" >> $arquivo_log

        apt install xclip -y
    }

    install_espeak()
    {
        printf "\n[*] Instalando o Speak"
        printf "\n[*] Instalando o Speak" >> $arquivo_log

        apt install espeak -y	
    }

    install_ibus()
    {
        printf "\n[*] Instalando o Ibus"
        printf "\n[*] Instalando o Ibus" >> $arquivo_log

        apt install ibus -y
    }

    install_nmap()
    {
        printf "\n[*] Instalando o Nmap"
        printf "\n[*] Instalando o Nmap" >> $arquivo_log

        apt install nmap -y
    }

    install_htop()
    {
    	printf "\n[*] Instalando o Htop"
        printf "\n[*] Instalando o Htop" >> $arquivo_log

        apt install htop -y
    }

    install_gnome_calculator()
    {
        printf "\n[*] Instalando o Gnome Calculator"
        printf "\n[*] Instalando o Gnome Calculator" >> $arquivo_log

        apt install gnome-calculator -y
    }

    install_tuxguitar()
    {
        # variavel de verificação
        local var_tuxguitar=$(type tuxguitar > /dev/null)

        # criando verificação para instalar o tuxguitar
        if [[ $var_tuxguitar = "1" ]]; then
            printf "\n[*] Instalando Tux Guitar"
            printf "\n[*] Instalando Tux Guitar" >> $arquivo_log                

            if [ $distro = "Ubuntu" ]; then
              snap install tuxguitar-vs
            elif [ $distro = "Debian" ]; then
                apt install tuxguitar timidity -y
            fi
        else
            printf "\n[-] TuxGuitar já está instalado"
            printf "\n[-] TuxGuitar já está instalado" >> $arquivo_log
        fi
    }

    install_zsh()
    {
        # variavel de verificação
        local var_zsh=$(type zsh > /dev/null)        

		# criando verificação para instalar zsh
        if [[ $var_zsh = "1" ]]; then
            printf "\n[*] Instalando o ZSH"
            printf "\n[*] Instalando o ZSH" >> $arquivo_log

	        apt install zsh zsh-common -y
	    else
	    	printf "\n[-] O ZSH ja esta instalado no seu sistema"
	    	printf "\n[-] O ZSH ja esta instalado no seu sistema" >> $arquivo_log
	    fi
    }

    install_docker()
    {
        # variavel de verificação
        local var_docker=$(type docker > /dev/null)

        # criando verificação para instalar o docker
        if [[ $var_docker = "1" ]]; then
        	printf "\n[*] Instalando o Docker"
            printf "\n[*] Instalando o Docker" >> $arquivo_log
    
            curl -fsSL https://get.docker.com/ | sh                
        else
            printf "\n[-] O Docker já está instalado no seu sistema."
            printf "\n[-] O Docker já está instalado no seu sistema." >> $arquivo_log
        fi
    }

    install_sublime()
    {
         # variavel de verificação
        local var_sublime=$(type subl > /dev/null)

        # criando verificação para instalar o sublime
        if [[ $var_sublime = "1" ]]; then
            printf "\n[*] Instalando o Sublime"
            printf "\n[*] Instalando o Sublime" >> $arquivo_log

            # snap
            snap install sublime-text

        else
            snap refresh sublime-text
        fi
    }

    install_firmware()
    {
        printf "\n[*] Instalando os firmware's non-free"        
        printf "\n[*] Instalando os firmware's non-free" >> $arquivo_log                        

        if [ $distro = "Debian" ]; then
            if [[ $v_hostname = 'notebook' ]]; then   
                apt install xserver-xorg-input-synaptics \
                    blueman  firmware-brcm80211 -y      
            fi

            apt install firmware-linux \
                        firmware-linux-nonfree -y
        else
            printf "\n[-] ERRO - firmware"
            printf "\n[-] ERRO - firmware" >> $arquivo_log
        fi        
    }     

    install_compton()
    {
        printf "\n[*] Instalando o Compton"        
        printf "\n[*] Instalando o Compton" >> $arquivo_log        

    	apt install compton compton-conf -y
    }

    install_python()
    {        
        printf "\n[*] Instalando o Pip" 
        printf "\n[*] Instalando o Pip" >> $arquivo_log        

        apt install python3.5 python-pip -y

    	if [ $distro = "Debian" ]; then
 			apt install pipsi -y # Instalando pip no debian
        fi   
    }

    install_youtubedl()
    {
        printf "\n[*] Instalando o Youtube-DL" 
        printf "\n[*] Instalando o Youtube-DL" >> $arquivo_log 

        apt install youtube-dl -y
    }

    install_yad()
    {
        printf "\n[*] Instalando o YAD" 
        printf "\n[*] Instalando o YAD" >> $arquivo_log 

        apt install yad -y    	
    }

    install_dropbox()
    {
        printf "\n[*] Instalando Dropbox"
        printf "\n[*] Instalando Dropbox" >> $arquivo_log

        apt install nautilus-dropbox -y        
    }

    install_transmission()
    {
        local var_transmission=$(type transmission-gtk > /dev/null)

        # verificando se transmission está instalado
        if [[ $var_transmission = "1" ]]; then
            printf "\n[*] Instalando o Transmission"
            printf "\n[*] Instalando o Transmission" >> $arquivo_log    

            apt install transmission-gtk -y
        fi
    }

    install_xfburn()
    {
        printf "\n[*] Instalando XFBurn"
        printf "\n[*] Instalando XFBurn" >> $arquivo_log

        apt install xfburn -y
    }

    install_wavemon()
    {
        printf "\n[*] Instalando o Wavemon"        
        printf "\n[*] Instalando o Wavemon" >> $arquivo_log        

        apt install wavemon -y
    }

    install_mugshot()
    {
        printf "\n[*] Instalando o Mugshot"        
        printf "\n[*] Instalando o Mugshot" >> $arquivo_log        

        apt install mugshot -y
    }

    install_simplescan()
    {
        printf "\n[*] Instalando o Simple-scan"        
        printf "\n[*] Instalando o Simple-scan" >> $arquivo_log        

        apt install simple-scan -y
    }

    install_wireshark()
    {
        printf "\n[*] Instalando o Wireshark"
        printf "\n[*] Instalando o Wireshark" >> $arquivo_log

        apt install wireshark -y
    }

    install_prelink()
    {
        printf "\n[*] Instalando Prelink"
        printf "\n[*] Instalando Prelink" >> $arquivo_log

        apt install prelink -y         
    }   

    install_preload()
    {
        printf "\n[*] Instalando Preload"
        printf "\n[*] Instalando Preload" >> $arquivo_log

        apt install preload -y         
    }   

    install_deborphan()
    {
        printf "\n[*] Instalando Deborphan"
        printf "\n[*] Instalando Deborphan" >> $arquivo_log

        apt-get install deborphan -y
    }

    install_locate()
    {
    	# variavel de verificação
        local var_locate=$(type locate > /dev/null)

        if [[ $var_locate = "1" ]]; then
            printf "\n[*] Instalando Locate"
            printf "\n[*] Instalando Locate" >> $arquivo_log

        	apt install locate -y
        else
            printf "\n[-] Locate ja esta instalado!"
            printf "\n[-] Locate ja esta instalado!" >> $arquivo_log            
        fi
    }

    install_arpscan()
    {
    	printf "\n[*] Instalando ARP Scan"
        printf "\n[*] Instalando ARP Scan" >> $arquivo_log

        apt install arp-scan -y
    }

    install_ufw()
    {
        printf "\n[*] Instalando o UFW"
        printf "\n[*] Instalando o UFW" >> $arquivo_log

        apt install ufw gufw -y

        ## iniciando o ufw automaticamente no sistema
        ufw enable && systemctl enable ufw && systemctl start ufw
    }

    install_mypaint()
    {
        printf "\n[*] Instalando o MyPaint"
        printf "\n[*] Instalando o MyPaint" >> $arquivo_log

        apt install mypaint -y
    }

    install_flatpak()
    {
        printf "\n[*] Instalando o Flatpak"
        printf "\n[*] Instalando o Flatpak" >> $arquivo_log

        apt install flatpak -y
    }

    install_notify()
    {
        printf "\n[*] Instalando o Notify-send"
        printf "\n[*] Instalando o Notify-send" >> $arquivo_log

        apt install notify-osd -y
        apt --reinstall install libnotify-bin notify-osd -y
    }

    install_evince()
    {
        printf "\n[*] Instalando o Evince"
        printf "\n[*] Instalando o Evince" >> $arquivo_log

        apt install evince* -y
    }

    install_rar()
    {
        printf "\n[*] Instalando o Rar"
        printf "\n[*] Instalando o Rar" >> $arquivo_log

        apt install rar unrar -y
    }

    ## LAST_INSTALL

# # # # # # # # # #
# # REMOVE PROGRAMAS
	remove_thunderbird()
	{
		printf "\n[*] Removendo o Thunderbird"
        printf "\n[*] Removendo o Thunderbird" >> $arquivo_log

        apt purge thunderbird -y
	}

	remove_inkspace()
	{
		printf "\n[*] Removendo o Inkscape "
        printf "\n[*] Removendo o Inkscape " >> $arquivo_log
		
		apt purge inkscape -y
	}

	remove_blender()
	{
		printf "\n[*] Removendo o Blender"
        printf "\n[*] Removendo o Blender" >> $arquivo_log
		
		apt purge blender -y
	}

	remove_parole()
	{
		printf "\n[*] Removendo o Parole"
        printf "\n[*] Removendo o Parole" >> $arquivo_log
		
		apt purge parole -y
	}

	remove_exfalso()
	{
		printf "\n[*] Removendo o Exfalso"
        printf "\n[*] Removendo o Exfalso" >> $arquivo_log
		
		apt purge exfalso -y
	}

	remove_quolibet()
	{
		printf "\n[*] Removendo o Quolibet"
        printf "\n[*] Removendo o Quolibet" >> $arquivo_log
		
		apt purge qoulibet -y
	}

	remove_xterm()
	{
		printf "\n[*] Removendo o Xterm"
        printf "\n[*] Removendo o Xterm" >> $arquivo_log
		
		apt purge xterm -y
	}

	remove_xsane()
	{
		printf "\n[*] Removendo o XSane"
        printf "\n[*] Removendo o XSane" >> $arquivo_log
		
		apt purge xsane -y
	}

	remove_pidgin()
	{
		printf "\n[*] Removendo o Pidgin"
        printf "\n[*] Removendo o Pidgin" >> $arquivo_log

		apt purge pidgin -y
	}

	remove_meld()
	{
		printf "\n[*] Removendo o Meld"
        printf "\n[*] Removendo o Meld" >> $arquivo_log
		
		apt purge meld -y
	}

	remove_gtkhash()
	{
		printf "\n[*] Removendo o Gtkhash"
        printf "\n[*] Removendo o Gtkhash" >> $arquivo_log
	
		apt purge gtkhash -y	
	}

	remove_imagemagick()
	{
		printf "\n[*] Removendo o Imagemagick"
        printf "\n[*] Removendo o Imagemagick" >> $arquivo_log
		
		apt purge imagemagick* -y
	}

	remove_chromium-bsu()
	{
		printf "\n[*] Removendo o Chromium-BSU"
        printf "\n[*] Removendo o Chromium-BSU" >> $arquivo_log
		
		apt purge chromium-bsu -y
	}

	remove_owncloud()
	{
		printf "\n[*] Removendo o Owncloud"
        printf "\n[*] Removendo o Owncloud" >> $arquivo_log
		
		apt purge owncloud* -y
	}

	remove_kstars()
	{
		printf "\n[*] Removendo o Pidgin"
        printf "\n[*] Removendo o Pidgin" >> $arquivo_log
		
		apt purge kstars -y
	}

	remove_steam()
	{
		printf "\n[*] Removendo o Steam"
        printf "\n[*] Removendo o Steam" >> $arquivo_log
		
		apt purge steam -y
	}

	remove_kdenlive()
	{
		printf "\n[*] Removendo o Kdenlive"
        printf "\n[*] Removendo o Kdenlive" >> $arquivo_log
		
		apt purge kdenlive -y
	}

	remove_transmission()
	{
		printf "\n[*] Removendo o Transmission"
        printf "\n[*] Removendo o Transmission" >> $arquivo_log
		
		apt purge transmission -y
	}

	remove_smartgit()
	{
		printf "\n[*] Removendo o Smartgit"
        printf "\n[*] Removendo o Smartgit" >> $arquivo_log
		
		apt purge smartgit -y
	}

	remove_gitg()
	{
		printf "\n[*] Removendo o Gitg"
        printf "\n[*] Removendo o Gitg" >> $arquivo_log
		
		apt purge gitg -y
	}

    remove_mpv()
    {
        printf "\n[*] Removendo o Mpv"
        printf "\n[*] Removendo o Mpv" >> $arquivo_log

        apt purge mpv -y
    }

    remove_clamav()
    {
        printf "\n[*] Removendo o clamAV"
        printf "\n[*] Removendo o clamAV"

        apt purge clamav* clamtk clamtk-nautilus -y
    }

    ## LAST_REMOVE

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_atualiza()
{
    notify-send -u normal "Atualizando sistema" -t 10000

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

	if [[ $v_hostname = 'notebook' ]]; then               
        if [ $distro = "Ubuntu" ]; then        
            apt_update_local
            apt_auto            
        elif [ $distro = "Debian" ]; then              
            printf ""   
        fi
    elif [[ $v_hostname = 'desktop' ]]; then        
        if [ $distro = "Ubuntu" ]; then           
            apt_update_local
            apt_auto
            apport
        elif [ $distro = "Debian" ]; then      
            printf ""   
        fi
    else
        printf "\n[-] ERRO corrige!"
        printf "\n[-] ERRO corrige!" >> $arquivo_log
    fi

    update
}

func_config()
{
    notify-send -u normal "Configurando o sistema" -t 10000	

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
    notify-send -u normal "Limpando sistema" -t 10000

    clear   

    pacotes_orfaos
    funcao_chkrootkit
    func_localepurge
}

func_instala()
{
    notify-send -u normal "Instalando programas no sistema" -t 10000	

	install_firefox
	install_chromium	
	install_tor

	install_codecs
	install_vlc
	install_clementine
	install_spotify	   
	install_funcao_gimp	
	install_simple_screen_recorder   
	
    install_stellarium
    install_libreoffice 

	install_xfce4
    install_lm-sensors    
    install_nautilus
    install_openssh    
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
    install_mypaint 
    install_flatpak
    install_notify
    install_evince
    install_rar

    install_prelink
    install_preload
    install_deborphan   
    install_locate
    install_arpscan

    install_ufw
    install_firmware     

	if [[ $v_hostname = 'notebook' ]]; then		
        install_cheese
        install_aircrack  
        install_wavemon	
	    install_reaver   

		if [ $distro = "Ubuntu" ]; then					
			echo 	# nenhuma acao, por enquanto
		elif [ $distro = "Debian" ]; then				
	    	echo    # nenhuma acao, por enquanto
		fi
	elif [[ $v_hostname = 'desktop' ]]; then     
        install_tuxguitar  
        install_wine
        install_playonlinux  
        install_sweethome3d

		install_visualgameboy
	    install_dolphin

		install_audacity
        install_nvidia      
                
        install_transmission    
	else
		printf "\n[-] ERRO instala!"
		printf "\n[-] ERRO instala!" >> $arquivo_log
	fi
}

func_instala_outros()
{      
    install_fonts
    install_wireshark 

    # verificando computador
    if [[ $v_hostname = 'desktop' ]]; then
        install_virtualbox
        install_steam        
    fi
}

func_remove()
{
	if [[ $v_hostname = 'notebook' ]]; then    	
		remove_kstars
		remove_steam
		remove_kdenlive
		remove_transmission
		remove_smartgit
		remove_gitg
    fi

	remove_thunderbird
	remove_parole
	remove_inkspace
	remove_inkspace
	remove_blender
	remove_exfalso
	remove_quolibet
	remove_xterm
	remove_pidgin
	remove_meld
	remove_gtkhash
	remove_xsane
	remove_imagemagick
	remove_chromium-bsu
	remove_owncloud   
    remove_mpv   
}

func_formatado()
{
    # Atualizando sistema
    func_atualiza

    # Instalando programas
    func_instala    
    
    # removendo programas pré-instalados, desnecessários
    func_remove

    # Atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # Atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # desligando a maquina apos configuração
    halt -p
}

func_todas()
{
	# Atualizando sistema
    func_atualiza

    # Instalando programas
    func_instala

    # Instalando programas extras - talvez precise da interacao do usuario
    func_instala_outros

    # removendo programas pré-instalados, desnecessários
    func_remove

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # Configurando o sistema
    func_config

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # Atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza
}

func_geral()
{
	# Atualizando sistema
    func_atualiza

    # Instalando programas
    func_instala

    # Instalando programas extras - talvez precise da interacao do usuario
    func_instala_outros

    # removendo programas pré-instalados, desnecessários
    func_remove

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # Configurando o sistema
    func_config

    # Atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza
}

func_vetor_atualiza()
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
}

func_vetor_corrige()
{
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
}

func_vetor_config()
{
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
}

func_vetor_limpa()
{
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
}

func_vetor_instala()
{
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
}

func_vetor_instala_outros()
{
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
}

func_vetor_remove()
{
	# percorrendo vetor instala outros
    for (( i = 0; i <= ${#remove[@]}; i++ )); do 
        # saindo do script
        if [[ ${remove[$i]} = "$escolha_vetor" ]]; then
            # executando funcao encontrada
            ${remove[$i]}

            # saindo do script
            exit 0                
        fi
    done 
}

func_vetor_atualiza_ajuda()
{
	printf "\n--------"
    printf "\nAtualiza"
    printf "\n--------\n"

    for (( i = 0; i <= ${#atualiza[@]}; i++ )); do             
        echo ${atualiza[$i]}
    done 
}


func_vetor_corrige_ajuda()
{
	printf "\n--------"
    printf "\nCorrige"
    printf "\n--------\n"

    for (( i = 0; i <= ${#corrige[@]}; i++ )); do             
        echo ${corrige[$i]}
    done
}

func_vetor_config_ajuda()
{
	printf "\n------"
    printf "\nConfig"
    printf "\n------\n"

    for (( i = 0; i <= ${#config[@]}; i++ )); do             
        echo ${config[$i]}
    done
}

func_vetor_limpa_ajuda()
{
	printf "\n-----"
    printf "\nLimpa"
    printf "\n-----\n"

    for (( i = 0; i <= ${#limpa[@]}; i++ )); do             
        echo ${limpa[$i]}
    done
}

func_vetor_instala_ajuda()
{
	printf "\n-------"
    printf "\nInstala"
    printf "\n-------\n"

    for (( i = 0; i <= ${#instala[@]}; i++ )); do             
        echo ${instala[$i]}
    done
}

func_vetor_instala_outros_ajuda()
{
	printf "\n--------------"
    printf "\nInstala Outros"
    printf "\n--------------\n"

    for (( i = 0; i <= ${#instala_outros[@]}; i++ )); do             
        echo ${instala_outros[$i]}
    done
}

func_vetor_remove_ajuda()
{
	printf "\n-----------------"
    printf "\nRemove programas"
    printf "\n----------------\n"

    for (( i = 0; i <= ${#remove[@]}; i++ )); do             
        echo ${remove[$i]}
    done
}

func_vetor_ajuda()
{
    func_vetor_instala_ajuda 
    func_vetor_corrige_ajuda
    func_vetor_config_ajuda
    func_vetor_limpa_ajuda
    func_vetor_instala_ajuda
    func_vetor_instala_outros_ajuda
    func_vetor_remove_ajuda
}

func_vetor()
{
	func_vetor_atualiza
	func_vetor_corrige
	func_vetor_config
	func_vetor_limpa  
	func_vetor_instala
	func_vetor_instala_outros   
	func_vetor_remove          

    # mostrando ajuda para o usuario - vetores individuais
    if [[ $@ = "ajuda" ]]; then
        if [[ $@ = "atualiza" ]]; then
            func_vetor_atualiza_ajuda

			sleep $aguarda
            exit 0                    
        elif [[ $@ = "corrige" ]]; then
            func_vetor_corrige_ajuda

            sleep $aguarda
            exit 0
        elif [[ $@ = "config" ]]; then
            func_vetor_config_ajuda

			sleep $aguarda
            exit 0
        elif [[ $@ = "limpa" ]]; then
            func_vetor_limpa_ajuda            

            sleep $aguarda
            exit 0
        elif [[ $@ = "instala" ]]; then
            func_vetor_instala_ajuda

            sleep $aguarda
            exit 0
        elif [[ $@ = "instala_outros" ]]; then
            func_vetor_instala_outros_ajuda

            sleep $aguarda
            exit 0
        elif [[ $@ = "remove" ]]; then
            func_vetor_remove_ajuda

            sleep $aguarda
            exit 0
        elif [[ $@ = "ajuda" ]]; then
            func_vetor_instala_ajuda
            func_vetor_corrige_ajuda
            func_vetor_config_ajuda
            func_vetor_limpa_ajuda
            func_vetor_instala_ajuda
            func_vetor_instala_outros_ajuda
            func_vetor_remove_ajuda
            # exit 0
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
		[[ $? = "1" ]] && \
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
    
    if [[ $valor = "Automatica" ]]; then
            escolha=$(
            	zenity --list --title="Automatizar de tarefas" \
	        	   --text="O que deseja fazer?"  \
	        	   --width "150" \
	        	   --height "300" \
	        	   --column="Select" --column="Acao" \
	        	   --radiolist \
    	        	   	FALSE Todas \
						TRUE Geral \
                        FALSE Atualizar \
                        FALSE Corrigir \
                        FALSE Configurar \
                        FALSE Limpar \
                        FALSE Instalar \
                        FALSE Remover \
            ) ; f_verifica

            # executa funcao X e saida do script
            [[ $escolha = "Todas" ]] && func_todas && exit 0 ||
			[[ $escolha = "Geral" ]] && func_geral && exit 0 ||			
			[[ $escolha = "Atualizar" ]] && func_atualiza && exit 0 ||
			[[ $escolha = "Corrigir" ]] && func_corrige && exit 0 ||
            [[ $escolha = "Configurar" ]] && func_config && exit 0 ||
			[[ $escolha = "Limpar" ]] && func_limpa && exit 0 ||
			[[ $escolha = "Instalar" ]] && func_instala && exit 0 ||
			[[ $escolha = "Remover" ]] && func_remove && exit 0
	elif [[ $valor = "Manual" ]]; then
		escolha=$(zenity --list --title="Automatizar de tarefas" \
        	   --text="O que deseja fazer?"  \
        	   --width "150" \
        	   --height "200" \
        	   --column "" --column="Marque" \
        	   --radiolist \
                    TRUE Atualizar \
                    FALSE Corrigir \
                    FALSE Configurar \
                    FALSE Limpar \
                    FALSE Instalar \
                    FALSE Remover \
        ) ; f_verifica        

        for (( i = 0; i <= ${#vetor[@]}; i++ )); do  
            if [[ ${vetor[$i]} = $escolha ]]; then   
                if [[ $escolha = "atualiza" ]]; then                        	
                    for (( i = 0; i < ${#atualiza[@]}; i++ )); do	                        	                       
                    	acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${atualiza[$i]}"
                        ) ; f_verifica
                    done
                elif [[ $escolha = "corrige" ]]; then
                	for (( i = 0; i < ${#corrige[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${corrige[$i]}"                                        	
                        ) ; f_verifica
                    done
                elif [[ $escolha = "config" ]]; then
                    for (( i = 0; i < ${#config[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${config[$i]}"                                         
                        ) ; f_verifica
                    done
                elif [[ $escolha = "limpa" ]]; then
                	for (( i = 0; i < ${#limpa[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${limpa[$i]}"                                        	
                        ) ; f_verifica
                    done
                elif [[ $escolha = "instala" ]]; then
                	for (( i = 0; i < ${#instala[@]}; i++ )); do
                        acoes=$(zenity --title="Modo manual" \
                            --width="300" --height=250 \
                            --list \
                            --text="Selecione as açoes" \
                            --column "" --column="Marque" --column="Acao" \
                            --checklist FALSE "$i" "${instala[$i]}"                                        	
                        ) ; f_verifica
                    done
            	elif [[ $escolha = "remove" ]]; then
            	for (( i = 0; i < ${#remove[@]}; i++ )); do
                    acoes=$(zenity --title="Modo manual" \
                        --width="300" --height=250 \
                        --list \
                        --text="Selecione as açoes" \
                        --column "" --column="Marque" --column="Acao" \
                        --checklist FALSE "$i" "${remove[$i]}"                                        	
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

  #               elif [[ $escolha = 1 ]]; then                    
  #                   printf ""
  #               elif [[ $escolha = 2 ]]; then
  #                   printf ""
  #               elif [[ $escolha = 3 ]]; then
  #                   for chave in ${instala[@]}; do 
					# 	# echo "$chave = ${instala[$chave]}"; 
					# 	echo "$chave";
					# done
  #               elif [[ $escolha = 4 ]]; then
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

func_verifica_internet()
{
	# verificando internet
  	# se nao tiver internet, fecha script
  	ping -c1 $ping_server >> /dev/null
  	[[ ! $? -eq 0 ]] && clear && notify-send -u normal "Sem internet, saindo do script." -t 10000 && exit 1
}

main()
{
    clear
    
    escolha_vetor=$1 # vetor
    help_vetor=$2    # ajuda

	echo "Iniciando script, aguarde..."
	[[ $verifica_internet = "1" ]] && func_verifica_internet

  	## se nao for digitado parametros na chamada
  	[[ $# -eq 0 ]] && func_help && exit 0

    # se o primeiro parametro for igual a vetor, o segundo vazio.
    [[ $1 = "vetor" ]] && [[ $2 = "" ]] && 
        clear && echo $mensagem_ajuda && exit 0

    # se o primeiro paramento for igual a vetor, o segundo igual a ajuda e o terceiro vazio.
    [[ $1 = "vetor" ]] && [[ $2 = "ajuda" ]] && [[ $3 = "" ]] && 
        func_vetor_ajuda && exit 0

    # armazena log no arquivo
    [[ $? = 0 ]] && date > $arquivo_log

    for i in "$@"; 
    do    	  	
    	# verificando o que foi digitado
        case $i in
            todas) func_todas;;
			geral) func_geral;;
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