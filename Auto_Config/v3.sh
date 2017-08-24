#!/bin/bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
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
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:           [0.0.8.2.0.6]     #
# # data de criação do script:    [23/08/17]      #
# # ultima ediçao realizada:      [25/08/17]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script;
# 	d = correções necessárias;
#               - I - [FUNCAO_DPKG] - Loop detectado na execução dessa função
#               - II - [ARQUIVO LOG] - Verificar criação e manutenção do arquivo de log.txt
# 	e = pendencias    
# 	f = desenvolver
# 		-I      - [INTERFACE GRAFICA] - Criar uma interface gráfica, possibilitando ao usuário selecionar as ações que o usuário deseja realizar, selecionando apenas com o espaço;
#                     #dialog/xdialog
# 
#		-II     - [FUNCAO CANCELA PROCESSAMENTO] - Possibilitar ao usuário o cancelamento das ações selecionadas, dentro de um tempo pré-determinado(10 seg.);
# 
#               -III     - [FUNCAO GERAL] - Facilitar a instalação dos programas, com a opção de instalar todos disponiveis no script;
#               -IV      - [FUNCAO INSTALA TODOS PROGRAMAS] - Implementar uma funcao chamada padrao, onde contenha todos os programas padroes;
#               -V     - [FUNCAO REMOVE PROGRAMAS] - Possibilitar o usuario digitar o nome do programa que deseja instalar, sendo que o script vai realizar a remoção automaticamente
# 
#               -VI    - [FUNCAO INSTALA PROGRAMAS OPCIONAIS] - Possibilitar a instalar de programas não essenciais para o sistema, como o servidor web.
# 
#               -VII   - [FUNCAO DESKTOP-NOTEBOOK] - Possibilitar a instalação de programas especificos de acordo com o tipo da máquina, desktop ou notebook. 
#
#####################################
#       [+] - Açao realizada 
#       [*] - Processamento
#       [-] - Não executado
#####################################
#
################################################################################
#
# # Script testado em
#	- Xubuntu 16.04
#
# # Compativel com
#       - Ubuntu
# 
################################################################################
# 
# # ARQUIVOS DE LOG DO SCRIPT
# 
#   atualiza.txt: armazena informações sobre a opção "atualiza o sistema".
#   corrige.txt: armazena informações sobre a opção "corrigir problemas"
#   limpa.txt: armazena informações sobre a opção "limpa o sistema".
#   instala.txt: armazena informações sobre a opção "instala programas".
#   remove.txt: armazena informações sobre a opção "remove programas".
#   reinicia.txt: armazena informações sobre a opção "reinicia sistema".
# 
################################################################################
# # FUNCOES
# 
# # # # # ATUALIZA SISTEMA
# # [+] Update
# #     [+] Update-Grud
# # [+] Upgrade
# # [+] Kernel 
# #     [+] Remove antigos
# # 
################################################################################
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
# # 
################################################################################
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
################################################################################
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
# 
# DESENVOLVIMENTO
# # [+] Kate
# # [+] Wireshark
# # [+] Git
# 
# IMAGEM
# # [+] Gimp
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
# 
# OUTROS
# # [+] Firewall Basic
# # [+] Mega
# # [+] Open Ssh
# # [+] Chkrootkit
# # [+] Reaver
# # [+] Lm-sensors

################################################################################	
# # # # # REMOVENDO PROGRAMAS
# # [+] Pidgin
# # [+] Thunderbird
# # [+] Parole

################################################################################	
# Reinicialização
# # [+]Reiniciar
#
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                               CORPO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# 
# # # # # CRIANDO FUNÇÕES PARA EXECUÇÃO
# 
# 
# # # # # # # # # # 
# # ATUALIZA SISTEMA
    update()
    {
        #atualizando lista de repositorios            
        echo "[+] Atualizando lista de repositorios do sistema"            
        apt update > base/atualiza.txt
        
        #atualizando repositorio e seus dependencias
        echo "[+] Atualizando lista de programas e suas dependências"            
        auto-apt update -y >> base/atualiza.txt
    }
    
    upgrade()
    {            
        #atualizando lista de programas do sistema
        echo "[+] Atualizando lista de programas do sistema"            
        apt upgrade -y >> base/atualiza.txt
        
        #atualizando repositorio local
        echo "[+] Atualizando repositório local dos programas"            
        auto-apt updatedb -y >> base/atualiza.txt
    }

