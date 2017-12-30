#!/bin/bash
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#   FONTES DE PESQUISA  #
# # # # # # # # # # # # #
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# por oliveiradeflavio(Flávio Oliveira)
# 	<github.com/oliveiradeflavio/scripts-linux>
#
# por gmanson(Gabriel Manson)
# 	<github.com/gmasson/welcome-debian>
#
# por Fabiano de Oliveira e Souza
# 	<vivaolinux.com.br/script/Mantendo-hora-do-servidor-atualizada-com-NTP>
#
# por Lucas Novo Silva
# 	<vivaolinux.com.br/dica/Erro-de-apt-get-update-no-Ubuntu-1604-Xenial-problemas-nos-repositorios-RESOLVIDO>
#
# por Ricardo Ferreira
# 	<linuxdescomplicado.com.br/2014/11/saiba-como-acessar-uma-maquina-ubuntu.html>
#
# por Dionatan Simioni
# 	<diolinux.com.br/2016/12/drivers-mesa-ubuntu-ppa-update.html>
# 	<diolinux.com.br/2014/08/versao-nova-kdenlive-ppa.html>
#   <diolinux.com.br/2015/09/como-instalar-drivers-de-video-no-ubuntu-linux.html>
#
# por Cláudio Novais
#   <ubuntued.info/ganhe-espaco-removendo-kernels-antigos>
#
# por 
#	<fosspost.org/tutorials/how-to-customize-firefox-57-user-interface>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#										                                      #
#	If I have seen further it is by standing on the shoulders of Giants.	  #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)		      #
#							~Isaac Newton		                              #
#										                                      #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # versão do script:           [2.0.285.1.2.0]   #
# # data de criação do script:    [28/09/17]      #
# # ultima ediçao realizada:      [30/12/17]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
#
# 	b = erros na execução;
#
# 	c = interações com o script;
#
# 	d = correções necessárias;
#				- I     - [NOTEBOOK/DEBIAN] - Verificar funcao debian na situacao hostname(notebook)
#
# 	e = pendencias
#               - I     - [FIRMWARE WIFI] - Criar funcao para instalar automaticamente o driver wi-fi para o modelo do computador(Notebook HP Pavilion G4)
#                           - Criar possivel verificação
#                           - Dmidecode | grep "Reference Designation: Broadcom"
#
#               - II    - [WHICH PROGRAMAS] - Adicionar verificação de alguns programas, antes da instalação.
#                           - Icones-macbuntu
#
# 	f = desenvolver
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # Mensagens de Status
#       [+] - Ação realizada;
#       [*] - Processamento;
#       [-] - Não executado;
#       [!] - Mensagem de aviso;
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # Script testado em
#	- Xubuntu 16.04
#       - Debian 9
#
# # Compativel com
#       - Ubuntu
#       - Debian 9
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # VARIAVEIS DE AMBIENTE
# Criando variavel com localização da raiz do usuario
    pasta_home="/home/lenonr"           # personalizavel

# verificando distro
    distro=$(lsb_release -i | cut -f2)  # Ubuntu ou Debian

#capturando hostname da maquina
    hostname=$(hostname)                # Funções configuradas a partir de valores -desktop ou notebook-

