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
    printf "[!] Favor, logar na conta de super usuario!! \n"
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
        printf "\n[*] Atualizando lista de repositorios do sistema" >> $log_atualiza
        	apt update
    }

    upgrade()
    {
    	#Atualizando lista de programas do sistem
    	printf "\n[*] Atualizando lista de programas do sistema \n"
        printf "\n[*] Atualizando lista de programas do sistema \n" >> $log_atualiza
            ## atualizacao segura
	        apt upgrade -y
            
            if [[ $agressive_mode == "1" ]]; then
                ## atualizacoes completas                
                # MODE VIDA LOKA ON 
                # Os usuarios do ~Debian Stable~, podem pirar na batatinha... 
                apt dist-upgrade -y && \
                apt full-upgrade -y	
            fi
    }

# # # # # # # # # #
# # corrige SISTEMA
    apt_clean()
    {
        #Limpando lista arquivos sobressalentes
        printf "\n[*] Limpando arquivos sobressalentes"
        printf "\n[*] Limpando arquivos sobressalentes" >> $log_corrige

        apt-get clean

        update
    }

    pacotes_quebrados()
    {
        #corrigindo pacotes quebrados
        printf "\n[*] Corrigindo pacotes quebrados"
        printf "\n[*] Corrigindo pacotes quebrados" >> $log_corrige

        # removendo arquivos conflitantes
        rm -r /var/lib/apt/lists
        rm -rf /var/lib/dpkg/info/*.*
        mkdir -p /var/lib/apt/lists/partial

        # corrigindo possiveis erros na instalação de softwares
        dpkg --configure -a

        # corrigindo problema nos pacotes
        apt install -f 
        apt update --fix-missing 
        apt-get --fix-broken install

        # Atualizando versao dos pacotes instalados
        apt list --upgradable        
    }    

    atualiza_db()
    {
        printf "\n[*] Atualizando base de dados do sistema \n"        
        printf "\n[*] Atualizando base de dados do sistema \n" >> $log_corrige

    	updatedb
    }

    ## LAST_CORRIGE

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
                printf "\n[+] Swap otimizada \n" && printf "\n[+] Swap otimizada \n" >> $log_config || \
                printf "\n[-] Não há nada para ser otimizado - Swap \n" && printf "\n[-] Não há nada para ser otimizado - Swap \n" >> $log_config
    }

    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas        

		echo "[*] Configurando Deborphan... "
        echo "[*] Configurando Deborphan... " >> $log_config

        deborphan | xargs apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #Configurando o prelink e o preload
        echo "[*] Configurando Prelink e Preload... "
        echo "[*] Configurando Prelink e Preload... " >> $log_config
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)

		printf "[*] Ativando o PRELINK"
        printf "[*] Ativando o PRELINK" >> $log_config

        if [[ $prelink = "PRELINKING=unknown" ]]; then
            printf "adicionando ... \n"
            sed -i 's/unknown/yes/g' /etc/default/prelink
        else
        	printf "\n[-] Otimização já adicionada anteriormente."
            printf "\n[-] Otimização já adicionada anteriormente." >> $log_config
        fi
    }


    install_fonts()
    {
        #corrigindo erros fontes
        printf "\n[*] Instalando pacotes de fontes"
        printf "\n[*] Instalando pacotes de fontes\n" >> $log_config

        apt install ttf-mscoreinstall_fonts-installer install_fonts-noto ttf-freefont -f 
    }    

    config_ntp()
    {
        printf "\n[*] Configurando o NTP"
        printf "\n[*] Configurando o NTP" >> $log_config

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
            printf "\n[+] Hora do computador sincronizada!\n" >> $log_config
        else
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n"
            printf "\n[-] Nao foi possivel sincronizar com o servidor!\n" >> $log_config
        fi    
    }

    arquivo_hosts()
    {
        printf "\n[*] Alterando arquivo Hosts"
        printf "\n[*] Alterando arquivo Hosts" >> $log_config
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
                    printf "\n[*] Habilitando login automatico" >> $log_config

                    echo "autologin-user=$autor" >> $var_autologin
                    echo "autologin-user-timeout=0" >> $var_autologin

                    printf "\n[*] Reconfigurando lightdm, aguarde!" 
                    # dpkg-reconfigure lightdm 

                    if [[ $? = "0" ]]; then
                    	printf "\n[*] Configuracao atualizada com sucesso" 
                        printf "\n[*] Configuracao atualizada com sucesso" >> $log_config
                    else
                    	printf "\n[-] Erro na Configuracao - Autologin"
                        printf "\n[-] Erro na Configuracao - Autologin" >> $log_config
                    fi
                else
                    printf "\n[-] Erro autologin"
                    printf "\n[-] Erro autologin" >> $log_config
                fi  
            else
                printf "\n[-] Login automatico na inicializacao, ja esta habilitado!!"
                printf "\n[-] Login automatico na inicializacao, ja esta habilitado!!" >> $log_config
            fi
        else
            printf "\n[-] O login automatico esta desabilitado! Verificar script."
            printf "\n[-] O login automatico esta desabilitado! Verificar script. " >> $log_config
        fi      
    }    

    icones_temas()
    {       
    	# personalizacao icones
	    local var_icones_macos="/usr/share/themes/MacBuntu-OS"
	    local var_breeze="/usr/share/icons/Breeze"
	    local var_flatremix="/usr/share/icons/Flat_Remix_Light"
	    local var_papirus="/usr/share/icons/Papirus_Light"

        if [[ -e $var_breeze ]]; then             
            printf "\n[-] Voce ja possui os arquivos Breeze!"
            printf "\n[-] Voce ja possui os arquivos Breeze!" >> $log_config
        else            
            printf "\n[*] Copiando icones Breeze"
            printf "\n[*] Copiando icones Breeze" >> $log_config

            cp -r ../Config/Interface/icons/Breeze /usr/share/icons
        fi

        if [[ -e $var_flatremix ]]; then 
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!"
            printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!" >> $log_config
        else            
            printf "\n[*] Copiando icones Flat_Remix_Light"
            printf "\n[*] Copiando icones Flat_Remix_Light" >> $log_config

            cp -r ../Config/Interface/icons/Flat_Remix_Light /usr/share/icons
        fi

        if [[ -e $var_papirus ]]; then 
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!"
            printf "\n[-] Voce ja possui os arquivos Papirus_Light!" >> $log_config
        else            
            printf "\n[*] Copiando icones Papirus_Light"
            printf "\n[*] Copiando icones Papirus_Light" >> $log_config

            cp -r ../Config/Interface/icons/Papirus_Light /usr/share/icons
        fi

        if [[ -e $var_icones_macos ]]; then 
            printf "\n[-] Voce ja possui os arquivos MacOS X!"
            printf "\n[-] Voce ja possui os arquivos MacOS X!" >> $log_config
        else    
            printf "\n[*] Copiando icones MacOS X"
            printf "\n[*] Copiando icones MacOS X" >> $log_config

            cp -r ../Config/Interface/themes/* /usr/share/themes
        fi
    }        

    ## LAST_CONFIG

# # # # # # # # # #
# # limpa SISTEMA
    arquivos_temporarios()
    {
        printf "\n[*] Removendo arquivos temporários do sistema" 
        printf "\n[*] Removendo arquivos temporários do sistema" >> $log_limpa

    	find ~/.thumbnails -which f -atime +2 -exec rm -Rf {} \+
    }

    pacotes_orfaos()
    {
        printf "\n[*] Removendo Pacotes Órfãos"
        printf "\n[*] Removendo Pacotes Órfãos" >> $log_limpa

        apt-get remove $(deborphan) -y 
    }

    funcao_chkrootkit()
    {
        printf "\n[*] Verificando Chkrootkit\n"
        printf "\n[*] Verificando Chkrootkit" >> $log_limpa

        chkrootkit
    }

    ## LAST_LIMPA

# # # # # # # # # #
# # INSTALA PROGRAMAS
    install_chromium()
    {              
        local var_chromium=$(type chromium > /dev/null)        

        if [[ $distro = "Debian" ]]; then 
            if [[ $var_chromium = "1" ]]; then
                printf "\n[*] Instalando o Chromium"
                printf "\n[*] Instalando o Chromium" >> $log_instala

                # navegador + pacotes de idiomas
                apt install chromium chromium-l10n -y
            else
                printf "\n[*] Chromium ja esta instalado"
                printf "\n[*] Chromium ja esta instalado" >> $log_instala
            fi  
        else
            printf "\n[-] Erro instalação Chromium"
            printf "\n[-] Erro instalação Chromium" >> $log_instala
        fi 
    }

    install_tor()
    {
        local var_tor="/opt/tor/tor-browser_en-US"

        if [[ -e $var_tor ]]; then
            printf "\n[*] Instalando o Tor\n"
            printf "\n[*] Instalando o Tor\n" >> $log_instala

            # verificando distribuição
            if [[ $distro = "Debian" ]]; then                
                echo "Verificar: 'repo sysadmin/others/install_tor.sh'"
            fi

        else
            printf "\n[-] Tor já está instalado!" 
            printf "\n[-] Tor já está instalado! \n" >> $log_instala
        fi           
    }

    install_steam()
    {
    	local var_steam=$(type steam > /dev/null)

        if [[ $var_steam = "1" ]]; then
	        printf "\n[*] Instalando Steam"
	        printf "\n[*] Instalando Steam" >> $log_instala

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
            printf "\n[-] Steam já está instalado!" >> $log_instala
	    fi
    }

    install_spotify()
    {
        # variavel de verificação
        local var_spotify=$(snap list | grep spotify)

        if [[ $var_spotify = "0" ]]; then            
            printf "\n[+] Atualizando o Spofity! \n"
            printf "\n[+] Atualizando o Spofity! \n" >> $log_instala

            snap refresh spotify
        else
            printf "\n[*] Instalando Spotify\n"
            printf "\n[*] Instalando Spotify" >> $log_instala

            snap install spotify
        fi
    }   

    install_codecs()
    {
        printf "\n[*] Instalando Pacotes Multimidias (Codecs)"
        printf "\n[*] Instalando Pacotes Multimidias (Codecs)" >> $log_instala

        apt install faac faad ffmpeg lame flac icedax \
                    id3v2 lame libflac++6v5 libjpeg-turbo-progs \
                    mencoder mjpegtools mpeg2dec \
                    mpeg3-utils mpegdemux regionset sox \
                    uudeview vorbis-tools x264 arj p7zip p7zip-full \
                    unace-nonfree sharutils uudeview libav-tools \
                    mpack cabextract libdvdread4 libav-tools  \
                    easytag id3tool libmozjs185-1.0 \
                    libopusfile0 tagtool libavcodec-extra \
                    libavcodec-extra -y --force-yes    
    }

    install_gimp()
    {
     	# variavel de verificação
        local var_gimp=$(type gimp > /dev/null)

        if [[ $var_gimp = "1" ]]; then
            printf "\n[*] Instalando o Gimp"
            printf "\n[*] Instalando o Gimp" >> $log_instala

            apt install gimp -y
        else
            printf "\n[-] GIMP já está instalado na sua máquina!"
            printf "\n[-] GIMP já está instalado na sua máquina!" >> $log_instala
        fi
    }

    install_xfce4()
    {
        # variaveis
        local var_xfpanel=$(type xfpanel-switch > /dev/null)        
        local var_whiskermenu=$(type xfce4-popup-whiskermenu > /dev/null)


        printf "\n[*] Instalando adicionais do XFCE" 
        printf "\n[*] Instalando adicionais do XFCE" >> $log_instala

        #Instalando componentes do XFCE
        apt install xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin \
                    xfce4-diskperf-plugin xfce4-linelight-plugin xfce4-battery-plugin \
                    xfce4-clipman-plugin xfce4-indicator-plugin xfce4-notes-plugin \
                    xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin \
                    xfce4-screenshooter-plugin xfce4-whiskermenu-plugin xfce4-smartbookmark-plugin \
                    xfce4-weather-plugin xfce4-wavelan-plugin xfce4-sensors-plugin \
                    xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin \
                    xfce4-mailwatch-plugin xfce4-xkb-plugin xfce4-fsguard-plugin \
                    xfce4-genmon-plugin xfce4-fsguard-plugin \
                    xfce4-mount-plugin smartmontools -fyq

        # adicionais para serem utilizados
        apt install hddtemp -y     

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp        

        if [[ $var_xfpanel = "1" ]]; then
            printf "\n[*] Instalando Xfpanel-switch"
            printf "\n[*] Instalando Xfpanel-switch" >> $log_instala

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfpanel-switch_1.0.4-0ubuntu1_all.deb
        else
            printf "\n[-] Xfpanel-switch ja esta instalado"
            printf "\n[-] Xfpanel-switch ja esta instalado" >> $log_instala
        fi      

        if [[ $var_whiskermenu = "1" ]]; then
            printf "\n[*] Instalando Whisker-menu"
            printf "\n[*] Instalando Whisker-menu" >> $log_instala

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/packages/xfce/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb
        else
            printf "\n[-] Whisker-menu ja esta instalado"
            printf "\n[-] Whisker-menu ja esta instalado" >> $log_instala
        fi
    }

    install_wine()
    {
    	# variavel de verificação
        local var_wine=$(type wine > /dev/null)

        if [[ $var_wine = "1" ]]; then
        	printf "\n[*] Instalando o Wine"
            printf "\n[*] Instalando o Wine" >> $log_instala

            if [[ $distro = "Debian" ]]; then
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
            	printf "\n[-] Erro ao instalar Wine" >> $log_instala
            fi            
        else
            printf "\n[-] Wine já está instalado na sua máquina!"
            printf "\n[-] Wine já está instalado na sua máquina!" >> $log_instala
        filsef
    }

    install_playonlinux()
    {
        local var_playonlinux=$(type playonlinux > /dev/null)

        if [[ $var_playonlinux = "1" ]]; then
            printf "\n[*] Instalando o PlayonLinux"
            printf "\n[*] Instalando o PlayonLinux" >> $log_instala

            apt install playonlinux -y
        else
            printf "\n[-] PlayonLinux ja esta instalado"
            printf "\n[-pu] PlayonLinux ja esta instalado" >> $log_instala
        fi        
    }

    install_redshift()
    {
        printf "\n[*] Instalando o Redshift"
        printf "\n[*] Instalando o Redshift" >> $log_instala

        apt install redshift gtk-redshift -y        
    }

    install_libreoffice()
    {
        printf "\n[*] Instalando o Libreoffice"
        printf "\n[*] Instalando o Libreoffice" >> $log_instala

        #Instalando libreoffice
        apt-get install libreoffice libreoffice-style-breeze -y
    }

    install_vlc()
    {
        printf "\n[*] Instalando o VLC"
        printf "\n[*] Instalando o VLC" >> $log_instala

        apt install vlc -y
    }

    install_clementine()
    {
        printf "\n[*] Instalando o Clementine"
        printf "\n[*] Instalando o Clementine" >> $log_instala

        apt install clementine -y
    }

    install_gparted()
    {
        printf "\n[*] Instalando o Gparted"
        printf "\n[*] Instalando o Gparted" >> $log_instala

        apt install gparted -y
    }

    install_tlp()
    {
        printf "\n[*] Instalando o Tlp"
        printf "\n[*] Instalando o Tlp" >> $log_instala

        apt install tlp -y
    }

    install_git()
    {
        printf "\n[*] Instalando o Git"
        printf "\n[*] Instalando o Git" >> $log_instala

        apt install git-core git -y
    }

    install_lm-sensors()
    {
        printf "\n[*] Instalando o Lm-sensors"
        printf "\n[*] Instalando o Lm-sensors" >> $log_instala

        apt install lm-sensors -y
    }

    install_stellarium()
    {
        # variavel de verificação
        local var_stellarium=$(type stellarium > /dev/null)

        if [[ $var_stellarium = "1" ]]; then
            #Instalando o stellarium
            apt install stellarium -y
        else
            printf "\n[-] Stellarium já está instalado!"
            printf "\n[-] Stellarium já está instalado!" >> $log_instala
        fi
    }

    install_reaver()
    {
        printf "\n[*] Instalando o Reaver"
        printf "\n[*] Instalando o Reaver" >> $log_instala

        apt install reaver -y
    }  

    install_neofetch()
    {
        printf "\n[*] Instalando o Neofetch"
        printf "\n[*] Instalando o Neofetch" >> $log_instala

        apt install neofetch -y
    }

    install_sweethome3d()
    {
        printf "\n[*] Instalando Sweet Home 3D"
        printf "\n[*] Instalando Sweet Home 3D" >> $log_instala

        apt install sweethome3d -y
    }

    install_cheese()
    {
        printf "\n[*] Instalando o Cheese"
        printf "\n[*] Instalando o Cheese" >> $log_instala

        apt install cheese -y
    }

    install_gnome_system_monitor()
    {
        printf "\n[*] Instalando o Gnome System Monitor"
        printf "\n[*] Instalando o Gnome System Monitor" >> $log_instala

        apt install gnome-system-monitor -y
    }    

    install_wireshark()
    {
        printf "\n[*] Instalando o Wireshark"
        printf "\n[*] Instalando o Wireshark \n" >> $log_instala

        apt install wireshark -y
    }

    install_gnome_disk_utility()
    {
        printf "\n[*] Instalando o Gnome Disk Utility"
        printf "\n[*] Instalando o Gnome Disk Utility" >> $log_instala

        apt install gnome-disk-utility -y
    }

    install_audacity()
    {
        printf "\n[*] Instalando o Audacity"
        printf "\n[*] Instalando o Audacity" >> $log_instala

        apt install audacity -y
    }

    install_simple_screen_recorder()
    {
        # variavel de verificação
        local var_simplescreenrecorder=$(type simplescreenrecorder > /dev/null)

        if [[ $var_simplescreenrecorder = "1" ]]; then
            apt-get install simplescreenrecorder -y
        else
            printf "\n[-] Simple Screen Recorder já está instalado!"
            printf "\n[-] Simple Screen Recorder já está instalado!" >> $log_instala
        fi
    }

    install_mega()
    {       
        # variavel de verificação
        local var_mega=$(type megasync > /dev/null)

        if [[ $var_mega = "1" ]]; then        
            printf "\n[*] Instalando o MEGA"
            printf "\n[*] Instalando o MEGA" >> $log_instala
            
			apt install megasync -y
        else
            printf "\n[-] MEGA Sync já está instalado!"
            printf "\n[-] MEGA Sync já está instalado!" >> $log_instala
        fi
    }

    install_openssh()
    {
        printf "\n[*] Instalando o OpenSSH"
        printf "\n[*] Instalando o OpenSSH" >> $log_instala

        apt install openssh-client openssh-server -y
    }

    install_figlet()
    {
        printf "\n[*] Instalando o Figlet"
        printf "\n[*] Instalando o Figlet" >> $log_instala

        apt install figlet -y
    }

    install_chkrootkit()
    {
        printf "\n[*] Instalando o Chkrootkit"
        printf "\n[*] Instalando o Chkrootkit" >> $log_instala

        apt install chkrootkit -y
    }

    install_hardinfo()
    {
        printf "\n[*] Instalando o Hardinfo"
        printf "\n[*] Instalando o Hardinfo" >> $log_instala

        apt install hardinfo -y
    }

    install_nvidia()
    {
        # variavel de verificação
        local var_nvidia=$(type nvidia-settings > /dev/null)

        if [[ $var_nvidia = "1" ]]; then
        	    apt install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-driver nvidia-xconfig -y
        else
            printf "\n[-] Nvidia já está instalado no sistema!"
            printf "\n[-] Nvidia já está instalado no sistema!" >> $log_instala
        fi
    }

    install_virtualbox()
    {
        # variavel de verificação
        local var_virtualbox=$(type virtualbox > /dev/null)

        # criando verificação para instalar o virtualbox
        if [[ $var_virtualbox = "1" ]]; then 
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
        else
            printf "\n[-] VirtualBox já está instalado! \n"
            printf "\n[-] VirtualBox já está instalado! \n" >> $log_instala
        fi
    }

    install_ristretto()
    {
        printf "\n[*] Instalando o Ristretto"
        printf "\n[*] Instalando o Ristretto" >> $log_instala

        apt install ristretto -y
    }

    install_tree()
    {
        printf "\n[*] Instalando o Tree"
        printf "\n[*] Instalando o Tree" >> $log_instala

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        local var_pulseeeffects=$(type pulseeffects > /dev/null)

        if [[ $var_pulseeeffects = "1" ]]; then
            printf "\n[*] Instalando o Pulse Effects"
            printf "\n[*] Instalando o Pulse Effects" >> $log_instala

            # adicionando via flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            # Instalando via flatpak
            flatpak install flathub com.github.wwmm.pulseeffects -y                

            if [[ $distro = "Debian" ]]; then                  
                local pulse_audio="/etc/pulse/daemon.conf"
                local flat_volume="flat-volumes = no"
                local verifica_pulse=$(grep $flat_volume $pulse_audio)        

                # executando caso nao encontre $flat_volume
                [[ $verifica_pulse = "" ]] && echo $flat_volume >> $pulse_audio && \
                                              printf "\n[+] Arquivo $pulse_audio modificado!" && printf "\n[+] Arquivo $pulse_audio modificado!" >> $log_instala || \
                                              printf "\n[-] Arquivo $pulse_audio nao foi modificado!" && printf "\n[-] Arquivo $pulse_audio nao foi modificado!" >> $log_instala

                ######## COMENTARIO                        
                ## Se houve erro no servidor do pulseaudio, basta reinstalo com o comando:
                # apt install --reinstall pulseaudio
            fi
        else                
            printf "\n[*] Atualizando o pulseeffects\n"
            printf "\n[*] Atualizando o pulseeffects\n" >> $log_instala

            flatpak update com.github.wwmm.pulseeffects -y                
        fi            
    }
    
    install_terminator()
    {
        printf "\n[*] Instalando o Terminator"
        printf "\n[*] Instalando o Terminator" >> $log_instala
        
        apt install terminator -y
    }

    install_aircrack()
    {
        printf "\n[*] Instalando o Aircrack-ng"
        printf "\n[*] Instalando o Aircrack-ng" >> $log_instala

        apt install aircrack-ng -y
    }

    install_snap()
    {
        printf "\n[*] Instalando o Snap"
        printf "\n[*] Instalando o Snap" >> $log_instala

        apt install snapd -y      
    }

    install_ntp()
    {
        printf "\n[*] Instalando o NTP"
        printf "\n[*] Instalando o NTP" >> $log_instala

        apt install ntp ntpdate -y
    }

    install_xclip()
    {
        printf "\n[*] Instalando o Xclip"
        printf "\n[*] Instalando o Xclip" >> $log_instala

        apt install xclip -y
    }

    install_espeak()
    {
        printf "\n[*] Instalando o Speak"
        printf "\n[*] Instalando o Speak" >> $log_instala

        apt install espeak -y	
    }

    install_ibus()
    {
        printf "\n[*] Instalando o Ibus"
        printf "\n[*] Instalando o Ibus" >> $log_instala

        apt install ibus -y
    }

    install_nmap()
    {
        printf "\n[*] Instalando o Nmap"
        printf "\n[*] Instalando o Nmap" >> $log_instala

        apt install nmap -y
    }

    install_htop()
    {
    	printf "\n[*] Instalando o Htop"
        printf "\n[*] Instalando o Htop" >> $log_instala

        apt install htop -y
    }

    install_gnome_calculator()
    {
        printf "\n[*] Instalando o Gnome Calculator"
        printf "\n[*] Instalando o Gnome Calculator" >> $log_instala

        apt install gnome-calculator -y
    }

    install_tuxguitar()
    {
        # variavel de verificação
        local var_tuxguitar=$(type tuxguitar > /dev/null)

        # criando verificação para instalar o tuxguitar
        if [[ $var_tuxguitar = "1" ]]; then
            printf "\n[*] Instalando Tux Guitar"
            printf "\n[*] Instalando Tux Guitar" >> $log_instala

            apt install tuxguitar timidity -y
        else
            printf "\n[-] TuxGuitar já está instalado"
            printf "\n[-] TuxGuitar já está instalado" >> $log_instala
        fi
    }

    install_zsh()
    {
        # variavel de verificação
        local var_zsh=$(type zsh > /dev/null)        

		# criando verificação para instalar zsh
        if [[ $var_zsh = "1" ]]; then
            printf "\n[*] Instalando o ZSH"
            printf "\n[*] Instalando o ZSH" >> $log_instala

	        apt install zsh zsh-common -y
	    else
	    	printf "\n[-] O ZSH ja esta instalado no seu sistema"
	    	printf "\n[-] O ZSH ja esta instalado no seu sistema" >> $log_instala
	    fi
    }

    install_docker()
    {
        # variavel de verificação
        local var_docker=$(type docker > /dev/null)

        # criando verificação para instalar o docker
        if [[ $var_docker = "1" ]]; then
        	printf "\n[*] Instalando o Docker"
            printf "\n[*] Instalando o Docker" >> $log_instala
    
            curl -fsSL https://get.docker.com/ | sh            
        else
            printf "\n[-] O Docker já está instalado no seu sistema."
            printf "\n[-] O Docker já está instalado no seu sistema." >> $log_instala
        fi
    }

    install_sublime()
    {
         # variavel de verificação
        local var_sublime="/opt/sublime_text"

        # criando verificação para instalar o sublime
        if [[ -e $var_sublime ]]; then
            printf "\n[*] Instalando o Sublime"
            printf "\n[*] Instalando o Sublime" >> $log_instala

            # snap
            snap install sublime-text --classic
        else
            snap refresh sublime-text --classic
        fi
    }

    install_firmware()
    {
        printf "\n[*] Instalando os firmware's non-free"        
        printf "\n[*] Instalando os firmware's non-free" >> $log_instala

        if [ $distro = "Debian" ]; then
            if [[ $v_hostname = 'notebook' ]]; then   
                apt install xserver-xorg-input-synaptics \
                    blueman  firmware-brcm80211 -y      
            fi

            apt install firmware-linux \
                        firmware-linux-nonfree -y
        else
            printf "\n[-] ERRO - firmware"
            printf "\n[-] ERRO - firmware" >> $log_instala
        fi        
    }     

    install_python()
    {        
        printf "\n[*] Instalando o Pip" 
        printf "\n[*] Instalando o Pip" >> $log_instala

        apt install python3.5 python-pip -y

    	if [[ $distro = "Debian" ]]; then
            pip install krpc
        fi           
    }

    install_youtubedl()
    {
        printf "\n[*] Instalando o Youtube-DL\n" 
        printf "\n[*] Instalando o Youtube-DL\n" >> $log_instala

        pip install youtube-dl 

        pip install --upgrade youtube-dl 
    }

    install_yad()
    {
        printf "\n[*] Instalando o YAD" 
        printf "\n[*] Instalando o YAD" >> $log_instala

        apt install yad -y    	
    }

    install_dropbox()
    {
        printf "\n[*] Instalando Dropbox"
        printf "\n[*] Instalando Dropbox" >> $log_instala

        apt install nautilus-dropbox -y
    }

    install_transmission()
    {
        local var_transmission=$(type transmission-gtk > /dev/null)

        # verificando se transmission está instalado
        if [[ $var_transmission = "1" ]]; then
            printf "\n[*] Instalando o Transmission"
            printf "\n[*] Instalando o Transmission" >> $log_instala

            apt install transmission-gtk -y
        fi
    }

    install_xfburn()
    {
        printf "\n[*] Instalando XFBurn"
        printf "\n[*] Instalando XFBurn" >> $log_instala

        apt install xfburn -y
    }

    install_wavemon()
    {
        printf "\n[*] Instalando o Wavemon"        
        printf "\n[*] Instalando o Wavemon" >> $log_instala

        apt install wavemon -y
    }

    install_prelink()
    {
        printf "\n[*] Instalando Prelink"
        printf "\n[*] Instalando Prelink" >> $log_instala

        apt install prelink -y         
    }   

    install_preload()
    {
        printf "\n[*] Instalando Preload"
        printf "\n[*] Instalando Preload" >> $log_instala

        apt install preload -y         
    }   

    install_deborphan()
    {
        printf "\n[*] Instalando Deborphan"
        printf "\n[*] Instalando Deborphan" >> $log_instala

        apt-get install deborphan -y
    }

    install_locate()
    {
    	# variavel de verificação
        local var_locate=$(type locate > /dev/null)

        if [[ $var_locate = "1" ]]; then
            printf "\n[*] Instalando Locate"
            printf "\n[*] Instalando Locate" >> $log_instala

        	apt install locate -y
        else
            printf "\n[-] Locate ja esta instalado!"
            printf "\n[-] Locate ja esta instalado!" >> $log_instala
        fi
    }

    install_arpscan()
    {
    	printf "\n[*] Instalando ARP Scan"
        printf "\n[*] Instalando ARP Scan" >> $log_instala

        apt install arp-scan -y
    }

    install_ufw()
    {
        printf "\n[*] Instalando o UFW"
        printf "\n[*] Instalando o UFW" >> $log_instala

        apt install ufw gufw -y

        ## iniciando o ufw automaticamente no sistema
        ufw enable && systemctl enable ufw && systemctl start ufw
    }

    install_flatpak()
    {
        printf "\n[*] Instalando o Flatpak"
        printf "\n[*] Instalando o Flatpak" >> $log_instala

        apt install flatpak -y
    }

    install_notify()
    {
		# variavel de verificação
        local var_notify=$(type notify-osd > /dev/null)

        if [[ $var_notify = "1" ]]; then
        	printf "\n[*] Instalando o Notify-send"
	        printf "\n[*] Instalando o Notify-send" >> $log_instala

	        apt install notify-osd -y
	        # apt --reinstall install libnotify-bin notify-osd -y
        else    
        	printf "\n[-] Notify-send ja esta instalado"
	        printf "\n[-] Notify-send ja esta instalado" >> $log_instala
	    fi
    }

    install_evince()
    {
        printf "\n[*] Instalando o Evince"
        printf "\n[*] Instalando o Evince" >> $log_instala

        apt install evince -y
    }

    install_rar()
    {
        printf "\n[*] Instalando o Rar"
        printf "\n[*] Instalando o Rar" >> $log_instala

        apt install rar unrar -y
    }

    install_nautilus()
    {
    	# variavel de verificação
        local var_nautilus=$(type nautilus > /dev/null)

        if [[ $var_nautilus = "1" ]]; then
        	printf "\n[*] Instalando o Nautilus"
	        printf "\n[*] Instalando o Nautilus" >> $log_instala

	        apt install nautilus* -y
        else    
        	printf "\n[-] Nautilus ja esta instalado"
	        printf "\n[-] Nautilus ja esta instalado" >> $log_instala
	    fi

    }

    install_ntfs()
    {
    	printf "\n[*] Instalando o NTFS-3g"
    	printf "\n[*] Instalando o NTFS-3g" >> $log_instala

    	apt install ntfs-3g -y
    }

    install_mpg123()
    {
        printf "\n[*] Instalando o MPG13"
        printf "\n[*] Instalando o MPG13" >> $log_instala

        apt install mpg123 -y
    }

    install_links()
    {
        printf "\n[*] Instalando o Links2"
        printf "\n[*] Instalando o Links2" >> $log_instala

        apt install links links2 -y
    }

    install_googleearth()
    {
        printf "\n[*] Instalando o Google Earth"
        printf "\n[*] Instalando o Google Earth" >> $log_instala

        if [[ -e "/opt/google/earth" ]]; then
            printf "\n[-] Google Earth ja esta instalado!"
            printf "\n[-] Google Earth ja esta instalado!" >> $log_instala            
        else
            dpkg -i base/packages/google_earth/google-earth-pro-stable_current_amd64.deb  
        fi        
    }

    install_gwe()
    {    
        local var_gwe=$(type gwe > /dev/null)
        
        if [[ $var_gwe == "1" ]]; then
            printf "\n[*] Instalando o GreenWithEnvy\n"
            printf "\n[*] Instalando o GreenWithEnvy\n" >> $log_instala           

            # adicionando via flatpak
            flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            # Instalando via flatpak
            flatpak --user install flathub com.leinardi.gwe
        else                
            printf "\n[*] Atualizando o GWE\n"
            printf "\n[*] Atualizando o GWE\n" >> $log_instala

            flatpak update com.leinardi.gwe -y                
        fi            
    }

    install_ibam()
    {
        printf "\n[*] Instalando o IBam\n"
        printf "\n[*] Instalando o IBam\n" >> $log_instala

        apt install ibam -y
    }

    install_xdotool()
    {
        printf "\n[*] Instalando o Xdotool"
        printf "\n[*] Instalando o Xdotool" >> $log_instala

        apt install xdotool -y
    }

    ## LAST_INSTALL

# # # # # # # # # #
# # REMOVE PROGRAMAS
	remove_thunderbird()
	{
		printf "\n[*] Removendo o Thunderbird"
        printf "\n[*] Removendo o Thunderbird" >> $log_remove

        apt purge thunderbird -y
	}

	remove_inkspace()
	{
		printf "\n[*] Removendo o Inkscape "
        printf "\n[*] Removendo o Inkscape " >> $log_remove
		
		apt purge inkscape -y
	}

	remove_blender()
	{
		printf "\n[*] Removendo o Blender"
        printf "\n[*] Removendo o Blender" >> $log_remove
		
		apt purge blender -y
	}

	remove_parole()
	{
		printf "\n[*] Removendo o Parole"
        printf "\n[*] Removendo o Parole" >> $log_remove
		
		apt purge parole -y
	}

	remove_exfalso()
	{
		printf "\n[*] Removendo o Exfalso"
        printf "\n[*] Removendo o Exfalso" >> $log_remove
		
		apt purge exfalso -y
	}

	remove_quolibet()
	{
		printf "\n[*] Removendo o Quolibet"
        printf "\n[*] Removendo o Quolibet" >> $log_remove
		
		apt purge qoulibet -y
	}

	remove_xterm()
	{
		printf "\n[*] Removendo o Xterm"
        printf "\n[*] Removendo o Xterm" >> $log_remove
		
		apt purge xterm -y
	}

	remove_xsane()
	{
		printf "\n[*] Removendo o XSane"
        printf "\n[*] Removendo o XSane" >> $log_remove
		
		apt purge xsane -y
	}

	remove_pidgin()
	{
		printf "\n[*] Removendo o Pidgin"
        printf "\n[*] Removendo o Pidgin" >> $log_remove

		apt purge pidgin -y
	}

	remove_meld()
	{
		printf "\n[*] Removendo o Meld"
        printf "\n[*] Removendo o Meld" >> $log_remove
		
		apt purge meld* -y
	}

	remove_gtkhash()
	{
		printf "\n[*] Removendo o Gtkhash"
        printf "\n[*] Removendo o Gtkhash" >> $log_remove
	
		apt purge gtkhash* -y	
	}

	remove_imagemagick()
	{
		printf "\n[*] Removendo o Imagemagick"
        printf "\n[*] Removendo o Imagemagick" >> $log_remove
		
		apt purge imagemagick* -y
	}

	remove_chromium-bsu()
	{
		printf "\n[*] Removendo o Chromium-BSU"
        printf "\n[*] Removendo o Chromium-BSU" >> $log_remove
		
		apt purge chromium-bsu -y
	}

	remove_owncloud()
	{
		printf "\n[*] Removendo o Owncloud"
        printf "\n[*] Removendo o Owncloud" >> $log_remove
		
		apt purge owncloud* -y
	}

	remove_kstars()
	{
		printf "\n[*] Removendo o Pidgin"
        printf "\n[*] Removendo o Pidgin" >> $log_remove
		
		apt purge kstars -y
	}

	remove_steam()
	{
		printf "\n[*] Removendo o Steam"
        printf "\n[*] Removendo o Steam" >> $log_remove
		
		apt purge steam -y
	}

	remove_kdenlive()
	{
		printf "\n[*] Removendo o Kdenlive"
        printf "\n[*] Removendo o Kdenlive" >> $log_remove
		
		apt purge kdenlive -y
	}

	remove_transmission()
	{
		printf "\n[*] Removendo o Transmission"
        printf "\n[*] Removendo o Transmission" >> $log_remove
		
		apt purge transmission -y
	}

	remove_smartgit()
	{
		printf "\n[*] Removendo o Smartgit"
        printf "\n[*] Removendo o Smartgit" >> $log_remove
		
		apt purge smartgit -y
	}

	remove_gitg()
	{
		printf "\n[*] Removendo o Gitg"
        printf "\n[*] Removendo o Gitg" >> $log_remove
		
		apt purge gitg -y
	}

    remove_mpv()
    {
        printf "\n[*] Removendo o Mpv"
        printf "\n[*] Removendo o Mpv" >> $log_remove

        apt purge mpv -y
    }

    remove_clamav()
    {
        printf "\n[*] Removendo o clamAV"
        printf "\n[*] Removendo o clamAV" >> $log_remove

        apt purge clamav* clamtk clamtk-nautilus -y
    }

    remove_keyring()
    {
        printf "\n[*] Removendo o chaveiro da sessão"
        printf "\n[*] Removendo o chaveiro da sessão" >> $log_remove

        apt purge gnome-keyring -y  
    }  

    remove_zathura()
    {
        printf "\n[*] Removendo o zathura"
        printf "\n[*] Removendo o zathura" >> $log_remove

        apt purge zathura -y
    }

    remove_synaptic()
    {
        printf "\n[*] Removendo Synaptic"
        printf "\n[*] Removendo Synaptic" >> $log_remove

        apt purge synaptic -y
    }

    remove_youtubedl()
    {
        printf "\n[*] Removendo youtube-dl"
        printf "\n[*] Removendo youtube-dl" >> $log_remove

        apt purge youtube-dl -y
    }

    remove_simplescan()
    {
        printf "\n[*] Removendo o Simple-scan"
        printf "\n[*] Removendo o Simple-scan\n" >> $log_remove

        apt purge simple-scan -y
    }

    remove_gxine()
    {
        printf "\n[*] Removendo o GXine"
        printf "\n[*] Removendo o GXine\n" >> $log_remove

        apt purge gxine -y
    }

    remove_easytag()
    {
        printf "\n[*] Removendo o EasyTag"
        printf "\n[*] Removendo o EasyTag" >> $log_remove

        apt purge easytag* -y
    }

    ## LAST_REMOVE

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_keycheck()
{
    if [[ $file_check_on == "1" ]]; then    
    	# verificando se arquivo existe
    	check_arq=$(cat $file_check >> /dev/null)

    	# echo $checa_arq

    	if [[ $check_arq != "0" ]]; then
    		touch $file_check
    	fi

    	check_func=$(grep "AUTOCONFIG" $file_check | tail -1 | sed -e "s;AUTOCONFIG:;;g")

        if [[ "$key" != "$check_func" ]]; then
            echo "AUTOCONFIG:"$key >> $file_check   
        else
            printf "Esta com TOC amigo, voce ja rodou o script agora a pouco!! $check_func \n"

            sleep $aguarda

            exit 1
        fi
    fi
}

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

    apt_clean        
    
    pacotes_quebrados      

    atualiza_db   

	if [[ $v_hostname = 'notebook' ]]; then                        
        if [[ $distro = "Debian" ]]; then              
            printf ""   
        fi
    elif [[ $v_hostname = 'desktop' ]]; then        
        if [[ $distro = "Debian" ]]; then      
            printf ""   
        fi
    else
        printf "\n[-] ERRO corrige!"
        printf "\n[-] ERRO corrige!" >> $log_corrige
    fi

    update
}

func_config()
{
    notify-send -u normal "Configurando o sistema" -t 10000	

    config_ntp  

    swap
    prelink_preload_deborphan

    autologin
    arquivo_hosts

    icones_temas
}

func_limpa()
{
    notify-send -u normal "Limpando sistema" -t 10000

    clear   

    pacotes_orfaos
    funcao_chkrootkit
}

func_instala()
{
    notify-send -u normal "Instalando programas no sistema" -t 10000	

	install_chromium	
	install_tor

	install_codecs
	install_vlc
	install_clementine
	install_spotify	   
	install_simple_screen_recorder   
	
    install_stellarium
    install_libreoffice 

	install_xfce4  
    install_nautilus
    install_openssh    
    install_redshift
    install_ristretto    
    install_neofetch
    install_lm-sensors    
    install_tlp	   
    install_mega    

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
    install_xfburn 
    install_git
	install_python    
	install_sublime
    install_terminator
    install_youtubedl
    install_yad       
	install_ntp      
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
    install_ntfs 
    install_mpg123
    install_links
    install_xdotool

	if [[ $v_hostname = 'notebook' ]]; then		
        install_cheese
        install_aircrack  
        install_wavemon	
	    install_reaver  
        install_cpupower 
        install_ibam

		if [[ $distro = "Debian" ]]; then				
	    	echo    # nenhuma acao, por enquanto
		fi
	elif [[ $v_hostname = 'desktop' ]]; then     
        install_gimp    
        install_tuxguitar  
        install_wine
        install_playonlinux  
        install_sweethome3d
        install_pulseeffects

		install_audacity
        install_nvidia      
                
        install_transmission   
        install_googleearth 
        install_gwe
	else
		printf "\n[-] ERRO instala!"
		printf "\n[-] ERRO instala!" >> $log_instala
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
    remove_keyring
    remove_zathura
    remove_synaptic
    remove_youtubedl
    remove_simplescan
    remove_gxine
    remove_easytag
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

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # Configurando o sistema
    # func_config

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

func_interface_dialog()
{
    f_verifica()
    {
        [[ $? = "1" ]] && \
            dialog --timeout 2 --backtitle "$nome" --msgbox "\n Finalizando programa...!" 8 40 && exit 1
    }

    escolha=$(dialog \
            --stdout --ok-label "Executar" --cancel-label "Cancelar" \
            --menu "O que voce deseja fazer?" \
            0 0 0 \
            "NOR" "Geral" \
            "ALL" "Todas" \
            "UPD" "Atualizar" \
            "FIX" "Corrigir" \
            "CON" "Configurar" \
            "CLE" "Limpar" \
            "INS" "Instalar" \
            "REM" "Remover") ; f_verifica

            # executa funcao X e saida do script            
            [[ $escolha = "NOR" ]] && func_geral && exit 0 ||         
            [[ $escolha = "ALL" ]] && func_todas && exit 0 ||
            [[ $escolha = "UPD" ]] && func_atualiza && exit 0 ||
            [[ $escolha = "FIX" ]] && func_corrige && exit 0 ||
            [[ $escolha = "CON" ]] && func_config && exit 0 ||
            [[ $escolha = "CLE" ]] && func_limpa && exit 0 ||
            [[ $escolha = "INS" ]] && func_instala && exit 0 ||
            [[ $escolha = "REM" ]] && func_remove && exit 0           
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

func_manutencao()
{
    func_corrige
    func_limpa
    func_remove
}

main()
{    
    clear
    
    func_keycheck

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

    # armazena log nos arquivos
    date > $log_atualiza
    date > $log_corrige
    date > $log_config
    date > $log_limpa
    date > $log_instala
    date > $log_remove

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
    		interface) func_interface_dialog;;
            manutencao) func_manutencao;;
            *) clear && echo $mensagem_erro && exit 1
        esac            
    done

    # armazena log nos arquivos
    date >> $log_atualiza
    date >> $log_corrige
    date >> $log_config
    date >> $log_limpa
    date >> $log_instala
    date >> $log_remove
}

## chamando script
main $@

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