# # # # # # # # # # 
# # CORRIGE SISTEMA            
    apt_check()
    {        
        #verificando lista do apt
        echo ""
        echo "[+] Verificando lista do apt"
        apt-get check -y >> log.txt
    }
    
    apt_install()
    {
        #instalando possiveis dependencias 
        echo ""
        echo "[+] Instalando dependências pendentes"
        apt-get -f install -y >> log.txt
    }
    
    apt_remove()
    {
        #removendo possiveis dependencias
        echo ""
        echo "[+] Removendo possíveis dependências obsoletas"
        apt-get -f remove -y >> log.txt     
        apt-get autoremove -y >> log.txt     
    }    
    
    apt_clean()
    {
        #limpando lista arquivos sobressalentes
        echo ""
        echo "[+] Limpando arquivos sobressalentes"
        apt-get clean -y >> log.txt     
    }
    
    apt_auto()
    {
        #corrigindo problemas de dependencias
        echo ""
        echo "[+] Corrigindo problemas de dependências"
        apt-get install auto-apt -y >> log.txt
    }
    
    apt_update_local()
    {        
        #corrigindo repositorio local de dependencias automaticamente
        echo ""
        echo "[+] Corrigindo repositório local de dependências automaticamente"
        auto-apt update-local >> log.txt     
    }
    
    swap()
    {
        #configurando a swap para uma melhor performance
        echo ""
        echo "[+] Configurando a Swap"        
        memoswap=$(grep "vm.swappiness=10" /etc/sysctl.conf)
        memocache=$(grep "vm.vfs_cache_pressure=60" /etc/sysctl.conf)
        background=$(grep "vm.dirty_background_ratio=15" /etc/sysctl.conf)
        ratio=$(grep "vm.dirty_ratio=25" /etc/sysctl.conf)        
        echo "[+] Diminuindo a Prioridade de uso da memória SWAP"
        if [[ $memoswap == "vm.swappiness=10" ]]; then
                echo "[*] Otimizando..."
                /bin/su -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf" 
        elif [[ $memocache == "vm.vfs_cache_pressure=60" ]]; then
                echo "[*] Otimizando..."
                /bin/su -c "echo 'vm.vfs_cache_pressure=60' >> /etc/sysctl.conf" 
        elif [[ $background == "vm.dirty_background_ratio=15" ]]; then
                echo "[*] Otimizando..."
                /bin/su -c "echo 'vm.dirty_background_ratio=15' >> /etc/sysctl.conf"
        elif [[ $ratio == "vm.dirty_ratio=25" ]]; then
                echo "[*] Otimizando..."
                /bin/su -c "echo 'vm.dirty_ratio=25' >> /etc/sysctl.conf"
        else
                echo "[-] Não há nada para ser otimizado"
                echo "[-] Isso porque já foi otimizado anteriormente!"
        fi    
    }
    
    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas
        
        #instalando prelink, preload, deborphan para um melhor performance do sistema
        echo ""
        echo "[*] Instalando Prelink, Preload e Deborphan"                        
        echo "-------------------"
        sudo apt install prelink preload -y 1>/dev/null 2>/dev/stdout
        sudo apt-get install deborphan -y >> log.txt
        
        echo "[*] Configurando Deborphan..."
        sudo deborphan | xargs sudo apt-get -y remove --purge &&
        sudo deborphan --guess-data | xargs sudo apt-get -y remove --purge

        #configurando o prelink e o preload
        echo "[*] Configurando Prelink e Preload..."
                memfree=$(grep "memfree = 50" /etc/preload.conf)
                memcached=$(grep "memcached = 0" /etc/preload.conf)
                processes=$(grep "processes = 30" /etc/preload.conf)
                prelink=$(grep "PRELINKING=unknown" /etc/default/prelink)
        
        echo "[*] Ativando o PRELINK"
        echo "-------------------"
        if [[ $prelink == "PRELINKING=unknown" ]]; then
                echo "adicionando ..."
                sed -i 's/unknown/yes/g' /etc/default/prelink	
        else
                echo "[-] Otimização já adicionada anteriormente."
        fi
    }
    
#     dpkg()
#     {
#         #corrigindo pacotes quebrados
#         echo ""
#         echo "[+] Corrigindo pacotes quebrados"
# 
#         #corrige possiveis erros na instalação de softwares
#         dpkg --configure -a >> log.txt
# 
#         #VERIFICAR AÇÕES
#         rm -r /var/lib/apt/lists >> log.txt
#         mkdir -p /var/lib/apt/lists/partial >> log.txt
#     }
    
    fonts()
    {
        #corrigindo erros fontes
        echo ""
        echo "[+] Instalando pacotes de fontes"
        
        #baixando pacote
        wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb >> log.txt 
        
        #instalando pacote
        dpkg -i ttf-mscorefonts-installer_3.6_all.deb >> log.txt
        
        #removendo pacote
        rm -f ttf-mscorefonts-installer_3.6_all.deb >> log.txt    
    }
    
    ntp()
    {        
        echo ""
        echo "[+] Corrigindo NTP"
                            
        #instalando software necessario
        apt install ntp ntpdate -y >> log.txt
        
        #parando o serviço NTP para realizar as configuraçoes necessarias
        echo ""
        echo "[+] Parando serviço NTP para realizaçao das configuraçoes necessarias"
            service ntp stop
        
        #configurando script base - NTP
        echo ""
        echo "[*] Realizando alteraçao no arquivo base"
        cat base/ntp.txt > /etc/ntp.conf
        
        #ativando servico novamente
        echo ""
        echo "[+] Ativando serviço NTP"
            service ntp start

        #realizando atualizacao hora/data
        echo ""
        echo "[+] Atualizando hora do servidor"
        echo "[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"
            
        #servidor NIC.BR
        echo ""
        echo "[+] Atualizando servidores, aguarde..."
        echo "[*] NIC.BR"
            ntpdate -q pool.ntp.br
            
        #servidor Ob. Nac.
        echo ""
        echo "[*] Observatorio Nacional"
            ntpdate -q ntp.on.br 
        
        # servidores da rnp
        echo ""
        echo "[*] RNP"
            ntpdate -q ntp.cert-rs.tche.br 

        # servidores da ufrj
        echo ""
        echo "[*] UFRJ"
            ntpdate -q ntps1.pads.ufrj.br 
            
        # servidor da usp
        echo ""
        echo "[*] USP"
            ntpdate -q ntp.usp.br             

        echo ""
        echo "[+] Hora do servidor atualizada!"        
    }
    
    apport()
    {
        echo ""
        echo "[+] Removendo possiveis erros com o apport"
        rm /var/crash/*
        
        #corrige apport - ubuntu 16.04
        cat base/apport > /etc/default/apport 
    }
    
    lightdm()
    {
        echo ""
        echo "[+] Iniciando sessão automaticamente"
        cat base/lightdm.conf > /etc/lightdm/lightdm.conf
    }
    
    terminal_cool()
    {
        #terminal Personalizado
        echo ""
        echo "[+] Deixando o terminal personalizado"
        cat base/.bashrc > $HOME/.bashrc    
    }
            
    sshd_config()
    {
        #altera arquivo ssh
        echo ""
        echo "[+] Alterando regras no acesso SSH"
        cat base/sshd_config > /etc/ssh/sshd_config    
    }
            
    repositorios_padrao()
    {
        echo ""
        echo "[+] Alterando lista de repositórios padrão"
        cat base/sources.list > /etc/apt/sources.list    
    }
            
    log_sudo()
    {
        echo ""
        echo "[+] Ativando log's do sudo"
        cat base/login.defs > /etc/login.defs    
    }
    
# # # # # # # # # # 
# # LIMPA SISTEMA   

    kernel()
    {
        echo "[+] Removendo os kernel's temporários do sistema"
        
        #removendo kernel's antigos
        dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge  >> log.txt
    }
    
    arquivos_temporarios()
    {    
        echo "[+] Removendo arquivos temporários do sistema"
        find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+                            
    }
    
    pacotes_orfaos()
    {
        echo "[+] Removendo Pacotes Órfãos"
        apt-get remove $(deborphan) -y ; apt-get autoremove -y    
    }
        
    chkrootkit()
    {
        echo "[+] Verificando Chkrootkit"        
        
        chkrootkit >> log.txt;
    }
    
    localpurge()
    {        
        echo "Removendo idiomas extras"
        localepurge       
    }                    
    
# # # # # # # # # # 
# # INSTALA PROGRAMAS  
    firefox()
    {
        echo "[+] Instalando Firefox"
        apt install firefox -y >> log.txt            
    }
    
    chromium()
    {
        echo "[+] Instalando o Chromium"
        
        apt install chromium-browser -y
    }
    
    
    steam()
    {
        echo "[+] Instalando Steam"
        apt install steam -y >> log.txt
    }
    
    spotify()
    {
        echo "[+] Instalando Spotify"
        
        #baixando pacote
        sh -c "echo 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list"

        #baixando chave
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

        #chamando função update
        update >> log.txt

        #instalando o spotify
        apt install spotify-client -y >> log.txt
    }

    icones_mac()
    {
        echo "[+] Instalando icones e temas do MacOS X"
        
        #adicionando repositorio
        add-apt-repository ppa:noobslab/macbuntu -y >> log.txt

        # chamando funcao update já criada
        update >> log.txt

        #instalando icones do MacOS
        apt-get install macbuntu-os-icons-lts-v7 -y >> log.txt

        #instalando tema do MacOS
        apt-get install macbuntu-os-ithemes-lts-v7 -y >> log.txt
    }
    
    codecs()
    {
        echo "[+] Instalando Pacotes Multimidias (Codecs)"
        
        #instalando pacotes multimidias
        apt install ubuntu-restricted-extras faac faad ffmpeg gstreamer0.10-ffmpeg flac icedax id3v2 lame libflac++6 libjpeg-progs libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar rar unrar unace-nonfree sharutils uudeview mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg libxine1-misc-plugins libxine1-plugins libxine1-x nautilus-script-audio-convert nautilus-scripts-manager tagtool spotify-client prelink deborphan oracle-java7-installer -y --force-yes >> log.txt
    }


    gimp()
    {
        echo "[+] Instalando o Gimp"
        apt install gimp -y >> log.txt
    }
    
    xfce4()
    {
        echo "[+] Instalando adicionais do XFCE"
    
        #instalando componentes do XFCE
        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin smartmontools -y -f -q >> log.txt

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp 
    
    }
    
    wine()
    {
        echo "[+] Instalando o Wine"
        
        #adicionado o repositorio
        add-apt-repository ppa:ubuntu-wine/ppa -y
        
        #chamando funcao já criada
        update

        apt install wine* -y
    }
    
    playonlinux()
    {
        echo "[+] Instalando o PlayonLinux"        
        apt install playonlinux* -y >> log.txt
    }
    
    redshift()
    {
        echo "[+] Instalando o Redshift"        
        apt install redshift gtk-redshift -y
    }
    
    libreoffice()
    {
        echo "[+] Instalando o Libreoffice"
        
        #adicionando ppa
        add-apt-repository ppa:libreoffice/ppa -y >> log.txt
        
        #chamando funcao já definida
        update
        
        #instalando libreoffice
        apt install libreoffice* -y >> log.txt                               
    }
    
    vlc()
    {
        echo "[+] Instalando o VLC"        
        apt install vlc -y >> log.txt
    }
    
    clementine()
    {
        echo "[+] Instalando o Clementine"        
        apt install clementine -y >> log.txt
    }
    
    gparted()
    {
        echo "[+] Instalando o Gparted"        
        apt install gparted -y >> log.txt    
    }
    
    tlp()
    {
        echo "[+] Instalando o Tlp"        
        apt install tlp -y >> log.txt
    }
    
    rar()
    {
        echo "[+] Instalando o Rar"
        apt install rar* -y >> log.txt
    }
    
    git()
    {
        echo "[+] Instalando o Git"
        apt install git-core git gitg -y >> log.txt
    }
    
    lm-sensors()
    {
        echo "[+] Instalando o Lm-sensors"
        apt install lm-sensors -y >> log.txt
    }
    
    texmaker()
    {
        echo "[+] Instalando o Texmaker"        
        apt install texmaker* texlive-full* texlive-latex-extra* -y >> log.txt
    }
    
    stellarium()
    {
        echo "[+] Instalando o Stellarium"
    
        #adicinando ppa
        add-apt-repository ppa:stellarium/stellarium-releases -y 

        #atualizando sistema
        update                            

        #instalando o stellarium                
        apt install stellarium* -y >> log.txt
    }
    
    texmaker()
    {
        echo "[+] Instalando o Texmaker"
        
        apt install texmaker* texlive-full* texlive-latex-extra* -y 
    }
    
    stellarium()
    {
        echo "[+] Instalando o Stellarium"
        
         #adicinando ppa
        add-apt-repository ppa:stellarium/stellarium-releases -y
        
        #chamando funcao já definida
        update                            
        
        #instalando o stellarium                
        apt install stellarium* -y
    }
    
    kstars()
    {
        echo "[+] Instalando o Kstars"
        
        apt install kstars* -y
    } 
    
    celestia()
    {
        echo "[+] Instalando o Celestia"
        
        apt install celestia-gnome celestia* -y
    }
    
    gnome_terminal()
    {
        echo "[+] Instalando Gnome-terminal"
        
        apt install gnometerminal -y
    }
    
    reaver()
    {
        echo "[+] Instalando o Reaver"
        
        apt install reaver -y
    }
    
    tor()
    {
        echo "[+] Instalando o Tor"
        
        #adicionando repositorio
        add-apt-repository ppa:webupd8team/tor-browser -y                
        
        #atualizando lista de pacotes
        update            
        
        #instalando tor
        apt-get install tor-browser -y
    }
    
    synaptic()
    {
        echo "[+] Instalando o Synaptic"
        
        apt install synaptic -y
    }
    
    dolphin()
    {
        echo "[+] Instalando o Dolphin"
        
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
        echo "[+] Instalando o Citra"
        
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
        echo "[+] Instalando o Visual Game Boy"
        
        apt install visualboyadvance-gtk -y
    }
    
    screenfetch()
    {
        echo "[+] Instalando o Screenfetch"
        
        apt install screenfetch -y
    }
    
    kdenlive()
    {
        echo "[+] Instalando o Kdenlive"
        
        #adicionando ppa
        add-apt-repository ppa:sunab/kdenlive-release -y

        #atualizando sistema
        update

        #instalando kdenlive	
        apt install kdenlive -y
    } 
    
    sweethome3d()
    {
        echo "[+] Instalando Sweet Home 3D"
        
        apt install sweethome3d -y
    }
    
    kate()
    {
        echo "[+] Instalando o Kate"
        
        apt install kate -y
    }
    
    cheese()
    {
        apt install cheese -y
    }
    
    plank()
    {
        echo "[+] Instalando o Plank Dock"
        
        #adicionando ppa
        add-apt-repository ppa:noobslab/apps -y
        
        #atualizando lista repositorios
        update
        
        #instalando plank
        apt-get install plank* plank-themer -y
    }
    
    gnome_system_monitor()
    {
        echo "[+] Instalando o Gnome System Monitor"
        
        apt install gnome-system-monitor -y
    }
    
    nautilus()
    {
        echo "[+] Instalando o Nautilus"
        
        #adicionando ppa
        add-apt-repository ppa:gnome3-team/gnome3 -y
        
        #atualizando lista repositorio
        update

        #instalando o nautilus
        apt install nautilus* -y   
    }
    
    wireshark()
    {
        echo "[+] Instalando o Wireshark"
        
        apt install wireshark -y
    }
    
    gnome_disk_utility()
    {
        echo "[+] Instalando o Gnome Disk Utility"
        
        apt install gnome-disk-utility* -y
    }
    
    calibre()
    {
        echo "[+] Instalando o Calibre"
        
        apt install calibre -y       
    }
    
    audacity()
    {
        echo "[+] Instalando o Audacity"
        
        apt install audacity* -y   
    }    
    
    mcomix()
    {
        echo "[+] Instalando o MComix"
    
        #adicionando repositorio
        add-apt-repository ppa:nilarimogard/webupd8 -y

        #atualizando lista repositorios
        apt-get update

        #instalando mcomix
        apt-get install mcomix -y                                     
    }
    
    simple_screen_recorder()
    {
        echo "[+] Instalando o Simple Screen Recorder"
        
        #adicionando fonte
        add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

        #atualizando lista de repositorios
        apt-get update 
        
        #instalando simplescreenrecorder
        apt-get install simplescreenrecorder -y
        apt-get install simplescreenrecorder-lib:i386 -y
    }
    
    mega()
    {
        echo "[+] Instalando o MEGA"
    
        #instalando mega
        dpkg -i base/mega/*.deb
        apt install -fy
        dpkg -i base/mega/*.deb
    }
    
    openssh()
    {
        echo "[+]'Instalando o OpenSSH"
        
        apt install openssh* -y
    }
    
    figlet()
    {
        echo "[+] Instalando o Figlet"
        
        apt install figlet -y
    }   
    
    install_chkrootkit()
    {
        echo "[+] Instalando o Chkrootkit"
        
        apt install chkrootkit -y
    }
    
    localepurge()
    {
        echo "[+] Instalando o Localepurge"
        
        apt-get install localepurge -y                                           
    }
    
    firewall_basic()
    {
        echo "[+] Instalando o firewall UFW + GUFW"
    
        apt install ufw gufw -y                                    
    }
    
       
# # # # # # # # # # 

##REALIZANDO VERIFICAÇÕES
    ######VERIFICANDO USUARIO ROOT
   if [[ `id -u` -ne 0 ]]; then
        clear
        echo "[-] Você precisa ter poderes administrativos (root)"
        echo "[-] O script está sendo finalizado ..."
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
    
    #limpando arquivo de log
    rm log.txt
    touch log.txt
    
    ##CHAMANDOS FUNCOES    
    #     
    case $escolha in   
    ################################################################################
    ######ATUALIZA SISTEMA
        1) echo  
            clear
            update
            upgrade
        ;;
        
    ################################################################################
    ######CORRIGE SISTEMA
        2) echo                                      
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
#                     dpkg
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
#                     dpkg
                fonts
                ntp
                apport
                terminal_cool
                sshd_config
                repositorios_padrao
                log_sudo                    
#                     lightdm
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
#                     dpkg
                fonts
                ntp
                apport
                terminal_cool
                sshd_config
                repositorios_padrao
                log_sudo
            fi
        
        ;;
                
    ################################################################################
    ######LIMPA SISTEMA
        3) echo
            clear
            kernel
            arquivos_temporarios
            pacotes_orfaos
            chkrootkit
            localpurge                                 
        ;;
    
    ################################################################################
    ######INSTALA PROGRAMAS
        4) echo  
            clear   
            if [[ $hostname == 'notebook' ]]; then             
#               NAVEGADORES
                firefox
                chromium
                tor
                
#               JOGOS
#                 steam
#                 citra
#                 dolphin
                visual_game_boy
                
#               ASTRONOMIA
                stellarium
                celestia
                kstars
                
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
                wireshark
                git
                
#               IMAGEM
                gimp
                
#               OFFICE
                libreoffice
                texmaker
                
#               PERSONALIZAÇÃO
                icones_mac
                codecs
                xfce
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
                
#               OUTROS
                firewall_basic
                mega
                openssh
                install_chkrootkit
                reaver
                sensors            
            else            
#               NAVEGADORES
                firefox
                chromium
                tor
                
#               JOGOS
                steam
                citra
                dolphin
                visual_game_boy
                
#               ASTRONOMIA
                stellarium
                celestia
                kstars
                
#               MULTIMIDIA
                spotify
                clementine
                vlc
                kdenlive
                sweethome3d                
                audacity
                mcomix
                simple_screen_recorder
                calibre
                
#               DESENVOLVIMENTO
                kate
                wireshark
                git
                
#               IMAGEM
                gimp
                
#               OFFICE
                libreoffice
                texmaker
                
#               PERSONALIZAÇÃO
                icones_mac
                codecs
                xfce
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
                
#               OUTROS
                firewall_basic
                mega
                openssh
                install_chkrootkit
                reaver
                sensors            
            fi
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
    echo ""
    echo "   / \ | | | |_   _/ _ \   / ___/ _ \| \ | |  ___|_ _/ ___|\ \   / /___ / 
  / _ \| | | | | || | | | | |  | | | |  \| | |_   | | |  _  \ \ / /  |_ \ 
 / ___ \ |_| | | || |_| | | |__| |_| | |\  |  _|  | | |_| |  \ V /  ___) |
/_/   \_\___/  |_| \___/___\____\___/|_| \_|_|   |___\____|___\_/  |____/            
           |_____|                            |_____|    "                                                
    echo ""
    read -n1 -p "Para continuar escolha s(sim) ou n(não)  " escolha
        case $escolha in
            s|S) echo                 
                    clear
                    auto_config_ubuntu                    
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