# # # # # CRIANDO FUNÇÕES PARA EXECUÇÃO
#
# ATUALIZAR
# CORRIGIR
# LIMPAR
# INSTALAR
# REMOVER
# SAIR
#
# # # # # # # # # #
#
# criando funcoes para serem executadas como parametros
func_help()
{
    clear
    clear
    printf "############################################################################\n"
    printf "
   / \ | | | |_   _/ _ \ / ___/ _ \| \ | |  ___|_ _/ ___|   \ \   / / || |
  / _ \| | | | | || | | | |  | | | |  \| | |_   | | |  _ ____\ \ / /| || |_
 / ___ \ |_| | | || |_| | |__| |_| | |\  |  _|  | | |_| |_____\ V / |__   _|
/_/   \_\___/  |_| \___/ \____\___/|_| \_|_|   |___\____|      \_/     |_|
    "
    printf "\n"
    printf "############################################################################

    Bem vindo ao script de automação de tarefas no Linux ele poderá realizar

        - Atualização do sistema,
        - Correção de erros,
        - Limpeza geral do sistema,
        - Instalação de programas,
        - Remoção de programas desnecessários,

    Exemplos:
        - Lendo instruções de funcionamento:
            ~ v4.sh

        - Atualizando o Sistema:
            ~ v4.sh atualiza

        - Corrigindo o Sistema:
            ~ v4.sh corrige

        - Limpando o Sistema:
            ~ v4.sh limpa

        - Instalando programas:
            ~ v4.sh instala

        - Instalando outros programas:
            ~ v4.sh instala_outros

        - Removendo programas:
            ~ v4.sh remove

        - Visualizando o menu de ações:
            ~ v4.sh menu

        - Após a maquina ser formatada(apenas as funções automáticas)
            ~ v4.sh formatado

        - Para executar todas as funções(semi-automático)
            ~ v4.sh todas

    **      SCRIPT TESTADO NO UBUNTU 16.04 | DEBIAN 8 | DEBIAN 9    **

############################################################################
"
}

#
# # ATUALIZA SISTEMA
    update()
    {
        #atualizando lista de repositorios
        printf "\n"
        printf "[+] Atualizando lista de repositorios do sistema"
        printf "\n"

        apt update

#         # verificando distribuição
#         if [ "$distro" == "Ubuntu" ]; then
#                 printf "\n"
#
# 	        #atualizando repositorio e seus dependencias
#         	printf "[+] Atualizando lista de programas e suas dependências \n"
#
# 	        auto-apt update
#         fi
    }

    upgrade()
    {
        # verificando distribuição
        if [ $distro == "Ubuntu" ]; then
                printf "\n"
        	#atualizando lista de programas do sistema
	        printf "[+] Atualizando lista de programas do sistema \n"

	        apt upgrade -y

	        #atualizando repositorio local
	        printf "\n"
	        printf "[+] Atualizando repositório local dos programas \n"

	        auto-apt updatedb
	else
        	#atualizando lista de programas do sistema
        	printf "\n"
	        printf "[+] Atualizando lista de programas do sistema \n"

	        apt upgrade -y
	        apt dist-upgrade -y

	fi
    }

# # # # # # # # # #
# # CORRIGE SISTEMA
    apt_check()
    {
        #verificando lista do apt
        printf "\n"
        printf "[+] Verificando lista do apt"
        printf "\n"

        apt-get check -y
    }

    apt_install()
    {
        #instalando possiveis dependencias
        printf "\n"
        printf "[+] Instalando dependências pendentes"
        printf "\n"

        apt-get -f install -y
    }

    apt_remove()
    {
        #removendo possiveis dependencias
        printf "\n"
        printf "[+] Removendo possíveis dependências obsoletas"
        printf "\n"

        apt-get -f remove -y
        apt-get autoremove -y
    }

    apt_clean()
    {
        #limpando lista arquivos sobressalentes
        printf "\n"
        printf "[+] Limpando arquivos sobressalentes"
        printf "\n"

        apt-get clean -y
    }

    apt_auto()
    {
        #corrigindo problemas de dependencias
        printf "\n"
        printf "[+] Corrigindo problemas de dependências"
        printf "\n"

        apt-get install auto-apt -y
    }

    apt_update_local()
    {
        #corrigindo repositorio local de dependencias automaticamente
        printf "\n"
        printf "[+] Corrigindo repositório local de dependências automaticamente"
        printf "\n"

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
                printf "[!] Isso porque já foi otimizado anteriormente! \n"
        fi
        printf "\n"
    }

    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas

        #instalando prelink, preload, deborphan para um melhor performance do sistema
        printf "\n"
        printf "[*] Instalando Prelink, Preload e Deborphan \n"
#         printf "------------------- \n"

        apt install prelink preload -y 1>/dev/null 2>/dev/stdout
        apt-get install deborphan -y

        echo "[*] Configurando Deborphan... \n"
        deborphan | xargs sudo apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #configurando o prelink e o preload
        echo "[*] Configurando Prelink e Preload... "
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)

        printf "[*] Ativando o PRELINK \n"
