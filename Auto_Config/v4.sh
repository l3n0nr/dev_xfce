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
# por Wiki Debian - Tor Browser
#	<wiki.debian.org/TorBrowser#Debian_9_.22Stretch.22>
#
# por Sandro de Castro - Guia de pós-instalação do Debian 9 Stretch
#	<https://www.blogopcaolinux.com.br/2017/06/Guia-de-pos-instalacao-do-Debian-9-Stretch.html>
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
#									      									  #
#	If I have seen further it is by standing on the shoulders of Giants.      #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)	          #
#							~Isaac Newton	      							  #
#									      									  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # versão do script:           [2.0.398.0.1.0]   #
# # data de criação do script:    [28/09/17]      #
# # ultima ediçao realizada:      [06/03/18]      #
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
#
# 	e = pendencias
# 				- I   - [KERNEL] - Melhorar script para remover kernel mais antigo
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
#   - Debian 9
#   - Xubuntu 17.10 - OBS:Não aconselhável utilização, pois há diversas incompatibilidades de softwares
#
# # Compativel com
#   - Xubuntu 16.04 - LTS
#   - Debian 9
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # VARIAVEIS DE AMBIENTE
# Criando variavel com localização da raiz do usuario
    PASTA_HOME=$HOME           		    # script em determinados momento não identifica corretamente o pasta home, diretamente com a instrução $HOME

# verificando distro
    DISTRO=$(lsb_release -i | cut -f2)  # Ubuntu ou Debian

# capturando hostname da maquina
    V_HOSTNAME=$(hostname)              # Funções configuradas a partir de valores -desktop ou notebook-

# espeak habilitado
    VAR_MUDO=0                          # valor padrao = mudo desativado

# usuario virtualbox
    USUARIO="lenonr"                    # personalizavel

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

        - Após a maquina ser formatada(apenas as funções automáticas e depois desliga a máquina)
            ~ v4.sh formatado

        - Para executar todas as funções(semi-automático)
            ~ v4.sh todas

        - Para executar todas as funções em silêncio, basta adicionar o parametro 'mudo' antes de qualquer outra ao iniciar o script.  

    **      SCRIPT TESTADO NO UBUNTU 16.04 | DEBIAN 8 | DEBIAN 9    **

############################################################################
"
}

#
# # ATUALIZA SISTEMA
    update()
    {
        #atualizando lista de repositorios
        printf "\n[+] Atualizando lista de repositorios do sistema"
        printf "\n[+] Atualizando lista de repositorios do sistema" >> /tmp/log.txt
        	apt update
    }

    upgrade()
    {
        # verificando distribuição
        if [ $ == "Ubuntu" ]; then            
        	#atualizando lista de programas do sistema
        	printf "\n[+] Atualizando lista de programas do sistema \n"
	        printf "\n[+] Atualizando lista de programas do sistema \n" >> /tmp/log.txt
	        	apt upgrade -y

	        #atualizando repositorio local
	        printf "\n[+] Atualizando repositório local dos programas \n"
	        printf "\n[+] Atualizando repositório local dos programas \n" >> /tmp/log.txt
	        	auto-apt updatedb
		else
        	#atualizando lista de programas do sistem
        	printf "\n[+] Atualizando lista de programas do sistema \n"
	        printf "\n[+] Atualizando lista de programas do sistema \n" >> /tmp/log.txt
		        apt upgrade -y
		        apt dist-upgrade -y
		fi
    }

# # # # # # # # # #
# # CORRIGE SISTEMA
    apt_check()
    {
        #verificando lista do apt
        printf "\n[+] Verificando lista do apt"
        printf "\n[+] Verificando lista do apt" >> /tmp/log.txt
        	apt-get check -y
    }

    apt_install()
    {
        #instalando possiveis dependencias
        printf "\n[+] Instalando dependências pendentes"
        printf "\n[+] Instalando dependências pendentes" >> /tmp/log.txt
        	apt-get install -fy
    }

    apt_remove()
    {
        #removendo possiveis dependencias
        printf "\n[+] Removendo possíveis dependências obsoletas"
        printf "\n[+] Removendo possíveis dependências obsoletas" >> /tmp/log.txt
	        apt-get remove -fy
	        apt-get autoremove -y
    }

    apt_clean()
    {
        #limpando lista arquivos sobressalentes
        printf "\n[+] Limpando arquivos sobressalentes"
        printf "\n[+] Limpando arquivos sobressalentes" >> /tmp/log.txt
        	apt-get clean -y
    }

    apt_auto()
    {
        #corrigindo problemas de dependencias
        printf "\n[+] Corrigindo problemas de dependências"
        printf "\n[+] Corrigindo problemas de dependências" >> /tmp/log.txt
        	apt-get install auto-apt -y
    }

    apt_update_local()
    {
        #corrigindo repositorio local de dependencias automaticamente
        printf "\n[+] Corrigindo repositório local de dependências automaticamente"
        printf "\n[+] Corrigindo repositório local de dependências automaticamente" >> /tmp/log.txt
        	auto-apt update-local
    }

    swap()
    {
        #configurando a swap para uma melhor performance
        printf "\n"
        printf "\n[+] Configurando a Swap"
        printf "\n[+] Configurando a Swap" >> /tmp/log.txt

        memoswap=$(grep "vm.swappiness=10" /etc/sysctl.conf)
        memocache=$(grep "vm.vfs_cache_pressure=60" /etc/sysctl.conf)
        background=$(grep "vm.dirty_background_ratio=15" /etc/sysctl.conf)
        ratio=$(grep "vm.dirty_ratio=25" /etc/sysctl.conf)
        printf "\n [+] Diminuindo a Prioridade de uso da memória SWAP"
        if [[ $memoswap == "vm.swappiness=10" ]]; then
                printf "\n[*] Otimizando..." 
                /bin/su -c "printf 'vm.swappiness=10' >> /etc/sysctl.conf"
        elif [[ $memocache == "vm.vfs_cache_pressure=60" ]]; then
                printf "\n[*] Otimizando..." 
                /bin/su -c "printf 'vm.vfs_cache_pressure=60' >> /etc/sysctl.conf"
        elif [[ $background == "vm.dirty_background_ratio=15" ]]; then
                printf "\n[*] Otimizando..." >> /tmp/log.txt
                /bin/su -c "printf 'vm.dirty_background_ratio=15' >> /etc/sysctl.conf"
        elif [[ $ratio == "vm.dirty_ratio=25" ]]; then
                printf "\n[*] Otimizando... "
                /bin/su -c "printf 'vm.dirty_ratio=25' >> /etc/sysctl.conf"
        else
                printf "\n[-] Não há nada para ser otimizado"
                printf "\n[!] Isso porque já foi otimizado anteriormente!"
        fi
        printf "\n"
    }

    prelink_preload_deborphan()
    {
        #prelink    = otimiza o tempo de boot
        #preload    = reduz o tempo de inicialização das aplicações
        #deborphan  = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas

        #instalando prelink, preload, deborphan para um melhor performance do sistema
        printf "\n[*] Instalando Prelink, Preload e Deborphan"
        printf "\n[*] Instalando Prelink, Preload e Deborphan" >> /tmp/log.txt

        apt install prelink preload -y 1>/dev/null 2>/dev/stdout
        apt-get install deborphan -y

        echo "[*] Configurando Deborphan... " 
        deborphan | xargs sudo apt-get -y remove --purge &&
        deborphan --guess-data | xargs apt-get -y remove --purge

        #configurando o prelink e o preload
        echo "[*] Configurando Prelink e Preload... "
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

    pacotes_quebrados()
    {
        #corrigindo pacotes quebrados
        printf "\n[+] Corrigindo pacotes quebrados"
        printf "\n[+] Corrigindo pacotes quebrados" >> /tmp/log.txt

        #corrige possiveis erros na instalação de softwares
        dpkg --configure -a
        apt install -f 
        apt-get --fix-broken install

        #VERIFICAR AÇÕES
        rm -r /var/lib/apt/lists
        mkdir -p /var/lib/apt/lists/partial
    }

    fonts()
    {
        #corrigindo erros fontes
        printf "\n[+] Instalando pacotes de fontes"
        printf "\n[+] Instalando pacotes de fontes" >> /tmp/log.txt

        #baixando pacote
        wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb

        #instalando pacote
        dpkg -i ttf-mscorefonts-installer_3.6_all.deb

        #removendo pacote
        rm -f ttf-mscorefonts-installer_3.6_all.deb
        rm -f ttf-mscorefonts-installer_3.6_all.deb.1
    }    

    config_ntp()
    {
        printf "\n[+] Configurando o NTP"
        printf "\n[+] Configurando o NTP" >> /tmp/log.txt

        #parando o serviço NTP para realizar as configuraçoes necessarias
        printf "\n[*] Parando serviço NTP para realizaçao das configuraçoes necessarias"
            service ntp stop

        #configurando script base - NTP
        printf "\n[*] Realizando alteraçao no arquivo base"
        cat base/ntp.txt > /etc/ntp.conf

        #ativando servico novamente
        printf "\n[+] Ativando serviço NTP"
            service ntp start

        #realizando atualizacao hora/data
        printf "\n[+] Atualizando hora do servidor"
        printf "\n[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"

        printf "\n[+] Atualizando servidores, aguarde..."
        printf "\n[*] NIC.BR"
            ntpdate -q pool.ntp.br
     
        printf "\n[*] Observatorio Nacional"
            ntpdate -q ntp.on.br

        printf "\n[*] RNP"
            ntpdate -q ntp.cert-rs.tche.br

        printf "\n[*] UFRJ"
            ntpdate -q ntps1.pads.ufrj.br

        printf "\n[*] USP"
            ntpdate -q ntp.usp.br

        printf "\n[+] Hora do servidor atualizada! \n"
    }

    apport()
    {
        printf "\n[+] Removendo possiveis erros com o apport \n"
        printf "\n[+] Removendo possiveis erros com o apport \n" >> /tmp/log.txt

        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport
    }

    lightdm()
    {
        printf "\n[+] Iniciando sessão automaticamente"
        printf "\n[+] Iniciando sessão automaticamente" >> /tmp/log.txt

    	cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
    }

    log_sudo()
    {
        printf "\n[+] Ativando log's do sudo"
        printf "\n[+] Ativando log's do sudo" >> /tmp/log.txt
    
    	cat base/ubuntu/login.defs > /etc/login.defs
    }

    repositorios_padrao()
    {
        # verificando distribuição
        if [ $DISTRO == "Ubuntu" ]; then
            printf "\n[+] Alterando lista de repositórios padrão"
            printf "\n[+] Alterando lista de repositórios padrão" >> /tmp/log.txt

            cat base/ubuntu/sources.list > /etc/apt/sources.list
        elif [ $DISTRO == "Debian" ]; then
            printf "\n[+] Alterando lista de repositórios padrão"
            printf "\n[+] Alterando lista de repositórios padrão" >> /tmp/log.txt

            cat base/debian/sources.list > /etc/apt/sources.list
        else
            printf "\n[!] Não realizou nada, distro não identificada!"
            printf "\n[!] Não realizou nada, distro não identificada!" >> /tmp/log.txt
        fi
    }

    arquivo_hosts()
    {
        #verificando variavel
        if [[ $V_HOSTNAME == 'desktop' ]]; then
            printf "\n[+] Alterando arquivo Hosts"
            printf "\n[+] Alterando arquivo Hosts" >> /tmp/log.txt

            cat base/ubuntu/hosts > /etc/hosts
        fi
    }

    chaveiro()
    {
        printf "\n[+] Removendo o chaveiro da sessão"
        printf "\n[+] Removendo o chaveiro da sessão" >> /tmp/log.txt

    	apt-get remove gnome-keyring -y
    }    

    atualiza_db()
    {
    	# variavel de verificação
        var_locate=$(which locate)

        printf "\n[+] Verificando se existe Locate instalado" 
        printf "\n[+] Verificando se existe Locate instalado" >> /tmp/log.txt

        if [[ ! -e $var_locate ]]; then
            printf "\n"
            printf "[+] Instalando Locate"
            printf "[+] Instalando Locate" >> /tmp/log.txt

        	apt install locate -y
        fi

        printf "\n[+] Atualizando base de dados do sistema"        
        printf "\n[+] Atualizando base de dados do sistema" >> /tmp/log.txt

    	updatedb
    }

# # # # # # # # # #
# # LIMPA SISTEMA
    kernel()
    {
        printf "\n[+] Removendo os kernel's temporários do sistema" >> /tmp/log.txt

        #removendo kernel's antigos
        # dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

        ### REMOVENDO KERNEL ESPECIFICO - VERIFICAR
  #       # listando kernel's
		# dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' > /tmp/kernels.txt

		# # contando linhas
		# wc /tmp/kernels.txt > /tmp/quantidade.txt  	

		# # capturando valor total
  #       valor=$(cut -c3 /tmp/quantidade.txt)

  #       # pegando penultimo valor
  #       valor=$(($valor-1))

  #       # listando kernel especifico - mais velho
  #       cat -n /tmp/kernels.txt | grep -n ^ | grep ^$valor: | cut -d: -f2 > /tmp/kernel.txt

  #       cut -d' ' -f2 /tmp/kernel.txt
    }

    arquivos_temporarios()
    {
        printf "\n"
        printf "\n[+] Removendo arquivos temporários do sistema" 
        printf "\n[+] Removendo arquivos temporários do sistema" >> /tmp/log.txt

    	find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+
    }

    pacotes_orfaos()
    {
        printf "\n[+] Removendo Pacotes Órfãos"
        printf "\n[+] Removendo Pacotes Órfãos" >> /tmp/log.txt

        apt-get remove $(deborphan) -y 
        apt-get autoremove -y
    }

    funcao_chkrootkit()
    {
        printf "\n"
        printf "\n[+] Verificando Chkrootkit"
        printf "\n[+] Verificando Chkrootkit" >> /tmp/log.txt

        chkrootkit
    }

    func_localepurge()
    {
        printf "\n "
        printf "\n[+] Removendo idiomas extras" 
        printf "\n[+] Removendo idiomas extras" >> /tmp/log.txt

        localepurge
    }

# # # # # # # # # #
# # INSTALA PROGRAMAS
    firefox()
    {
        printf "\n"
        printf "\n[+] Instalando Firefox"
        printf "\n[+] Instalando Firefox" >> /tmp/log.txt

        apt install firefox -y
    }

    chromium()
    {
    	if [[ $DISTRO == "Ubuntu" ]]; then
	        printf "\n"
	        printf "\n[+] Instalando o Chromium"
	        printf "\n[+] Instalando o Chromium" >> /tmp/log.txt

	        apt install chromium-browser -y

        elif [[ $DISTRO == "Debian" ]]; then
        	printf "\n"
	        printf "\n[+] Instalando o Chromium"
	        printf "\n[+] Instalando o Chromium" >> /tmp/log.txt

        	apt install chromium chromium-l10n -y

    	else
    		printf "\n[-] ERRO CHROMIUM!"
    		printf "\n[-] ERRO CHROMIUM!" >> /tmp/log.txt
    	fi
    }

    steam()
    {
        printf "\n"
        printf "\n[+] Instalando Steam"
        printf "\n[+] Instalando Steam" >> /tmp/log.txt

	# instalando dependencias steam - DEBIAN 9
	if [[ $DISTRO == "Debian" ]]; then      	
		dpkg --add-architecture i386		
		update
		apt install libgl1-nvidia-glx:i386 -y		
	fi		

        apt install steam -y
    }

    spotify()
    {
        # variavel de verificação
        var_spotify=$(which spotify)

        printf "\n"
        printf "\n [+] Verificando se existe Spotify instalado"

        if [[ ! -e $var_spotify ]]; then
            printf "\n"
            printf "\n[+] Instalando Spotify" >> /tmp/log.txt

			if [[ $DISTRO == "Ubuntu" ]]; then            
	            # #baixando pacote
	            # sh -c "printf 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list"

	            # #baixando chave
	            # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

	            # #chamando função update
	            # update

	            # #instalando o spotify
	            # apt install spotify-client -y --allow-unauthenticated

	            snap install spotify
	            
			elif [[ $DISTRO == "Debian" ]]; then
        		# adicionando dependencia
        		apt install dirmngr -y

        		# adicionando chave
        		apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410

        		# adicionando repositorio
        		echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

        		# atualizando a lista de repositorios
        		update

        		# baixando lib
        		wget ftp.us.debian.org/debian/pool/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb 

        		# instalando lib
				dpkg -i libssl1.0.0_1.0.1t-1+deb8u7_amd64.deb -y

				# instalando spotify
				apt install spotify-client -y          		
        	fi
        else
            printf "[+] Spofity já está instalado! \n"
        fi
    }

    icones_mac()
    {
        printf "\n"
        printf "\n[+] Instalando icones e temas do MacOS X"
        printf "\n[+] Instalando icones e temas do MacOS X" >> /tmp/log.txt

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
        printf "\n[+] Instalando Pacotes Multimidias (Codecs)"
        printf "\n[+] Instalando Pacotes Multimidias (Codecs)" >> /tmp/log.txt

        if [[ $DISTRO == "Ubuntu" ]]; then
            #instalando pacotes multimidias
            apt install ubuntu-restricted-extras -y
        fi

        apt install faac faad ffmpeg gstreamer0.10-ffmpeg flac icedax id3v2 lame libflac++6 libjpeg-progs libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar rar unrar unace-nonfree sharutils uudeview mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg libxine1-misc-plugins libxine1-plugins libxine1-x nautilus-script-audio-convert nautilus-scripts-manager tagtool spotify-client prelink deborphan oracle-java7-installer -y --force-yes        
        apt install lame libavcodec-extra libav-tools -y	
    }

    funcao_gimp()
    {
     	# variavel de verificação
        var_gimp=$(which gimp)

        if [[ ! -e $var_gimp ]]; then
            printf "\n"
            printf "\n[+] Instalando o Gimp"
            printf "\n[+] Instalando o Gimp" >> /tmp/log.txt
            apt install gimp -y

            # printf "\n"
            # printf "[+] Instalando o PhotoGimp \n"

#             printf "[*] Removendo arquivo existente \n"
#             rm -r $PASTA_HOME/.gimp-2.8

            # printf "[*] Inserindo novo arquivo \n"
            # cp -r base/.gimp-2.8/ $PASTA_HOME

            # printf "[+] Novo arquivo adicionado! \n"
        else
            printf "\n"
            printf "[+] Gimp já está instalado na sua máquina! \n"
        fi
    }

    xfce4()
    {
        printf "\n"
        printf "\n[+] Instalando adicionais do XFCE" 
        printf "\n[+] Instalando adicionais do XFCE" >> /tmp/log.txt

        #instalando componentes do XFCE
        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin smartmontools -fyq

        #dando permissão de leitura, para verificar temperatura do HDD
        chmod u+s /usr/sbin/hddtemp

        ## xfpanel-switch
        # variavel de verificação
        var_xfpanel=$(which xfpanel-switch)

        if [[ ! -e $var_xfpanel ]]; then
            printf "\n"
            printf "\n[+] Instalando Xfpanel-switch"
            printf "\n[+] Instalando Xfpanel-switch" >> /tmp/log.txt

            # wget mirrors.kernel.org/ubuntu/pool/universe/x/xfpanel-switch/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # dpkg -i xfpanel-switch_1.0.4-0ubuntu1_all.deb

            dpkg -i /base/deb/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i /base/deb/xfpanel-switch_1.0.4-0ubuntu1_all.deb
        else
            printf "[+] Xfpanel-switch ja esta instalado \n"            
        fi

        ## whisker-menu
        ## variavel de verificacao
        var_whiskermenu=$(which xfce4-popup-whiskermenu)

        if [[ ! -e $var_whiskermenu ]]; then
            printf "\n"
            printf "\n[+] Instalando Whisker-menu"
            printf "\n[+] Instalando Whisker-menu" >> /tmp/log.txt

            # wget mirrors.kernel.org/ubuntu/pool/universe/x/xfpanel-switch/xfpanel-switch_1.0.4-0ubuntu1_all.deb

            # dpkg -i xfpanel-switch_1.0.4-0ubuntu1_all.deb

            dpkg -i base/deb/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb

            # corrigindo problemas de dependencias
            apt --fix-broken install -y

            dpkg -i base/deb/xfce4-whiskermenu-plugin_1.6.2-1_amd64.deb
        else
            printf "[+] Whisker-menu ja esta instalado \n"            
        fi
    }

    wine()
    {
    	# variavel de verificação
        var_wine=$(which wine)

        if [[ ! -e $var_wine ]]; then
            printf "\n"
            printf "\n[+] Instalando o Wine" >> /tmp/log.txt

            if [[ $DISTRO == "Ubuntu" ]]; then
                # adicionado o repositorio
                add-apt-repository ppa:ubuntu-wine/ppa -y

                # chamando funcao já criada
                update

                apt install wine -y
            fi

            # verificar funcao debian
        else
            printf "\n"
            printf "[+] Wine já está instalado na sua máquina! \n"
        fi
    }

    playonlinux()
    {
        printf "\n"
        printf "\n[+] Instalando o PlayonLinux"
        printf "\n[+] Instalando o PlayonLinux" >> /tmp/log.txt

        apt install playonlinux -y
    }

    redshift()
    {
        printf "\n"
        printf "\n[+] Instalando o Redshift"
        printf "\n[+] Instalando o Redshift" >> /tmp/log.txt

        apt install redshift gtk-redshift -y

        # criando link
        cat base/redshift.conf > PASTA_HOME/.config/redshift.conf 
    }

    libreoffice()
    {
		# se habilitar verificação, novas atualizações não serão instaladas.
		# libreoffice ja vem instalado por padrao na formataçao
# 		
# 		variavel de verificação 		
#         var_libreoffice=$(which libreoffice)
#
#         if [[ ! -e $var_libreoffice ]]; then
            printf "\n"
            printf "\n[+] Instalando o Libreoffice"
            printf "\n[+] Instalando o Libreoffice" >> /tmp/log.txt

            if [[ $DISTRO == "Ubuntu" ]]; then
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

    vlc()
    {
        printf "\n"
        printf "\n[+] Instalando o VLC"
        printf "\n[+] Instalando o VLC" >> /tmp/log.txt

        apt install vlc -y
    }

    clementine()
    {
        printf "\n"
        printf "\n[+] Instalando o Clementine"
        printf "\n[+] Instalando o Clementine" >> /tmp/log.txt

        apt install clementine -y
    }

    gparted()
    {
        printf "\n"
        printf "\n[+] Instalando o Gparted"
        printf "\n[+] Instalando o Gparted" >> /tmp/log.txt

        apt install gparted -y
    }

    tlp()
    {
        printf "\n"
        printf "\n[+] Instalando o Tlp"
        printf "\n[+] Instalando o Tlp" >> /tmp/log.txt

        apt install tlp -y
    }

    install_git()
    {
        printf "\n"
        printf "\n[+] Instalando o Git"
        printf "\n[+] Instalando o Git" >> /tmp/log.txt

        apt install git-core git -y
    }

    lm-sensors()
    {
        printf "\n"
        printf "\n[+] Instalando o Lm-sensors"
        printf "\n[+] Instalando o Lm-sensors" >> /tmp/log.txt

        apt install lm-sensors -y
    }

    stellarium()
    {
        # variavel de verificação
        var_stellarium=$(which stellarium)

        if [[ ! -e $var_stellarium ]]; then
            # verificando distribuição
            if [ $DISTRO == "Ubuntu" ]; then
                printf "\n"
                printf "\n[+] Instalando o Stellarium"
                printf "\n[+] Instalando o Stellarium" >> /tmp/log.txt

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

    texmaker()
    {
        printf "\n"
        printf "\n[+] Instalando o Texmaker"
        printf "\n[+] Instalando o Texmaker" >> /tmp/log.txt

        apt install texmaker* texlive-full* texlive-latex-extra* -y
        apt install aspell aspell-pt-br -y
    }

    kstars()
    {
        printf "\n"
        printf "\n[+] Instalando o Kstars"
        printf "\n[+] Instalando o Kstars" >> /tmp/log.txt

        apt install kstars* -y
    }

    gnome_terminal()
    {
        printf "\n"
        printf "\n[+] Instalando Gnome-terminal"
        printf "\n[+] Instalando Gnome-terminal" >> /tmp/log.txt

        apt install gnometerminal -y
    }

    reaver()
    {
        printf "\n"
        printf "\n[+] Instalando o Reaver"
        printf "\n[+] Instalando o Reaver" >> /tmp/log.txt

        apt install reaver -y
    }

    tor()
    {
        # variavel de verificação
        var_tor=$(which tor)

        if [[ ! -e $var_tor ]]; then
            printf "\n"
            printf "\n[+] Instalando o Tor"
            printf "\n[+] Instalando o Tor" >> /tmp/log.txt

            # verificando distribuição
            if [ $DISTRO == "Ubuntu" ]; then
                # ubuntu 16.04
	            #adicionando repositorio
	            add-apt-repository ppa:webupd8team/tor-browser -y

	            #atualizando lista de pacotes
	            update

	            #instalando tor
	            apt-get install tor tor-browser -y
                # apt install tor torbrowser-launcher -y

            elif [ $DISTRO == "Debian" ]; then
            	echo 
    #         	# adicionando repositorio tor
				# echo "" >> /etc/apt/sources.list
    #         	echo "" >> /etc/apt/sources.list
    #         	echo "#------------------------------------------------------------------------------#" >> /etc/apt/sources.list
    #         	echo "# REPOSITORIO TOR" >> /etc/apt/sources.list
    #         	echo "deb http://deb.debian.org/debian stretch-backports main contrib" >> /etc/apt/sources.list
				
				# # atualizando lista repositorio
				# update

				# apt install tor torbrowser-launcher -t stretch-backports -y
            else
            	printf "\n[-] ERRO TOR"
            	printf "\n[-] ERRO TOR" >> /tmp/log.txt
            fi

        else
            printf "\n"
            printf "[+] Tor já está instalado! \n" 
        fi           
    }

    dolphin()
    {
        printf "\n"
        printf "\n[+] Instalando o Dolphin"
        printf "\n[+] Instalando o Dolphin" >> /tmp/log.txt

        if [[ $DISTRO == "Ubuntu" ]]; then
            #adicionando repositorio do dolphin
            add-apt-repository ppa:glennric/dolphin-emu -y

            #atualizando lista de repositorios
            update

            #corrigindo problemas de dependencias
            apt-get install -f
        fi

        #instalando dolphin
        apt install dolphin-emu* -y
    }

    visual_game_boy()
    {
        printf "\n"
        printf "\n[+] Instalando o Visual Game Boy"
        printf "\n[+] Instalando o Visual Game Boy" >> /tmp/log.txt 

        apt install visualboyadvance-gtk -y
    }

    screenfetch()
    {
        printf "\n"
        printf "\n[+] Instalando o Screenfetch"
        printf "\n[+] Instalando o Screenfetch" >> /tmp/log.txt

        apt install screenfetch -y
    }

    kdenlive()
    {
        # variavel de verificação
        var_kdenlive=$(which kdenlive)

        if [[ ! -e $var_kdenlive ]]; then
            printf "\n"
            printf "\n[+] Instalando o Kdenlive"
            printf "\n[+] Instalando o Kdenlive" >> /tmp/log.txt

            if [[ $DISTRO == "Ubuntu" ]]; then
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

    sweethome3d()
    {
        printf "\n"
        printf "\n[+] Instalando Sweet Home 3D"
        printf "\n[+] Instalando Sweet Home 3D" >> /tmp/log.txt

        apt install sweethome3d -y
    }

    kate()
    {
        printf "\n"
        printf "\n[+] Instalando o Kate"
        printf "\n[+] Instalando o Kate" >> /tmp/log.txt

        apt install kate -y
    }

    cheese()
    {
        printf "\n"
        printf "\n[+] Instalando o Chesse"
        printf "\n[+] Instalando o Chesse" >> /tmp/log.txt

        apt install cheese -y
    }

    plank()
    {
        # variavel de verificação
        var_plank=$(which plank)

        if [[ ! -e $var_plank ]]; then
            printf "\n"
            printf "\n[+] Instalando o Plank Dock"
            printf "\n[+] Instalando o Plank Dock" >> /tmp/log.txt

            # verificando distribuição
            if [ $DISTRO == "Ubuntu" ]; then
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
        printf "\n[+] Instalando o Gnome System Monitor"
        printf "\n[+] Instalando o Gnome System Monitor" >> /tmp/log.txt

        apt install gnome-system-monitor -y
    }

    nautilus()
    {
        # variavel de verificação
        var_nautilus=$(which nautilus)

        if [[ ! -e $var_nautilus ]]; then
            printf "\n"
            printf "\n[+] Instalando o Nautilus"
            printf "\n[+] Instalando o Nautilus" >> /tmp/log.txt

            # verificando distribuição
            if [ $DISTRO == "Ubuntu" ]; then
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

    wireshark()
    {
        printf "\n"
        printf "\n[+] Instalando o Wireshark"
        printf "\n[+] Instalando o Wireshark" >> /tmp/log.txt

        apt install wireshark -y
    }

    gnome_disk_utility()
    {
        printf "\n"
        printf "\n[+] Instalando o Gnome Disk Utility"
        printf "\n[+] Instalando o Gnome Disk Utility" >> /tmp/log.txt

        apt install gnome-disk-utility -y
    }

    audacity()
    {
        printf "\n"
        printf "\n[+] Instalando o Audacity"
        printf "\n[+] Instalando o Audacity" >> /tmp/log.txt

        apt install audacity -y
    }

    simple_screen_recorder()
    {
        # variavel de verificação
        var_simplescreenrecorder=$(which simplescreenrecorder)

        if [[ ! -e $var_simplescreenrecorder ]]; then
            printf "\n"
            printf "\n[*] Instalando o Simple Screen Recorder"
            printf "\n[*] Instalando o Simple Screen Recorder" >> /tmp/log.txt

            if [[ $DISTRO == "Ubuntu" ]]; then
                #adicionando fonte
                add-apt-repository ppa:maarten-baert/simplescreenrecorder -y

                #atualizando lista de repositorios
                apt-get update
            fi

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
            printf "\n[+] Instalando o MEGA"
            printf "\n[+] Instalando o MEGA" >> /tmp/log.txt
            
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
        printf "\n[+] Instalando o OpenSSH"
        printf "\n[+] Instalando o OpenSSH" >> /tmp/log.txt

        apt install openssh* -y
    }

    figlet()
    {
        printf "\n"
        printf "\n[+] Instalando o Figlet"
        printf "\n[+] Instalando o Figlet" >> /tmp/log.txt

        apt install figlet -y
    }

    install_chkrootkit()
    {
        printf "\n"
        printf "\n[+] Instalando o Chkrootkit"
        printf "\n[+] Instalando o Chkrootkit" >> /tmp/log.txt

        apt install chkrootkit -y
    }

    install_localepurge()
    {
        printf "\n"
        printf "\n[+] Instalando o Localepurge"
        printf "\n[+] Instalando o Localepurge" >> /tmp/log.txt

        apt-get install localepurge -y
    }

    firewall_basic()
    {
        printf "\n"
        printf "\n[+] Instalando o Firewall UFW + GUFW" >> /tmp/log.txt

        apt install ufw gufw -y
    }

    install_hardinfo()
    {
        printf "\n"
        printf "\n[+] Instalando o Hardinfo"
        printf "\n[+] Instalando o Hardinfo" >> /tmp/log.txt

        apt install hardinfo -y
    }

    nvidia()
    {
        # variavel de verificação
        VAR_NVIDIA=$(which nvidia-settings)

        if [[ ! -e $VAR_NVIDIA ]]; then
            if [ $DISTRO == "Ubuntu" ]; then
    		    printf "\n"
    		    printf "\n[+] Instalando o driver da Placa Nvidia"
    		    printf "\n[+] Instalando o driver da Placa Nvidia" >> /tmp/log.txt

    		    apt-add-repository ppa:graphics-drivers/ppa -y
    		    apt-add-repository ppa:ubuntu-x-swat/x-updates -y
    		    apt-add-repository ppa:xorg-edgers/ppa -y
    		    update

    		    apt install nvidia-current nvidia-settings -y  
            elif [[ $DISTRO == "Debian" ]]; then
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

    virtualbox()
    {
        # variavel de verificação
        VAR_VIRTUALBOX=$(which virtualbox)

        # criando verificação para instalar o virtualbox
        if [[ ! -e $VAR_VIRTUALBOX ]]; then
            if [[ $DISTRO == "Ubuntu" ]]; then
                printf "\n"
                printf "[*] Realizando download \n"
                wget -c download.virtualbox.org/virtualbox/5.1.28/virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb

                printf "\n[*] Instalando o VirtualBox" 
                printf "\n[*] Instalando o VirtualBox" >> /tmp/log.txt
                dpkg -i virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb

                printf "[*] Corrigindo problemas de dependências \n"
                apt install -f

                printf "[*] Removendo Virtualbox \n"
                rm virtualbox-5.1_5.1.28-117968~Ubuntu~xenial_amd64.deb
            elif [[ $DISTRO == "Debian" ]]; then
                # adicionando repositorio
                sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" >> /etc/apt/sources.list.d/virtualbox.list'

                # obtendo chave
                wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -

                # atualizando sistema
                update

                # baixando virtualbox
                apt install virtualbox-5.1 -y

                # adicionando usuario ao grupo 
                gpasswd -a $USUARIO vboxusers
            fi
        else
            printf "[+] VirtualBox já está instalado! \n"
        fi
    }

    install_tree()
    {
        printf "\n"
        printf "\n[+] Instalando Tree"
        printf "\n[+] Instalando Tree" >> /tmp/log.txt

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        VAR_PULSEEFFECTS=$(which pulseeffects)

        if [[ ! -e $VAR_PULSEEFFECTS ]]; then

            printf " \n"
            printf "\n[+] Instalando o Pulse Effects"
            printf "\n[+] Instalando o Pulse Effects" >> /tmp/log.txt
            # #instalando mega
            # dpkg -i base/deb/pulseeffects_1.313entornosgnulinuxenial-1ubuntu1_amd64.deb

            # printf "[*] Resolvendo dependencias \n"
            # apt install -fy

            # printf "[*] Instalando o Pulse Effects \n"
            # # dpkg -i base/deb/pulseeffects_1.313entornosgnulinuxenial-1ubuntu1_amd64.deb

            # printf "[+] Será necessário voce ativar o Pulse Effects na inicialização do sistema \n"
            # sleep 5s

            # debian
            # # adicionando repositorio
            # echo "deb http://ppa.launchpad.net/mikhailnov/pulseeffects/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/mikhailnov-ubuntu-pulseeffects-bionic.list

            # # adicionando chave de segurança
            # apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys FE3AE55CF74041EAA3F0AD10D5B19A73A8ECB754

            # # atualizando sistema
            # update

            # # instalando pulseeffects
            # apt install pulseeffects -y

            # adicionando via flatpak
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

            # instalando via flatpak
            flatpak install flathub com.github.wwmm.pulseeffects
        else
            printf "\n"
            printf "[+] Pulse Effects já está instalado"
            printf "\n"
        fi
    }
    
    install_terminator()
    {
        printf " \n"
        printf "\n[+] Instalando o Terminator"
        printf "\n[+] Instalando o Terminator" >> /tmp/log.txt
        
        apt install terminator -y
    }

    install_aircrack()
    {
        printf " \n"
        printf "\n[+] Instalando o Aircrack-ng"
        printf "\n[+] Instalando o Aircrack-ng" >> /tmp/log.txt

        apt install aircrack-ng -y
    }

    install_snap()
    {
            printf "\n"
            printf "\n[+] Instalando Snap"
            printf "\n[+] Instalando Snap" >> /tmp/log.txt

            apt install snapd -y
    }

    install_ntp()
    {
        printf "\n"
        printf "\n[+] Instalando o NTP"
        printf "\n[+] Instalando o NTP" >> /tmp/log.txt

        #instalando software necessario
        apt install ntp ntpdate -y
    }

    install_xclip()
    {
        printf "\n"
        printf "\n[+] Instalando Xclip"
        printf "\n[+] Instalando Xclip" >> /tmp/log.txt

        apt install xclip -y
    }

    install_espeak()
    {
    	printf "\n"
        printf "\n[+] Instalando speak"
        printf "\n[+] Instalando speak" >> /tmp/log.txt

        apt install espeak -y	
    }

# # # # # # # # # #
# # PROGRAMAS NÃO ESSENCIAIS

    apache()
    {
        printf "\n"
        printf "\n[+] Instalando o Apache"
        printf "\n[+] Instalando o Apache" >> /tmp/log.txt

        apt install apache2 -y
        service apache2 restart
    }

    install_mysql()
    {
        printf "\n"
        printf "\n[+] Instalando o Mysql Server"
        printf "\n[+] Instalando o Mysql Server" >> /tmp/log.txt

        apt install mysql-server mysql-server -y
    }

    phpmyadmin()
    {
        printf "\n"
        printf "\n[+] Instalando o PhpMyAdmin"
        printf "\n[+] Instalando o PhpMyAdmin" >> /tmp/log.txt

        apt install php phpmyadmin -y
    }

    ibus()
    {
        printf "\n"
        printf "\n[+] Instalando o Ibus"
        printf "\n[+] Instalando o Ibus" >> /tmp/log.txt

        apt install ibus -y
    }

    install_nmap()
    {
        printf "\n"
        printf "\n[+] Instalando o Nmap"
        printf "\n[+] Instalando o Nmap" >> /tmp/log.txt

        apt install nmap -y
    }

    htop()
    {
        printf "\n"
        printf "\n[+] Instalando o Htop" >> /tmp/log.txt

        apt install htop -y
    }

    install_sudo()
    {
        printf "\n"
        printf "\n[+] Instalando o Sudo" >> /tmp/log.txt

        apt install sudo -y
    }

    tuxguitar()
    {
        # variavel de verificação
        var_tuxguitar=$(which tuxguitar-vs)

        # criando verificação para instalar o tuxguitar
        if [[ ! -e $var_tuxguitar ]]; then
            printf "\n"
            printf "\n[+] Instalando Tux Guitar"
            printf "\n[+] Instalando Tux Guitar" >> /tmp/log.txt

			snap install tuxguitar-vs
		else
			printf "[+] TuxGuitar já está instalado \n"
		fi
	}

    muse_score()
    {
        # variavel de verificação
        VAR_MUSESCORE=$(which musescore)

        # criando verificação para instalar o docker
        if [[ ! -e $VAR_MUSESCORE ]]; then
            printf "\n"
            printf "\n[+] Instalando Muse Score"
            printf "\n[+] Instalando Muse Score" >> /tmp/log.txt

            snap install musescore
        else
            printf "\n"
            printf "\n[+] O Musescore já está instalado no seu sistema."
        fi
    }

    install_zsh()
    {
        printf "\n"
        printf "\n[+] Instalando o ZSH"
        printf "\n[+] Instalando o ZSH" >> /tmp/log.txt

        apt install zsh -y

        printf "\n[*] Modificando bash padrao para zsh"
        # chsh -s /usr/bin/zsh
        chsh -s $(which zsh)

        printf "\n[+] Seu interpretador de comandos foi alterado para o ZSH!!"
    }

    install_docker()
    {
        # variavel de verificação
        VAR_DOCKER=$(which docker)

        # criando verificação para instalar o docker
        if [[ ! -e $VAR_DOCKER ]]; then
            printf "\n"
            printf "\n[+] Instalando o Docker" >> /tmp/log.txt

            curl -fsSL https://get.docker.com/ | sh
        else
            printf "\n"
            printf "\n[+] O Docker já está instalado no seu sistema."
        fi

        # removendo docker 
        # apt purge docker-ce -y
    }

    install_sublime()
    {
        printf "\n"
        printf "\n[+] Instalando o Sublime"
        printf "\n[+] Instalando o Sublime" >> /tmp/log.txt

        if [ $DISTRO == "Ubuntu" ]; then
            wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - 
            apt install apt-transport-https -y 
            echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
            
            update  
            
            apt install sublime-text -y

        elif [ $DISTRO == "Debian" ]; then
        	# apt-get install snapd snapd-xdg-open
        	snap install sublime-text-3 --classic --candidate
        	# snap refresh sublime-text-3
        fi
    }

    firmware()
    {
    	printf "\n"
        printf "\n[+] Instalando firmware's non-free" >> /tmp/log.txt        
    	apt install firmware-linux firmware-linux-nonfree -y

    	#verificando variavel
        if [[ $V_HOSTNAME == 'notebook' ]]; then
            printf "\n"
            printf "\n[+] Instalando firmware Wifi" >> /tmp/log.txt

            apt install firmware-brcm80211 -y
        fi
	}	

    install_python()
    {
        printf "\n"
        printf "\n[+] Instalando pip" >> /tmp/log.txt        

        apt-get install python3.5 python-pip -y
    }

# # # # # # # # # #

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_atualiza()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Atualizando"
    fi

    clear
    update
    upgrade
}

func_corrige()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Corrigindo"
    fi

	if [ $DISTRO == "Ubuntu" ]; then
	    clear

	    #verificando variavel
	    if [[ $V_HOSTNAME == 'desktop' ]]; then
	        clear
	        apt_check
	        apt_install
	        apt_remove
	        apt_clean
	        apt_auto
	        apt_update_local
	        # swap
	        prelink_preload_deborphan
	        pacotes_quebrados
	        fonts
	        config_ntp
	        apport
	        # repositorios_padrao
	        log_sudo
	        lightdm
	        arquivo_hosts
	        chaveiro
	        install_xclip
            atualiza_db
	    elif [[ $V_HOSTNAME == 'notebook' ]]; then
	        clear
	        apt_check
	        apt_install
	        apt_remove
	        apt_clean
	        apt_auto
	        apt_update_local
	        # swap
	        prelink_preload_deborphan
	        pacotes_quebrados
	        fonts
	        config_ntp
	        apport
	        # repositorios_padrao
	        log_sudo
            atualiza_db
	    else
	        clear
	        apt_check
	        apt_install
	        apt_remove
	        apt_clean
	        apt_auto
	        apt_update_local
	        # swap
	        prelink_preload_deborphan
	        pacotes_quebrados
	        fonts
	        config_ntp
	        apport
	        # repositorios_padrao
	        log_sudo
            atualiza_db
	    fi
	elif [[ $DISTRO == "Debian" ]]; then
		apt_install
        fonts
        config_ntp
        repositorios_padrao
        arquivo_hosts
        chaveiro
        install_xclip
        atualiza_db
	else
		printf "\n[-] ERRO CORRIGE!"
	fi

    # realizando atualização
    update
}

func_limpa()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Limpando"
    fi

    clear
    pacotes_orfaos
    funcao_chkrootkit
    func_localepurge
}

func_instala()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Instalando"
    fi

	if [ $DISTRO == "Ubuntu" ]; then		
	    clear	  

	    if [[ $V_HOSTNAME == 'notebook' ]]; then
	#               PERSONALIZAÇÃO
	        # icones_mac
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
	        install_hardinfo

	#               NAVEGADORES
	        firefox
	        chromium
	        tor

	#               JOGOS
	        visual_game_boy
	        wine
	        playonlinux

	#               ASTRONOMIA
	        stellarium

	#               MULTIMIDIA
	        spotify
	        clementine
	        vlc
	        audacity

	#               DESENVOLVIMENTO
	        kate
	        install_git
	        install_sublime
	        install_snap

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
	        install_xclip
            install_python

	#               OFFICE
	        libreoffice

	    else
	#               PERSONALIZAÇÃO
	        nvidia
	        # icones_mac
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
	        figlet
	        install_hardinfo

	#               NAVEGADORES
	        firefox
	        chromium
	        tor

	#               JOGOS
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
	        simple_screen_recorder

	#               MUSICA
	        tuxguitar
	        muse_score

	#               DESENVOLVIMENTO
	        kate
	        install_git
	        install_terminator
	        install_sublime
	        install_snap
            install_python

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
	        install_ntp
	        install_xclip
	        install_espeak

	#               OFFICE
	        libreoffice
	    fi

    elif [ $DISTRO == "Debian" ]; then
    	firefox
    	chromium
    	tor

    	xfce4
        nautilus
        redshift
        plank
        install_git
        openssh
    	spotify
    	steam
        vlc
        codecs
        gnome3-system-monitor
        kate
        screenfetch
        htop                
        firmware
        clementine
        gparted
        install_git
        lm-sensors
        stellarium
        kstars
        gnome_terminal
        sweethome3d
        gnome_system_monitor
        gnome_disk_utility
        audacity
        simple_screen_recorder
        openssh
        figlet        
        firewall_basic
        # tuxguitar
        # muse_score
        xclip        

        install_sudo
        install_nmap
        # install_docker
        install_snap
        install_ntp
    	install_terminator    	
    	install_xclip
    	install_espeak
    	install_sublime    	
        install_tree
        install_ntp
        install_localepurge
        install_hardinfo
        install_python

    else
		printf "\n[-] ERRO INSTALA!"
	fi	
}

func_instala_outros()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Instalando outros"
    fi

	# desenvolvimento
    apache
    install_mysql
    phpmyadmin
    install_zsh
    #install_docker  
    wireshark    
    # teclado
    ibus

# personalizacao
    install_pulseeffects

    # verificando computador
    if [[ $ == 'desktop' ]]; then
        # outros
        virtualbox

        # jogos
        steam
    fi
}

func_remove()
{
    ## verificando valor variavel
    if [ $VAR_MUDO == "0" ]; then
        espeak -vpt-br "Removendo programas"
    fi

	printf "\n\n[+] Removendo programas" >> /tmp/log.txt

    printf "\n"
    printf "[+] Removendo XBurn \n"
    apt purge xfburn -y

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
    printf "[+] Removendo o Inkscape \n"
    apt purge inkscape* -y


    printf "\n"
    printf "[+] Removendo o Adapta \n"
    apt purge adapta-gtk-theme* -y


    printf "\n"
    printf "[+] Removendo o Blender \n"
    apt purge blender* -y

    printf "\n"
    printf "[+] Removendo o Exfalso \n"
    apt purge exfalso* -y

    printf "\n"
    printf "[+] Removendo o Quodlibet \n"
    apt purge quodlibet* -y

    printf "\n"
    printf "[+] Removendo o XTerm \n"
    apt purge xterm* -y
    
    if [[ $V_HOSTNAME == 'notebook' ]]; then
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

    texmaker
    
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

    # necessario interação com o usuario, se ativa não irá fazer tudo automatico
    func_instala_outros

    # removendo programas pré-instalados, desnecessários
    func_remove

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza
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
    case $ESCOLHAAUTO_CONFIG in

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
            printf "\nAlternativa incorreta!!"
            sleep 1s #1 segundo
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
    case $ESCOLHAAUTO_CONFIG in

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### ATUALIZA SISTEMA
        1) printf
                func_atualiza

                auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### CORRINDO PROBLEMAS
        2) printf
                func_corrige

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
                func_instala

                auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### PROGRAMAS NAO ESSENCIAIS
        5) printf
                func_instala_outros                

                auto_config
        ;;

    # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
    ###### REMOVENDO PROGRAMAS
        6) printf
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
    echo "Digite 1 para atualizar o sistema,"
    echo "Digite 2 para corrigir possíveis erros,"
    echo "Digite 3 para realizar uma limpeza,"
    echo "Digite 4 para instalar alguns programas,"
    echo "Digite 5 para instalar programas não essenciais,"
    echo "Digite 6 para remover alguns programas,"
    echo "Digite 7 para sair do script,"
    echo "-------------------------------------------------"
    read -n1 -p "Número da ação:" ESCOLHAAUTO_CONFIG

    #executando ações para a distribuição Ubuntu
    if [ $DISTRO == "Ubuntu" ]; then
        clear
        auto_config_ubuntu
    #executando ações para a distribuição Fedora
    elif [ $DISTRO == "Debian" ]; then
        clear
        auto_config_debian
    else
        printf "Disponivel para Debian ou Ubuntu!!! \n"
        printf "Script incompativel infelizmente \n"
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
    func_help
fi

## manipulando parametros - parametro acao/mudo(boolean)
for i in "$@"; do
    # verificando o que foi digitado
    case $i in
        menu) auto_config;;
        atualiza) func_atualiza;;
        corrige) func_corrige;;
        limpa) func_limpa;;
        instala) func_instala;;
        instala_outros) func_instala_outros;;
        remove) func_remove;;
        formatado) func_formatado;;
        todas) func_todas;;
        nvidia) nvidia;;
        texmaker) texmaker;;
    esac    

    # alterando valor - funcoes em silencio
    if [ $i == "mudo" ]; then
        VAR_MUDO=1
    fi
done

# mostrando data/hora log inicilização script	
date > /tmp/log.txt

# mostrando informacoes da distro
lsb_release -a >> /tmp/log.txt

## verificando valor VAR_MUDO 
if [ $VAR_MUDO == "0" ]; then
    espeak -vpt-br "Finalizado!!"
fi

# mostrando data/hora log finalização script
echo >> /tmp/log.txt
date >> /tmp/log.txt

#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
