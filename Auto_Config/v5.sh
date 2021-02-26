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
# por l3n0nr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # ARQUIVOS EXTERNOS
# resources used
# Read file config/references.conf
#
# script compatibility
# Read file /config/compatibility.conf
#
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

        ## atualizacao da distribuicao | caso exista
        apt dist-upgrade -y
    }

# # # # # # # # # #
# # corrige SISTEMA
    apt_clean()
    {
        #Limpando lista arquivos sobressalentes
        printf "\n[*] Limpando arquivos sobressalentes"
        printf "\n[*] Limpando arquivos sobressalentes" >> $log_corrige

        apt clean

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
        apt --fix-broken install

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

        deborphan | xargs apt -y remove --purge &&
        deborphan --guess-data | xargs apt -y remove --purge

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

    autologin()
    {       
        if [[ $boolean_autologin = "1" ]]; then
            local var_autologin="/etc/lightdm/lightdm.conf"

            cat $var_autologin | grep "autologin-user=$autor" > /dev/null

            # se saida do echo $? for 1, entao realiza modificacao
            if [[ $? = "1" ]]; then    
                if [[ $distro = "Debian" ]]; then             
                    printf "\n[*] Habilitando login automatico" 
                    printf "\n[*] Habilitando login automatico" >> $log_config

                    echo "autologin-user=$autor" >> $var_autologin
                    echo "autologin-user-timeout=0" >> $var_autologin

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
    }   

    arquivo_hosts()
    {
        printf "\n[*] Alterando arquivo Hosts"
        printf "\n[*] Alterando arquivo Hosts" >> $log_config

        ## copiando arquivo para /etc/hosts
        cat base/hosts/hosts > /etc/hosts               
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

        apt remove $(deborphan) -y 
    }

    funcao_chkrootkit()
    {
        printf "\n[*] Verificando Chkrootkit\n"
        printf "\n[*] Verificando Chkrootkit" >> $log_limpa

        chkrootkit
    }

    funcao_lynis()
    {
        echo "Realizando analise, aguarde..."
        echo "Realizando analise, aguarde..." >> $log_limpa

        lynis audit system --quick --reverse-colors --skip-plugins

        if [[ $? == "0" ]]; then
            echo "Analise finalizada!"
            echo "Analise finalizada!" >> $log_limpa

            echo "Mais detalhes em /var/log/lynis.log"
        else
            echo "Erro ao analisar!"
            echo "Erro ao analisar!" >> $log_limpa
        fi
    }

    ## LAST_LIMPA

# # # # # # # # # #
# # INSTALA PROGRAMAS
    install_chromium()
    {                  
        printf "\n[*] Instalando o Chromium"
        printf "\n[*] Instalando o Chromium" >> $log_instala

        # navegador + pacotes de idiomas
        apt install chromium chromium-l10n -y
    }

    install_tor()
    {
        printf "\n[*] Instalando o Tor\n"
        printf "\n[*] Instalando o Tor\n" >> $log_instala

        printf "\n [+] CHECK: repo sysadmin/others/install_tor.sh"
        printf "\n [+] CHECK: repo sysadmin/others/install_tor.sh" >> $log_instala
    }

    install_steam()
    {
    	local var_steam=$(type steam > /dev/null)

        if [[ $var_steam = "1" ]]; then
	        printf "\n[*] Instalando Steam"
	        printf "\n[*] Instalando Steam" >> $log_instala

			# adicionando arquitetura/dependencia      	
			dpkg --add-architecture i386		

			# Atualizando sistema			
			update

			# Instalando nvidia - dependencias debian
			apt install libgl1-mesa-dev libxtst6:i386 libxrandr2:i386 \
						libglib2.0-0:i386 libgtk2.0-0:i386 libpulse0:i386 \
						libgdk-pixbuf2.0-0:i386 steam-launcher -y

	        apt install steam -y
	    else
			printf "\n[-] Steam já está instalado!" 
            printf "\n[-] Steam já está instalado!" >> $log_instala
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
                    unace-nonfree sharutils uudeview \
                    mpack cabextract libdvdread4 \
                    easytag id3tool libopusfile0 \
                    libavcodec-extra -y
    }

    install_gimp()
    {
        printf "\n[*] Instalando o Gimp"
        printf "\n[*] Instalando o Gimp" >> $log_instala

        apt install gimp -y
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
                    xfce4-screenshooter xfce4-whiskermenu-plugin xfce4-smartbookmark-plugin \
                    xfce4-weather-plugin xfce4-wavelan-plugin xfce4-sensors-plugin \
                    xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin \
                    xfce4-mailwatch-plugin xfce4-xkb-plugin xfce4-fsguard-plugin \
                    xfce4-genmon-plugin xfce4-fsguard-plugin \
                    xfce4-mount-plugin smartmontools menulibre -fyq

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
    	printf "\n[*] Instalando o Wine"
        printf "\n[*] Instalando o Wine" >> $log_instala

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
        apt install wine -y

        # instalando fontes
        apt install ttf-mscorefonts-installer -y

        # instalando componentes
        apt install mono-complete -y                    
    }

    install_playonlinux()
    {
        printf "\n[*] Instalando o PlayonLinux"
        printf "\n[*] Instalando o PlayonLinux" >> $log_instala

        apt install playonlinux -y
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

        apt install libreoffice libreoffice-style-breeze -y
    }

    install_vlc()
    {
        printf "\n[*] Instalando o VLC"
        printf "\n[*] Instalando o VLC" >> $log_instala

        apt install vlc -y
    }

    install_audacious()
    {
        printf "\n[*] Instalando o Audacious"
        printf "\n[*] Instalando o Audacious" >> $log_instala

        apt install audacious -y
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
        printf "\n[+] Instalando o Stellarium!"
        printf "\n[+] Instalando o Stellarium!" >> $log_instala

        apt install stellarium -y
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
        printf "\n[+] Instalando  Simplescreenrecorder"
        printf "\n[+] Instalando  Simplescreenrecorder" >> $log_instala

        apt install simplescreenrecorder -y
    }

    install_mega()
    {       
        printf "\n[*] Instalando o MEGA"
        printf "\n[*] Instalando o MEGA" >> $log_instala
        
		dpkg -i base/packages/mega/*.deb
        apt --fix-broken install -y
        dpkg -i base/packages/mega/*.deb
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
                apt install virtualbox-5.1 -y    

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
        printf "\n[*] Instalando Tux Guitar"
        printf "\n[*] Instalando Tux Guitar" >> $log_instala

        apt install tuxguitar timidity -y
    }

    install_zsh()
    {
        printf "\n[*] Instalando o ZSH"
        printf "\n[*] Instalando o ZSH" >> $log_instala

        apt install zsh zsh-common -y
    }

    install_docker()
    {
    	printf "\n[*] Instalando o Docker"
        printf "\n[*] Instalando o Docker" >> $log_instala

        curl -fsSL https://get.docker.com/ | sh            
    }

    install_sublime()
    {
        printf "\n[*] Instalando o Sublime"
        printf "\n[*] Instalando o Sublime" >> $log_instala

        # instalando
        snap install sublime-text --classic

        # atualizando
        snap refresh sublime-text --classic
    }

    install_firmware()
    {
        printf "\n[*] Instalando os firmware's non-free"        
        printf "\n[*] Instalando os firmware's non-free" >> $log_instala

        if [[ $v_hostname = 'notebook' ]]; then   
            apt install xserver-xorg-input-synaptics \
                firmware-brcm80211 -y      
        fi

        apt install firmware-linux firmware-linux-nonfree -y
    }     

    install_python()
    {        
        printf "\n[*] Instalando o Pip" 
        printf "\n[*] Instalando o Pip" >> $log_instala

        apt install python3 python-pip -y

    	if [[ $v_hostname = 'desktop' ]]; then
            pip install krpc
        fi           
    }

    install_youtubedl()
    {
        printf "\n[*] Instalando o Youtube-DL\n" 
        printf "\n[*] Instalando o Youtube-DL\n" >> $log_instala

        ## instalando 
        pip install youtube-dl 

        ## atualizando
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
        printf "\n[*] Instalando o Transmission"
        printf "\n[*] Instalando o Transmission" >> $log_instala

        apt install transmission-gtk -y
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

        apt install deborphan -y
    }

    install_locate()
    {
        printf "\n[*] Instalando Locate"
        printf "\n[*] Instalando Locate" >> $log_instala

    	apt install locate -y
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
    	printf "\n[*] Instalando o Notify-send"
        printf "\n[*] Instalando o Notify-send" >> $log_instala

        apt install notify-osd -y
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
    	printf "\n[*] Instalando o Nautilus"
        printf "\n[*] Instalando o Nautilus" >> $log_instala

        apt install nautilus -y
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
            dpkg -i base/packages/google_earth/*.deb  

            # corrigindo problemas de dependencias
            apt --fix-broken install -ydpkg -i base/packages/mega/*.deb

            dpkg -i base/packages/google_earth/*.deb  
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

    install_realtek()
    {
        printf "\n[*] Instalando o Realtek"
        printf "\n[*] Instalando o Realtek" >> $log_instala

        apt install firmware-brcm80211 -y
    }

    install_desmune()
    {
        printf "\n[*] Instalando o Desmune"
        printf "\n[*] Instalando o Desmune" >> $log_instala

        apt install desmume -y
    }

    install_curl()
    {
        printf "\n[*] Instalando o Curl"
        printf "\n[*] Instalando o Curl" >> $log_instala

        apt install curl -y
    }

    install_cpufrequtils()
    {
        printf "\n[*] Instalando o CPUfreqUtils"
        printf "\n[*] Instalando o CPUfreqUtils" >> $log_instala

        apt install cpufrequtils -y

        if [[ $v_hostname = 'notebook' ]]; then                        
            ## uso CONSERVADOR para economizar energia
            cpufreq-set -g conservative
        elif [[ $v_hostname = 'desktop' ]]; then      
            ## uso ESCALAR
            cpufreq-set -g ondemand
        else
            printf "\n[-] ERRO corrige!"
            printf "\n[-] ERRO corrige!" >> $log_corrige
        fi
    }

    install_bluetooth()
    {
        printf "\n[*] Instalando o Bluetooth"
        printf "\n[*] Instalando o Bluetooth" >> $log_instala

        apt install pulseaudio pulseaudio-module-bluetooth \
                    pavucontrol bluez-firmware \
                    bluetooth blueman bluez \
                    bluez-tools rfkill -y
    }

    install_mpsyoutube()
    {

    	printf "\n[*] Instalando o MPS-Youtube"
    	printf "\n[*] Instalando o MPS-Youtube" >> $log_instala

    	pip3 install mps-youtube --upgrade
    }

    install_lynis()
    {
        printf "\n[*] Instalando o Lynis"
        printf "\n[*] Instalando o Lynis" >> $log_instala

        apt-get install lynis
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

    remove_nextcloud()
    {
        printf "\n[*] Removendo o Nextcloud"
        printf "\n[*] Removendo o Nextcloud" >> $log_remove

        apt purge nextcloud-desktop* -y
    }

    ## LAST_REMOVE

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_keycheck()
{
    if [[ $file_check_on == "1" ]]; then    
    	# verificando se arquivo existe
    	check_arq=$(cat $file_check >> /dev/null)

    	if [[ $check_arq != "0" ]]; then
    		touch $file_check
    	fi

    	check_func=$(grep "AUTOCONFIG" $file_check | tail -1 | sed -e "s;AUTOCONFIG:;;g")

        if [[ "$key" != "$check_func" ]]; then
            echo "AUTOCONFIG:"$key >> $file_check   
        else
            printf "Esta com TOC amigo, voce ja rodou o script agora a pouco!! $check_func \n"
            
            sleep $aguarda
        fi
    fi
}

func_atualiza()
{    
    notify-send -u normal "Atualizando sistema" -t 10000

    update
    upgrade
}

func_corrige()
{
    notify-send -u normal "Corrigindo sistema" -t 10000

    # nao trocar ordem das funcoes
    apt_clean        
    pacotes_quebrados      
    atualiza_db   
    update
}

func_config()
{
    notify-send -u normal "Configurando o sistema" -t 10000	

    swap
    autologin
    config_ntp  
    icones_temas
    arquivo_hosts
    prelink_preload_deborphan
}

func_limpa()
{
    notify-send -u normal "Limpando sistema" -t 10000

    pacotes_orfaos
    funcao_chkrootkit
    funcao_lynis
}

func_instala()
{
    notify-send -u normal "Instalando programas no sistema" -t 10000	

	install_tor

	install_codecs
	install_vlc
	install_audacious 
	install_simple_screen_recorder   
	
    install_stellarium
    install_libreoffice
    install_transmission   

	install_xfce4  
    install_nautilus
    install_openssh    
    install_redshift
    install_ristretto    
    install_neofetch
    install_lm-sensors    
    install_tlp	   

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
    install_curl
    install_cpufrequtils 

    install_aircrack  
    install_wavemon
    install_lynis

    install_mpsyoutube
   	install_wine
    install_playonlinux  
    install_gimp    

    install_pulseeffects                
    install_googleearth          

    if [[ $distro = "Debian" ]]; then 
        install_mega
        install_dropbox    
    fi

	if [[ $v_hostname = 'notebook' ]]; then		
        install_cheese

	    install_reaver          
        install_ibam
        
        install_desmune
        install_realtek  

        install_bluetooth
	elif [[ $v_hostname = 'desktop' ]]; then     
        install_gimp    
        install_tuxguitar            
        install_sweethome3d
		install_audacity

        install_nvidia      
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
	remove_chromium-bsu
	remove_owncloud      
    remove_keyring
    remove_zathura
    remove_synaptic
    remove_youtubedl
    remove_simplescan
    remove_gxine
    remove_easytag
    remove_nextcloud
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

    if [[ $vetor_leitura = "atualiza" ]]; then
        for (( i = 0; i <= ${#atualiza[@]}; i++ )); do
            if [[ $leitura_subacao = ${atualiza[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_atualiza_ajuda        
        exit 0

    elif [[ $vetor_leitura = "corrige" ]]; then
        for (( i = 0; i <= ${#corrige[@]}; i++ )); do
            if [[ $leitura_subacao = ${corrige[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_corrige_ajuda
        exit 0

    elif [[ $vetor_leitura = "config" ]]; then
        for (( i = 0; i <= ${#config[@]}; i++ )); do
            if [[ $leitura_subacao = ${config[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_config_ajuda
        exit 0

    elif [[ $vetor_leitura = "limpa" ]]; then
        for (( i = 0; i <= ${#limpa[@]}; i++ )); do
            if [[ $leitura_subacao = ${limpa[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_limpa_ajuda            
        exit 0

    elif [[ $vetor_leitura = "instala" ]]; then
        for (( i = 0; i <= ${#instala[@]}; i++ )); do
            if [[ $leitura_subacao = ${instala[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_instala_ajuda
        exit 0

    elif [[ $vetor_leitura = "instala_outros" ]]; then
        for (( i = 0; i <= ${#instala_outros[@]}; i++ )); do
            if [[ $leitura_subacao = ${instala_outros[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_instala_outros_ajuda
        exit 0

    elif [[ $vetor_leitura = "remove" ]]; then
        for (( i = 0; i <= ${#remove[@]}; i++ )); do
            if [[ $leitura_subacao = ${remove[i]} ]]; then
                $leitura_subacao            
            fi            
        done

        func_vetor_remove_ajuda
        exit 0

    elif [[ $@ = "ajuda" ]]; then
        func_vetor_instala_ajuda
        func_vetor_corrige_ajuda
        func_vetor_config_ajuda
        func_vetor_limpa_ajuda
        func_vetor_instala_ajuda
        func_vetor_instala_outros_ajuda
        func_vetor_remove_ajuda
    fi
}

version()
{
	echo "Versão: $versao"
    echo "Autor: $autor"
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
                    TRUE atualiza \
                    FALSE corrige \
                    FALSE config \
                    FALSE limpa \
                    FALSE instala \
                    FALSE remove \
        ) ; f_verifica        

        for (( i = 0; i <= ${#vetor[@]}; i++ )); do  
            if [[ ${vetor[$i]} = $escolha ]]; then   
                if [[ $escolha = "atualiza" ]]; then                        	
                    acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${atualiza[@]}") ; f_verifica
                elif [[ $escolha = "corrige" ]]; then
                    acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${corrige[@]}")  ; f_verifica
                elif [[ $escolha = "config" ]]; then
                    acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${config[@]}")   ; f_verifica
                elif [[ $escolha = "limpa" ]]; then
                	acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${limpa[@]}")    ; f_verifica
                elif [[ $escolha = "instala" ]]; then
                	acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${instala[@]}")  ; f_verifica
            	elif [[ $escolha = "remove" ]]; then
                	acao=$(zenity --entry \
                                   --title "Vetor $escolha" \
                                   --text "Escolha:" " ${remove[@]}")   ; f_verifica
            	else
                	echo "ERRO"
                fi        
            fi

            ## executando vetor escolhido
            $acao
        done        
    else
        echo "SAIU AQUI!"
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

    escolha_vetor=$1        # vetor
    help_vetor=$2           # ajuda
    vetor_leitura=$3        # acao
    leitura_subacao=$4      # sub_acao

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
            nvidia) install_nvidia;;
    		versao) version;;
            vetor) func_vetor;;
    		interface_d) func_interface_dialog;;
            interface_z) func_interface_zenity;;
            manutencao) func_manutencao;;
            *) echo $mensagem_erro && exit 1
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