#         printf "\n"
#         printf "------------------- \n"
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
        printf "[+] Corrigindo pacotes quebrados"
        printf "\n"

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
        printf "[+] Instalando pacotes de fontes"
        printf "\n"

        #baixando pacote
        wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb

        #instalando pacote
        dpkg -i ttf-mscorefonts-installer_3.6_all.deb

        #removendo pacote
        rm -f ttf-mscorefonts-installer_3.6_all.deb
        rm -f ttf-mscorefonts-installer_3.6_all.deb.1
    }

    install_ntp()
    {
        printf "\n"
        printf "[+] Instalando o NTP"
        printf "\n"

        #instalando software necessario
        apt install ntp ntpdate -y
    }

    config_ntp()
    {
        printf "\n"
        printf "[+] Configurando o NTP \n"

        #parando o serviço NTP para realizar as configuraçoes necessarias
        printf "\n"
        printf "[*] Parando serviço NTP para realizaçao das configuraçoes necessarias \n"
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
#         rm /var/crash/*

        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport
    }

    lightdm()
    {
        printf "\n"
        printf "[+] Iniciando sessão automaticamente \n"

        cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
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
        if [ $distro == "Ubuntu" ]; then
            printf "\n"
            printf "[+] Alterando lista de repositórios padrão \n"

            cat base/ubuntu/sources.list > /etc/apt/sources.list
        elif [ $distro == "Debian" ]; then
            printf "\n"
            printf "[+] Alterando lista de repositórios padrão \n"

            cat base/debian/sources.list > /etc/apt/sources.list
        else
            printf "[!] Não realizou nada, distro não identificada! \n"
        fi
    }

    arquivo_hosts()
    {
        #verificando variavel
        if [[ $hostname == 'desktop' ]]; then
            printf "\n"
            printf "[+] Alterando arquivo Hosts \n\n"

            cat base/ubuntu/hosts > /etc/hosts
        fi
    }

    chaveiro()
    {
        printf "\n"
        printf "[+] Removendo o chaveiro da sessão \n\n"

        sudo apt-get remove gnome-keyring -y
    }

    install_xclip()
    {
        printf "\n"
        printf "[+] Instalando Xclip \n\n"

        apt install xclip -y
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

        # apt-get remove $(deborphan) -y ; apt-get autoremove -y
        apt-get remove $(deborphan) -y 
        apt-get autoremove -y
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

		# VERIFICAR MANUALMENTE - HABILITAR FUNCAO FIREFOX 
        # configurando interface
        # cd pasta_home/.mozilla/firefox/*.default
        # mkdir chrome; cd chrome; touch userChrome.css
        # cd pasta_home/Github/dev_xfce/Auto_Config
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
        printf "[+] Verificando se existe Spotify instalado \n"

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
            apt install spotify-client -y --allow-unauthenticated
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

     # variavel de verificação
        var_gimp=$(which gimp)

        if [[ ! -e $var_gimp ]]; then
            printf "\n"
            printf "[+] Instalando o Gimp \n"
            apt install gimp -y

            printf "\n"
            printf "[+] Instalando o PhotoGimp \n"

#             printf "[*] Removendo arquivo existente \n"
#             rm -r $pasta_home/.gimp-2.8

            # printf "[*] Inserindo novo arquivo \n"
            # cp -r base/.gimp-2.8/ $pasta_home

            printf "[+] Novo arquivo adicionado! \n"
        else
            printf "\n"
            printf "[+] Gimp já está instalado na sua máquina! \n"
        fi
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

    install_xfpanel-switch()
    {
    	# variavel de verificação
        var_xfpanel=$(which xfpanel-switch)

        if [[ ! -e $var_xfpanel ]]; then
    		printf "\n"
        	printf "[+] Instalando Xfpanel-switch \n"

	        wget mirrors.kernel.org/ubuntu/pool/universe/x/xfpanel-switch/xfpanel-switch_1.0.4-0ubuntu1_all.deb

	        dpkg -i xfpanel-switch_1.0.4-0ubuntu1_all.deb

	        # corrigindo problemas de dependencias
	        apt --fix-broken install -y

	        dpkg -i xfpanel-switch_1.0.4-0ubuntu1_all.deb

	    else
			printf "[+] Xfpanel-switch ja esta instalado \n"	    	
		fi
    }

    wine()
    {
    # variavel de verificação
        var_wine=$(which wine)

        if [[ ! -e $var_wine ]]; then
            printf "\n"
            printf "[+] Instalando o Wine \n"

            #adicionado o repositorio
            add-apt-repository ppa:ubuntu-wine/ppa -y

            #chamando funcao já criada
            update

            apt install wine -y
        else
            printf "\n"
            printf "[+] Wine já está instalado na sua máquina! \n"
        fi
    }

    playonlinux()
    {
        printf "\n"
        printf "[+] Instalando o PlayonLinux \n"

        apt install playonlinux -y
    }

    redshift()
    {
        printf "\n"
        printf "[+] Instalando o Redshift \n"

        apt install redshift gtk-redshift -y

        # criando link
        cat base/redshift.conf > pasta_home/.config/redshift.conf 
    }

    libreoffice()
    {
        # se habilitar verificação, novas atualizações não serão instaladas.
#         # variavel de verificação
#         var_libreoffice=$(which libreoffice)
#
#         if [[ ! -e $var_libreoffice ]]; then
            printf "\n"
            printf "[+] Instalando o Libreoffice \n"

            #adicionando ppa
            add-apt-repository ppa:libreoffice/ppa -y

            #chamando funcao já definida
            update

            #instalando libreoffice
            apt-get install libreoffice libreoffice-style-breeze -y
#         else
#             printf "[+] Libreoffice já está instalado! \n"
#         fi
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
        apt install aspell aspell-pt-br -y
    }

    kstars()
    {
        printf "\n"
        printf "[+] Instalando o Kstars \n"

        apt install kstars* -y
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
        # variavel de verificação
        var_tor=$(which tor)

        if [[ ! -e $var_tor ]]; then
            printf "\n"
            printf "[+] Instalando o Tor \n"

            #adicionando repositorio
            add-apt-repository ppa:webupd8team/tor-browser -y

            #atualizando lista de pacotes
            update

            #instalando tor
            apt-get install tor tor-browser -y
        else
            printf "\n"
            printf "[+] Tor já está instalado! \n" 
        fi           
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

        if [[ ! -e $var_plank ]]; then
            printf "\n"
            printf "[+] Instalando o Plank Dock \n"


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

        if [[ ! -e $var_nautilus ]]; then
            printf "\n"
            printf "[+] Instalando o Nautilus \n"

            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
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

        apt install gnome-disk-utility -y
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

        apt install audacity -y
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
        # variavel de verificação
        var_mega=$(which megasync)

        if [[ ! -e $var_mega ]]; then        
            printf "\n"
            printf "[+] Instalando o MEGA \n"
            
            # instalando mega
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/mega/*.deb

            # corrigindo dependencias
            apt install -fy

            # instalando mega
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/mega/*.deb
        else
            printf "[+] MEGA Sync já está instalado! \n"
        fi
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

    nvidia()
    {
        # variavel de verificação
        var_nvidia=$(which nvidia-settings)

        if [[ ! -e $var_nvidia ]]; then
            printf "\n"
            printf "[+] Instalando o driver da Placa Nvidia \n"

            apt-add-repository ppa:graphics-drivers/ppa -y
            apt-add-repository ppa:ubuntu-x-swat/x-updates -y
            apt-add-repository ppa:xorg-edgers/ppa -y
            update

            apt install nvidia-current nvidia-settings -y

            printf "\n"
            printf "[+] Arquivo de configuração Nvidia \n"

#             cat base/ubuntu/.nvidia-settings-rc > $past_home/.nvidia-settings-rc
        fi

        printf "[+] Nvidia já está instalado no sistema! \n"
    }

    icones()
    {
        printf "\n"
        printf "[+] Gerando lista dos arquivos \n"

        # criando variaveis
        # # variaveis de entrada
        input_icons='/usr/share/icons/'
        input_themes='/usr/share/themes/'

        # # variaveis de saida
        output_icons='/home/lenonr/MEGA/Outros/Themes_Icons/icons/*'
        output_themes='/home/lenonr/MEGA/Outros/Themes_Icons/themes/*'

        # # variaveis de verificao
        caminho='/home/lenonr/MEGA/Outros/Themes_Icons'
        verifica='cd $caminho; echo $?'

        # realizando verificação na pasta de origem
        if [[ ! -e $caminho ]]; then
            # mostrando mensagem de erro
            printf "[-] Caminho não encontrado!! \n"
            printf "[-] Verifique a pasta de origem!! \n"
            exit 127
        else
            # executando backup
            printf "[+] Executando backup! \n"
            printf "[*] Copiando temas para pasta de destino \n"
            cp -r $input_themes $output_themes

            printf "[*] Copiando icones para pasta de destino \n"
            cp -r $input_icons $output_icons
        fi
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

        # criando verificação para instalar o virtualbox
        if [[ ! -e $var_virtualbox ]]; then
            printf "\n"
            printf "[*] Realizando download \n"
            wget -c download.virtualbox.org/virtualbox/5.1.28/virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb

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

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        var_pulseeffects=$(which pulseeffects)

        if [[ ! -e $var_pulseeffects ]]; then

            printf " \n"
            printf "[+] Instalando o Pulse Effects \n"
            #instalando mega
#             dpkg -i base/ubuntu/pulseeffects/*.deb
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/pulseeffects/*.deb

            printf "[*] Resolvendo dependencias \n"
            apt install -fy

            printf "[*] Instalando o Pulse Effects \n"
#             dpkg -i base/ubuntu/pulseeffects/*.deb
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/pulseeffects/*.deb

            printf "[+] Será necessário voce ativar o Pulse Effects na inicialização do sistema \n"
            sleep 5s
        else
            printf "\n"
            printf "[+] Pulse Effects já está instalado"
            printf "\n"
        fi
    }
    
    install_terminator()
    {
        printf " \n"
        printf "[+] Instalando o Terminator \n"
        
        apt install terminator -y
    }

    install_aircrack()
    {
        printf " \n"
        printf "[+] Instalando o Aircrack-ng \n"

        apt install aircrack-ng -y
    }

# # # # # # # # # #
# # PROGRAMAS NÃO ESSENCIAIS

    apache()
    {
        printf "\n"
        printf "[+] Instalando o Apache \n"

        apt install apache2 -y
    }

    install_mysql()
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

    tuxguitar()
    {
        # variavel de verificação
#         var_tuxguitar=$(which java)

        # criando verificação para instalar o tuxguitar
#         if [[ ! -e $var_tuxguitar ]]; then
            printf "\n"
#             printf "[+] Instalando Tux Guitar \n"

#             printf "[*] Realizando download do pacote \n"
#             wget -c https://downloads.sourceforge.net/project/tuxguitar/TuxGuitar/TuxGuitar-1.4/tuxguitar-1.4-linux-x86_64.deb

            printf "[*] Instalando pacote \n"
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/tuxguitar/*.deb
#             dpkg -i tuxguitar-1.4-linux-x86_64.deb

            printf "[*] Resolvendo dependências \n"
            apt install -fy

            printf "[*] Instalando pacote \n"
            dpkg -i /home/lenonr/MEGA/LifeStyle/Linux/Config/deb/tuxguitar/*.deb
#             dpkg -i tuxguitar-1.4-linux-x86_64.deb

#             printf "[*] Removendo pacote"
#             rm tuxguitar-1.4-linux-x86_64.deb
#         else
#             printf "[+] TuxGuitar já está instalado \n"
#         fi
    }

    muse_score()
    {
            printf "\n"
            printf "[+] Instalando Muse Score \n"

            apt install musescore -y
            snap install musescore -y
    }

    install_zsh()
    {
            printf "\n"
            printf "[+] Instalando o ZSH \n"
            apt install zsh -y

            printf "\n [*] Modificando bash padrao para zsh"
            chsh -s /usr/bin/zsh

            printf "\n [+] Seu interpretador de comandos foi alterado para o ZSH!!"
    }

    install_docker()
    {
        # variavel de verificação
        var_docker=$(which docker)

        # criando verificação para instalar o docker
        if [[ ! -e $var_docker ]]; then

            printf "\n"
            printf "[+] Instalando o Docker \n"

            curl -fsSL https://get.docker.com/ | sh
        else
            printf "\n"
            printf "[+] O Docker já está instalado no seu sistema. \n"
        fi

    }

    install_sublime()
    {
        printf "\n"
        printf "[+] Instalando o Sublime \n"

        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - 
        apt install apt-transport-https -y 
        echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
        
        update  
        
        apt install sublime-text -y ;
    }

# # # # # # # # # #

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_atualiza()
{
    clear
    update
    upgrade
}

func_corrige()
{
    clear

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
        config_ntp
        apport
        repositorios_padrao
        log_sudo
        lightdm
        arquivo_hosts
        chaveiro
        install_xclip
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
        config_ntp
        apport
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
        config_ntp
        apport
        repositorios_padrao
        log_sudo
    fi

    # realizando atualização
    update
}

func_limpa()
{
    clear
    pacotes_orfaos
    funcao_chkrootkit
    localpurge
}

func_instala()
{
    clear

    # # verificando nome para máquina para executar funções especificas
    #capturando hostname da maquina
    hostname=$(hostname)

    if [[ $hostname == 'notebook' ]]; then
#               PERSONALIZAÇÃO
        icones_mac
        codecs
        xfce4
        install_xfpanel-switch
        redshift
        gnome_terminal
        install_ntp
        plank
        gnome_system_monitor
        nautilus
        gparted
        tlp
        screenfetch
        gnome_disk_utility
        gnome_system_monitor
        brightside
#                 figlet
        hardinfo

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
#                 kstars

#               MULTIMIDIA
        spotify
        clementine
        vlc
#                 kdenlive
#                 sweethome3d
        audacity
#                 mcomix
#                 simple_screen_recorder
        calibre

#               DESENVOLVIMENTO
        kate
        install_git
        install_sublime

#               IMAGEM
        funcao_gimp

#               OUTROS
        firewall_basic
        openssh
        install_chkrootkit
        reaver
        sensors
        install_nmap
        htop
        install_tree
        install_aircrack
        install_terminator

#               OFFICE
        libreoffice
        texmaker

    else
#               PERSONALIZAÇÃO
        nvidia
        icones_mac
        codecs
        xfce4
        redshift
        gnome_terminal
        install_ntp
        plank
        gnome_system_monitor
        nautilus
        gparted
        tlp
        screenfetch
        gnome_disk_utility
        gnome_system_monitor
        brightside
        figlet
        hardinfo
#                 icones

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
        kstars

#               MULTIMIDIA
        spotify
        clementine
        vlc
        kdenlive
        sweethome3d
        audacity
#                 mcomix
        simple_screen_recorder
#                 calibre

#               MUSICA
        tuxguitar
        muse_score

#               DESENVOLVIMENTO
        kate
        install_git
        install_terminator
        install_sublime

#               IMAGEM
        funcao_gimp

#               OUTROS
        firewall_basic
        openssh
        install_chkrootkit
        reaver
        sensors
        install_nmap
        htop
        install_tree

#               OFFICE
        libreoffice
        texmaker
    fi
}

func_instala_outros()
{
    # desenvolvimento
    apache
    install_mysql
    phpmyadmin
    install_zsh
    install_docker  

    wireshark

    # personalização
    install_pulseeffects
    #mega

    # teclado
    ibus

    # verificando computador
    if [[ $hostname == 'desktop' ]]; then
        # outros
        virtualbox

        # jogos
        steam
    fi
}

func_remove()
{
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
        printf "[+] Removendo a Steam \n"

        apt purge steam* -y        


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
}

func_formatado()
{
    # atualizando sistema
    func_atualiza

    # instalando programas
    func_instala

    # instala outros programas
    func_instala_outros
    
    # removendo programas pré-instalados, desnecessários
    func_remove

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa
    
    # desligando sistema
    halt -p
}

func_todas()
{
# atualizando sistema
    func_atualiza

    # instalando programas
    func_instala

    # necessario interação com o usuario, se ativa não irá fazer tudo automatico
    func_instala_outros

    # removendo programas pré-instalados, desnecessários
    func_remove

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa
}

##REALIZANDO VERIFICAÇÕES
    ######VERIFICANDO USUARIO ROOT
    if [[ `id -u` -ne 0 ]]; then
        clear
        printf "############################################################################\n"
        printf "
   / \ | | | |_   _/ _ \ / ___/ _ \| \ | |  ___|_ _/ ___|   \ \   / / || |
  / _ \| | | | | || | | | |  | | | |  \| | |_   | | |  _ ____\ \ / /| || |_
 / ___ \ |_| | | || |_| | |__| |_| | |\  |  _|  | | |_| |_____\ V / |__   _|
/_/   \_\___/  |_| \___/ \____\___/|_| \_|_|   |___\____|      \_/     |_|
    "
    printf "\n"
        printf "############################################################################ \n"
        printf "[!] O script para funcionar, precisa estar sendo executado como root! \n"
        printf "[!] Favor, logar na conta root e executar o script novamente. \n"
        printf "############################################################################ \n"
    exit
    fi

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#criando função global, que inicia todas as outras
auto_config_ubuntu()
{
    clear
    ##CHAMANDOS FUNCOES
    #
    case $escolhaauto_config in

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### ATUALIZA SISTEMA
        1) echo
            func_atualiza
            auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### CORRIGE SISTEMA
        2) echo
            func_corrige
            auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### LIMPA SISTEMA
        3) echo
            func_limpa
            auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### INSTALA PROGRAMAS
        4) echo
            func_instala
            auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### PROGRAMAS NÃO ESSENCIAIS
        5) echo
            func_instala_outros
            auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### REMOVES PROGRAMAS
        6) echo
            func_remove
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
            printf "Alternativa incorreta!! \n"
            sleep 1s
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
    ###### ATUALIZA SISTEMA
        1) printf
                func_atualiza

                auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### CORRINDO PROBLEMAS
        2) printf
                apt_install
                fonts
                config_ntp
                repositorios_padrao
                arquivo_hosts
                chaveiro
                install_xclip

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
				xfce4
				install_xfpanel-switch
                nautilus
                redshift
                plank
                install_git
                openssh
#                 icones
                brightside

                install_sudo
                install_nmap
                install_docker

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
                install_mysql
                phpmyadmin

                # teclado
                ibus

                # desenvolvimento
                install_zsh

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
            sleep 1s
            menu
            exit
        ;;

    esac

    printf "TAREFAS FINALIZADAS, SAINDO..\n"
    sleep 5s
    clear
}


auto_config()
{
    clear

    # chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]

    printf "
                AUTOCONFIG - V4
                \n"
    echo "-------------------------------------------------"
#     echo "Digite 0 para verificar dados do sistema"
    echo "Digite 1 para atualizar o sistema,"
    echo "Digite 2 para corrigir possíveis erros,"
    echo "Digite 3 para realizar uma limpeza,"
    echo "Digite 4 para instalar alguns programas,"
    echo "Digite 5 para instalar programas não essenciais,"
    echo "Digite 6 para remover alguns programas,"
    echo "Digite 7 para sair do script,"
    echo "-------------------------------------------------"
    read -n1 -p "
Número da ação:" escolhaauto_config

    #executando ações para a distribuição Ubuntu
    if [ $distro == "Ubuntu" ]; then
        clear
        auto_config_ubuntu
    #executando ações para a distribuição Fedora
    elif [ $distro == "Debian" ]; then
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

    # executando menu
    auto_config

}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# INICIANDO SCRIPT
# menu

if [ $# -eq 0 ]; then
#         auto_config
    func_help
fi

# verificando o que foi digitado
case $1 in
    menu) auto_config;;

    atualiza) func_atualiza;;
    corrige) func_corrige;;
    limpa) func_limpa;;
    instala) func_instala;;
    instala_outros) func_instala_outros;;
    remove) func_remove;;

    formatado) func_formatado;;

	todas) func_todas;;
esac

#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #