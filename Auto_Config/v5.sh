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
# por kskarthik - How to enable auto-login in Debian 9 Xfce
#	<https://steemit.com/software/@kskarthik/how-to-enable-auto-login-in-lightdm>
#
# por Edpsblog - How-To :: Wine Development no Debian e derivados
#	<https://edpsblog.wordpress.com/2015/10/24/how-to-wine-development-no-debian-e-derivados/>
#
# por Debian Sources List Generator
#	<https://debgen.simplylinux.ch/index.php>
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
# # data de criação do script:    [09/05/18]      #             
# # ultima ediçao realizada:      [17/05/18]      #
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
#				- I  - [VERIFICAR-DEBIAN]: Wine, Tor, VisualGame Boy
# 	e = pendencias
#               - I  - [VETOR]  - Verificar vetor funcoes
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
#   - Xubuntu 17.10 - OBS: Não aconselhável utilização, pois há incompatibilidades de softwares.
#   - Debian 8		- OBS: Não aconselhável utilização, pois há incompatibilidades de softwares.
#   - Debian 9
#
# # Compativel com
#   - Xubuntu 16.04 - LTS -	[SCRIPT ESTAVEL]
#   - Debian 9			  -	[SCRIPT ESTAVEL]
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # VARIAVEIS DE AMBIENTE
# Criando variavel com localização da raiz do usuario
# usuario sistema
    usuario="lenonr"                    # nome usuario sistema

# pasta do usuario
    pasta_home="/home/$usuario/"        # pasta home usuario do sistema 

# verificando distro
    distro=$(lsb_release -i | cut -f2)  # Ubuntu ou Debian

# capturando hostname da maquina
    v_hostname=$(hostname)              # Funções configuradas a partir de valores -desktop ou notebook-

# espeak habilitado
    var_mudo=1                          # valor padrao = mudo desativado

# login automatico distros
	boolean_autologin=1					# login automatico, caso queria desativar basta alterar para 0

# logo para ser mostrado no script
	logo="figlet AUTOCONFIG-V5"			# logo do script

# versao do script
VERSAO="0.0.70.0.1.0"             

# # # # # CRIANDO FUNÇÕES PARA EXECUÇÃO
#
# vetor de atualizacao
ATUALIZA=(update upgrade)

# vetor de correcao
CORRIGE=(apt_check apt_install apt_remove \
         apt_clean apt_auto apt_update_local \
         swap prelink_preload_deborphan \
         pacotes_quebrados config_ntp \
         apport repositorios_padrao \
         arquivo_hosts chaveiro atualiza_db \
         autologin icones_temas)

# vetor de limpeza
LIMPA=(arquivos_temporarios pacotes_orfaos \
       funcao_chkrootkit func_localepurge)

# vetor instala
INSTALA=(install_firefox install_chromium install_vivaldi \
        install_steam install_spotify install_codecs \
        install_funcao_gimp install_xfce4 install_wine \
        install_playonlinux install_redshift install_libreoffice \
        install_vlc install_clementine install_gparted \
        install_tlp install_git install_lm-sensors \
        install_stellarium install_texmaker install_kstars \
        install_reaver install_tor install_dolphin \
        install_visualgameboy install_screenfetch \
        install_kdenlive install_sweethome3d \
        install_cheese install_plank install_gnome_system_monitor \
        install_nautilus install_wireshark install_gnome_disk_utility \
        install_audacity install_simple_screen_recorder \
        install_mega install_openssh install_figlet install_chkrootkit \
        install_localepurge install_firewall_basic install_hardinfo \
        install_nvidia install_virtualbox install_ristretto install_tree \
        install_pulseeffects install_terminator install_aircrack \
        install_snap install_ntp install_xclip install_espeak \
        install_ibus install_nmap install_htop install_gnome_calculator \
        install_tuxguitar install_muse_score install_zsh \
        install_docker install_sublime install_firmware \
        install_compton install_xfburn install_dropbox install_transmission \
        install_python)

# vetor instala outros
INSTALA_OUTROS=(install_apache install_mysql install_phpmyadmin)

#
# # # # # # # # # #
#
# criando funcoes para serem executadas como parametros
func_help()
{
    clear
    printf "############################################################################\n"
    printf "\n"
	$logo
	printf "\n"
    printf "############################################################################

    Bem vindo ao script de automação de tarefas no Linux. 

    Ele poderá realizar:
        - Atualização do sistema;
        - Correção de erros;
        - Limpeza geral do sistema;
        - Instalação de programas;
        - Remoção de programas desnecessários;

    Exemplos:        
        - Funcoes do script:
            ~ v4.sh [atualiza/corrige/limpa/instala/instala_outros/menu]

        - Após a maquina ser formatada(apenas as funções automáticas e depois desliga a máquina)
            ~ v4.sh formatado

        - Para executar todas as funções(semi-automático)
            ~ v4.sh todas

        - Para executar um funcao especifica basta:
            ~ v4.sh vetor nomefuncao
                [BUSCANDO FUNCAO]
                ~v4.sh vetor help [atualiza/corrige/limpa/instala]

        - Para executar todas as funções em silêncio, basta adicionar o parametro 'mudo' antes de qualquer outro ao iniciar o script.  

    **      SCRIPT COMPATIVEL COM UBUNTU 16.04 | DEBIAN 9    **

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
        if [ $distro == "Ubuntu" ]; then            
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
		        apt upgrade dist-upgrade full-upgrade -y
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
        
        rm -rf /var/lib/dpkg/info/*.*

        apt-get clean 
        apt-get install -f

        update
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
        apt list --upgradable
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
        deborphan | xargs apt-get -y remove --purge &&
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

        apt install ttf-mscorefonts-installer fonts-noto ttf-freefont -f 
    }    

    config_ntp()
    {
        printf "\n[+] Configurando o NTP"
        printf "\n[+] Configurando o NTP" >> /tmp/log.txt

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
        printf "\n[+] Atualizando hora do servidor"
        printf "\n[*] Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"

        printf "\n[+] Atualizando servidores, aguarde..."
        printf "\n[*] NIC.BR\n"
            ntpdate -q pool.ntp.br

		if [[ $? == "0" ]]; then
        	printf "\n[+] Hora do servidor atualizada!\n"
        	printf "\n[+] Hora do servidor atualizada!\n" >> /tmp/log.txt
        else
        	printf "\n[-] Erro - Hora do servidor!\n"
        	printf "\n[-] Erro - Hora do servidor!\n" >> /tmp/log.txt
        fi    
    }

    apport()
    {
        printf "\n[+] Removendo possiveis erros com o apport \n"
        printf "\n[+] Removendo possiveis erros com o apport \n" >> /tmp/log.txt

        #corrige apport - ubuntu 16.04
        cat base/ubuntu/apport > /etc/default/apport
    }   

    repositorios_padrao()
    {
        # verificando distribuição
        if [ $distro == "Ubuntu" ]; then
            printf "\n[+] Alterando lista de repositórios padrão"
            printf "\n[+] Alterando lista de repositórios padrão" >> /tmp/log.txt

            cat base/ubuntu/sources.list > /etc/apt/sources.list
        elif [ $distro == "Debian" ]; then
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
        printf "\n[+] Alterando arquivo Hosts"
        printf "\n[+] Alterando arquivo Hosts" >> /tmp/log.txt

        # verificando computador
        if [[ $v_hostname == 'desktop' ]]; then
            cat base/hosts_desktop > /etc/hosts
        elif [[ $v_hostname == 'notebook' ]]; then
            cat base/hosts_notebook > /etc/hosts
        else
            printf "\n[-] Verificar arquivo hosts"
            printf "\n[-] Verificar arquivo hosts" >> /tmp/log.txt
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
        local var_locate=$(which locate)

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

    autologin()
    {    	
    	if [[ $boolean_autologin == "1" ]]; then
    		local var_autologin="/usr/share/lightdm/lightdm.conf.d/01_debian.conf"

	        # verificando se existe "autologin-user=$usuario" no arquivo '/etc/lightdm/lightdm.conf'
	        # var_autologin=$(cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario")        
	        # cat /etc/lightdm/lightdm.conf | grep "autologin-user=$usuario" > /dev/null        

	        cat $var_autologin | grep "autologin-user=$usuario" > /dev/null

	        # se saida do echo $? for 1, entao realiza modificacao
	        # if [[ $var_autologin == "1" ]]; then
	        if [[ $? == "1" ]]; then	
	        	if [[ $distro == "Debian" ]]; then             
	                printf "\n[+] Habilitando login automatico" 
	                printf "\n[+] Habilitando login automatico" >> /tmp/log.txt

	                echo "autologin-user=$usuario" >> $var_autologin
	                echo "autologin-user-timeout=0" >> $var_autologin

	                printf "\n[*] Reconfigurando lightdm, aguarde!" 
	                dpkg-reconfigure lightdm 

	                if [[ $? == "0" ]]; then
	                	printf "\n[+] Configuraçao atualizada com sucesso"
	                else
	                	printf "\n[-] Erro na configuracao - Autologin"
	                fi

		        elif [[ $distro == "Ubuntu" ]]; then 
		            printf "\n[+] Iniciando sessão automaticamente"
		            printf "\n[+] Iniciando sessão automaticamente" >> /tmp/log.txt

		            cat base/ubuntu/lightdm.conf > /etc/lightdm/lightdm.conf
		        else
		        	printf "\n[-] Erro autologin"
		        	printf "\n[-] Erro autologin" >> /tmp/log.txt
		        fi  
	        else
				printf "[-] Login ja esta habilitado"
	            printf "[-] Login ja esta habilitado" >> /tmp/log.txt
	        fi
    	else
    		printf "\n[-] O login automatico esta desabilitado! Verificar script."
    		printf "\n[-] O login automatico esta desabilitado! Verificar script. " >> /tmp/log.txt
    	fi    	
    }

    icones_temas()
    {    	
		# personalizacao
	    var_icones_macos="/usr/share/themes/MacBuntu-OS/"
		var_breeze="/usr/share/icons/Breeze"
		var_flatremix="/usr/share/icons/Flat_Remix_Light"
		var_papirus="/usr/share/icons/Papirus_Light"

		if [ -e $var_breeze ]; then 			
			printf "\n[-] Voce ja possui os arquivos Breeze!"
    		printf "\n[-] Voce ja possui os arquivos Breeze!" >> /tmp/log.txt
    	else    		
    		printf "\n[+] Copiando icones Breeze"
			printf "\n[+] Copiando icones Breeze" >> /tmp/log.txt

    		cp -r ../Configuracoes/Interface/icons/Breeze /usr/share/icons
    	fi

    	if [ -e $var_flatremix ]; then 
    		printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!"
    		printf "\n[-] Voce ja possui os arquivos Flat_Remix_Light!" >> /tmp/log.txt
    	else    		
    		printf "\n[+] Copiando icones Flat_Remix_Light"
    		printf "\n[+] Copiando icones Flat_Remix_Light" >> /tmp/log.txt

    		cp -r ../Configuracoes/Interface/icons/Flat_Remix_Light /usr/share/icons
    	fi

		if [ -e $var_papirus ]; then 
			printf "\n[-] Voce ja possui os arquivos Papirus_Light!"
	    	printf "\n[-] Voce ja possui os arquivos Papirus_Light!" >> /tmp/log.txt
	    else	    	
	    	printf "\n[+] Copiando icones Papirus_Light"
			printf "\n[+] Copiando icones Papirus_Light" >> /tmp/log.txt

	    	cp -r ../Configuracoes/Interface/icons/Papirus_Light /usr/share/icons
    	fi

    	if [ -e $var_icones_macos ]; then 
    		printf "\n[-] Voce ja possui os arquivos MacOS X!"
			printf "\n[-] Voce ja possui os arquivos MacOS X!" >> /tmp/log.txt
		else	
			printf "\n[+] Copiando icones MacOS X"
    		printf "\n[+] Copiando icones MacOS X" >> /tmp/log.txt

			cp -r ../Configuracoes/Interface/themes/* /usr/share/themes
		fi
    }

# # # # # # # # # #
# # LIMPA SISTEMA
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
    install_firefox()
    {   
        printf "\n"
        printf "\n[+] Instalando Firefox"
        printf "\n[+] Instalando Firefox" >> /tmp/log.txt

		if [[ $distro == "Ubuntu" ]]; then
        	apt install firefox -y
        elif [[ $distro == "Debian" ]]; then
            apt install -t sid firefox -y
        fi            
    }

    install_chromium()
    {              
        local var_chromium=$(which chromium)        
        local var_chromium1=$(which chromium-browser)

        if [[ $distro == "Debian" ]]; then 
	        if [[ ! -e $var_chromium ]]; then
	            printf "\n[+] Instalando o Chromium"
	            printf "\n[+] Instalando o Chromium" >> /tmp/log.txt

	            apt install chromium* -y
	            # snap install chromium
	        else
	            printf "\n[+] Chromium ja esta instalado"
	            printf "\n[+] Chromium ja esta instalado" >> /tmp/log.txt                
	        fi	
        elif [[ $distro == "Ubuntu" ]]; then 
	        if [[ ! -e $var_chromium1 ]]; then
	            printf "\n[+] Instalando o Chromium"
	            printf "\n[+] Instalando o Chromium" >> /tmp/log.txt

	            snap install chromium
	        else
	            printf "\n[+] Chromium ja esta instalado"
	            printf "\n[+] Chromium ja esta instalado" >> /tmp/log.txt                
	        fi	
	    else
	    	printf "\n[-] Erro instalação Chromium"
	    	printf "\n[-] Erro instalação Chromium" >> /tmp/log.txt
fi 	        
    }

    install_vivaldi()
    {
    	local var_vivaldi=$(which vivaldi)        

        if [[ ! -e $var_vivaldi ]]; then
            printf "\n"
            printf "\n[+] Instalando Vivaldi"
            printf "\n[+] Instalando Vivaldi" >> /tmp/log.txt

	    	wget https://downloads.vivaldi.com/stable/vivaldi-stable_1.14.1077.55-1_amd64.deb

	    	dpkg -i vivaldi-stable_1.14.1077.55-1_amd64.deb

	    	apt --fix-broken install -y

			dpkg -i vivaldi-stable_1.14.1077.55-1_amd64.deb  

			rm vivaldi-stable_1.14.1077.55-1_amd64.deb  
		else
			printf "\n[+] Vivaldi ja esta instalado" >> /tmp/log.txt			  	
		fi
    }

    install_tor()
    {
        # variavel de verificação
        local var_tor=$(which tor)

        if [[ ! -e $var_tor ]]; then
            printf "\n"
            printf "\n[+] Instalando o Tor"
            printf "\n[+] Instalando o Tor" >> /tmp/log.txt

            # verificando distribuição
            if [ $distro == "Ubuntu" ]; then
                # ubuntu 16.04
	            #adicionando repositorio
	            add-apt-repository ppa:webupd8team/tor-browser -y

	            #atualizando lista de pacotes
	            update

	            #instalando tor
	            apt-get install tor tor-browser -y
                # apt install tor torbrowser-launcher -y

            # elif [ $distro == "Debian" ]; then
            #     # debian 9                
            #     # adicionando repositorio
            #     printf "deb http://deb.debian.org/debian stretch-backports main contrib" > /etc/apt/sources.list.d/stretch-backports.list

            #     # atualizando sistema
            #     update

            #     # instalando tor
            #     apt install tor torbrowser-launcher -t stretch-backports
            else
            	printf "\n[-] ERRO TOR"
            	printf "\n[-] ERRO TOR" >> /tmp/log.txt
            fi

        else
            printf "\n"
            printf "[+] Tor já está instalado! \n" 
        fi           
    }

    install_steam()
    {
        printf "\n"
        printf "\n[+] Instalando Steam"
        printf "\n[+] Instalando Steam" >> /tmp/log.txt

		# instalando dependencias steam - DEBIAN 9
		if [[ $distro == "Debian" ]]; then 
			# adicionando arquitetura/dependencia      	
			dpkg --add-architecture i386		

			# atualizando sistema			
			update

			# instalando nvidia
			apt install libgl1-nvidia-glx:i386 -y		
		fi		

        apt install steam -y
    }

    install_spotify()
    {
        # variavel de verificação
        local var_spotify=$(which spotify)

        if [[ ! -e $var_spotify ]]; then
            printf "\n"
            printf "\n[+] Instalando Spotify" >> /tmp/log.txt

            if [[ $distro == "Ubuntu" ]]; then 
				snap install spotify -y 		         
			elif [[ $distro == "Debian" ]]; then 
				apt install dirmngr -y
				apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410	
				echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list

				update

				apt install spotify-client -y
			fi			            	
        else
            printf "[+] Spofity já está instalado! \n"
        fi
    }   

    install_codecs()
    {
        printf "\n"
        printf "\n[+] Instalando Pacotes Multimidias (Codecs)"
        printf "\n[+] Instalando Pacotes Multimidias (Codecs)" >> /tmp/log.txt

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
        prelink deborphan oracle-java7-installer lame libavcodec-extra libav-tools -y --force-yes    
    }

    install_funcao_gimp()
    {
     	# variavel de verificação
        local var_gimp=$(which gimp)

        if [[ ! -e $var_gimp ]]; then
            printf "\n"
            printf "\n[+] Instalando o Gimp"
            printf "\n[+] Instalando o Gimp" >> /tmp/log.txt

            apt install gimp -y
        else
            printf "\n"
            printf "[+] Gimp já está instalado na sua máquina! \n"
        fi
    }

    install_xfce4()
    {
        printf "\n"
        printf "\n[+] Instalando adicionais do XFCE" 
        printf "\n[+] Instalando adicionais do XFCE" >> /tmp/log.txt

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
            printf "\n[+] Instalando Xfpanel-switch"
            printf "\n[+] Instalando Xfpanel-switch" >> /tmp/log.txt

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
            printf "\n[+] Instalando Whisker-menu"
            printf "\n[+] Instalando Whisker-menu" >> /tmp/log.txt

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
            printf "\n[+] Instalando o Wine" >> /tmp/log.txt

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

				# instalando wine
            	apt install wine-development ttf-mscorefonts-installer -y
            else
            	printf "\n[-] Erro ao instalar Wine"
            	printf "\n[-] Erro ao instalar Wine" >> /tmp/log.txt
            fi

            # verificar funcao debian
        else
            printf "\n"
            printf "[+] Wine já está instalado na sua máquina! \n"
        fi
    }

    install_playonlinux()
    {
        printf "\n"
        printf "\n[+] Instalando o PlayonLinux"
        printf "\n[+] Instalando o PlayonLinux" >> /tmp/log.txt

        apt install playonlinux -y
    }

    install_redshift()
    {
        printf "\n"
        printf "\n[+] Instalando o Redshift"
        printf "\n[+] Instalando o Redshift" >> /tmp/log.txt

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
            printf "\n[+] Instalando o Libreoffice"
            printf "\n[+] Instalando o Libreoffice" >> /tmp/log.txt

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
        printf "\n[+] Instalando o VLC"
        printf "\n[+] Instalando o VLC" >> /tmp/log.txt

        apt install vlc -y
    }

    install_clementine()
    {
        printf "\n"
        printf "\n[+] Instalando o Clementine"
        printf "\n[+] Instalando o Clementine" >> /tmp/log.txt

        apt install clementine -y
    }

    install_gparted()
    {
        printf "\n"
        printf "\n[+] Instalando o Gparted"
        printf "\n[+] Instalando o Gparted" >> /tmp/log.txt

        apt install gparted -y
    }

    install_tlp()
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

    install_lm-sensors()
    {
        printf "\n"
        printf "\n[+] Instalando o Lm-sensors"
        printf "\n[+] Instalando o Lm-sensors" >> /tmp/log.txt

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

    install_texmaker()
    {
        printf "\n"
        printf "\n[+] Instalando o Texmaker"
        printf "\n[+] Instalando o Texmaker" >> /tmp/log.txt

        apt install texmaker* texlive-full* texlive-latex-extra* -y
        apt install aspell aspell-pt-br -y
    }

    install_kstars()
    {
        printf "\n"
        printf "\n[+] Instalando o Kstars"
        printf "\n[+] Instalando o Kstars" >> /tmp/log.txt

        apt install kstars* -y
    }

    install_reaver()
    {
        printf "\n"
        printf "\n[+] Instalando o Reaver"
        printf "\n[+] Instalando o Reaver" >> /tmp/log.txt

        apt install reaver -y
    }  

    install_dolphin()
    {
        printf "\n"
        printf "\n[+] Instalando o Dolphin"
        printf "\n[+] Instalando o Dolphin" >> /tmp/log.txt

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
        printf "\n[+] Instalando o Visual Game Boy"
        printf "\n[+] Instalando o Visual Game Boy" >> /tmp/log.txt 

        if [[ $distro == "Ubuntu" ]]; then
        	apt install visualboyadvance-gtk -y
        elif [[ $distro == "Debian" ]]; then
        	apt install visualboyadvance -y
        else
        	printf "[-] ERRO - VisualGame"
        	printf "[-] ERRO - VisualGame" >> /tmp/log.txt
        fi
    }

    install_screenfetch()
    {
        printf "\n"
        printf "\n[+] Instalando o Screenfetch"
        printf "\n[+] Instalando o Screenfetch" >> /tmp/log.txt

        apt install screenfetch -y
    }

    install_kdenlive()
    {
        # variavel de verificação
        local var_kdenlive=$(which kdenlive)

        if [[ ! -e $var_kdenlive ]]; then
            printf "\n"
            printf "\n[+] Instalando o Kdenlive"
            printf "\n[+] Instalando o Kdenlive" >> /tmp/log.txt

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
        printf "\n[+] Instalando Sweet Home 3D"
        printf "\n[+] Instalando Sweet Home 3D" >> /tmp/log.txt

        apt install sweethome3d -y
    }

    install_cheese()
    {
        printf "\n"
        printf "\n[+] Instalando o Cheese"
        printf "\n[+] Instalando o Cheese" >> /tmp/log.txt

        apt install cheese -y
    }

    install_plank()
    {
        # variavel de verificação
        local var_plank=$(which plank)

        if [[ ! -e $var_plank ]]; then
            printf "\n"
            printf "\n[+] Instalando o Plank Dock"
            printf "\n[+] Instalando o Plank Dock" >> /tmp/log.txt

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
        printf "\n[+] Instalando o Gnome System Monitor"
        printf "\n[+] Instalando o Gnome System Monitor" >> /tmp/log.txt

        apt install gnome-system-monitor -y
    }

    install_nautilus()
    {
        # variavel de verificação
        local var_nautilus=$(which nautilus)

        if [[ ! -e $var_nautilus ]]; then
            printf "\n"
            printf "\n[+] Instalando o Nautilus"
            printf "\n[+] Instalando o Nautilus" >> /tmp/log.txt

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
        printf "\n[+] Instalando o Wireshark"
        printf "\n[+] Instalando o Wireshark" >> /tmp/log.txt

        apt install wireshark -y
    }

    install_gnome_disk_utility()
    {
        printf "\n"
        printf "\n[+] Instalando o Gnome Disk Utility"
        printf "\n[+] Instalando o Gnome Disk Utility" >> /tmp/log.txt

        apt install gnome-disk-utility -y
    }

    install_audacity()
    {
        printf "\n"
        printf "\n[+] Instalando o Audacity"
        printf "\n[+] Instalando o Audacity" >> /tmp/log.txt

        apt install audacity -y
    }

    install_simple_screen_recorder()
    {
        # variavel de verificação
        local var_simplescreenrecorder=$(which simplescreenrecorder)

        if [[ ! -e $var_simplescreenrecorder ]]; then
            printf "\n"
            printf "\n[*] Instalando o Simple Screen Recorder"
            printf "\n[*] Instalando o Simple Screen Recorder" >> /tmp/log.txt

            if [[ $distro == "Ubuntu" ]]; then
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

    install_mega()
    {       
        # variavel de verificação
        local var_mega=$(which megasync)

        if [[ ! -e $var_mega ]]; then        
            printf "\n"
            printf "\n[+] Instalando o MEGA"
            printf "\n[+] Instalando o MEGA" >> /tmp/log.txt
            
            if [[ $distro == "Ubuntu" ]]; then
	            # instalando mega
	            dpkg -i base/packages/mega/*.deb

	            # corrigindo dependencias
	            apt install -fy

	            # instalando mega
	            dpkg -i base/packages/mega/*.deb
	        elif [[ $distro == "Debian" ]]; then
	        	# adicionando chaves
	        	apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 4B4E7A9523ACD201
				apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 74A941BA219EC810
				apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 818A435C5FCBF54A

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
        printf "\n[+] Instalando o OpenSSH"
        printf "\n[+] Instalando o OpenSSH" >> /tmp/log.txt

        apt install openssh* -y
    }

    install_figlet()
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

    install_firewall_basic()
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

    install_nvidia()
    {
        # variavel de verificação
        local var_nvidia=$(which nvidia-settings)

        if [[ ! -e $var_nvidia ]]; then
            if [ $distro == "Ubuntu" ]; then
    		    printf "\n"
    		    printf "\n[+] Instalando o driver da Placa Nvidia"
    		    printf "\n[+] Instalando o driver da Placa Nvidia" >> /tmp/log.txt

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
            printf "[*] Instalando Virtualbox \n"

            apt install virtualbox-5.1 -y
        else
            printf "[+] VirtualBox já está instalado! \n"
        fi
    }

    install_ristretto()
    {
    	printf "\n"
        printf "\n[+] Instalando o Ristretto"
        printf "\n[+] Instalando o Ristretto" >> /tmp/log.txt	

        apt install ristretto -y
    }

    install_tree()
    {
        printf "\n"
        printf "\n[+] Instalando o Tree"
        printf "\n[+] Instalando o Tree" >> /tmp/log.txt

        apt install tree -y
    }

    install_pulseeffects()
    {
        # variavel de verificação
        local var_pulseeeffects=$(which pulseeffects)

        if [[ ! -e $var_pulseeeffects ]]; then
            printf " \n"
            printf "\n[+] Instalando o Pulse Effects"
            printf "\n[+] Instalando o Pulse Effects" >> /tmp/log.txt

            if [ $distro == "Ubuntu" ]; then
	            # adicionando via flatpak
	            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	            # instalando via flatpak
	            flatpak install flathub com.github.wwmm.pulseeffects	        
	        elif [ $distro == "Debian" ]; then
                printf "\n"
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
        printf "\n[+] Instalando o Snap"
        printf "\n[+] Instalando o Snap" >> /tmp/log.txt

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
        printf "\n[+] Instalando o Xclip"
        printf "\n[+] Instalando o Xclip" >> /tmp/log.txt

        apt install xclip -y
    }

    install_espeak()
    {
    	printf "\n"
        printf "\n[+] Instalando o Speak"
        printf "\n[+] Instalando o Speak" >> /tmp/log.txt

        apt install espeak -y	
    }

    install_ibus()
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

    install_htop()
    {
        printf "\n"
        printf "\n[+] Instalando o Htop" >> /tmp/log.txt

        apt install htop -y
    }

    install_gnome_calculator()
    {
        printf "\n"
        printf "\n[+] Instalando o Gnome Calculator"
        printf "\n[+] Instalando o Gnome Calculator" >> /tmp/log.txt

        apt install gnome-calculator -y
    }

    install_tuxguitar()
    {
        # variavel de verificação
        local var_tuxguitar=$(which tuxguitar-vs)

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

    install_muse_score()
    {
        # variavel de verificação
        local var_musescore=$(which musescore)

        # criando verificação para instalar o musescore
        if [[ ! -e $var_musescore ]]; then
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
        # variavel de verificação
        local var_zsh=$(which zsh)

        printf "\n"
        printf "\n[+] Instalando o ZSH"
        printf "\n[+] Instalando o ZSH" >> /tmp/log.txt


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
            printf "\n[+] Instalando o Docker" >> /tmp/log.txt

            if [[ $distro == "Ubuntu" ]]; then
        		apt install docker-io -y
        	elif [[ $distro == "Debian" ]]; then            
				# baixando dependencias               
                printf "\n[*] Instalando dependencias"
                apt-get install apt-transport-https dirmngr -y

                # baixando chave 
                printf "\n[*] Baixando chaves"
                echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list

                # adicionando repositorio
                printf "\n[*] Adicionando repositorio"
                apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609D

                # atualizando sistema
                update

                # instalando docker
                printf "\n[*] Instalando docker"
                printf "\n[*] Instalando docker" >> /tmp/log.txt
                apt install docker-engine docker-compose -y            

                # adicionando usuario ao grupo
                printf "\n[*] Adicionando usuario ao grupo no docker"
                printf "\n[*] Adicionando usuario ao grupo no docker" >> /tmp/log.txt
                # gpasswd -a $usuario docker
            else
            	printf "\n"
            fi
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

        if [ $distro == "Ubuntu" ]; then
            wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add - 
            apt install apt-transport-https -y 
            echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
            
            update  
            
            apt install sublime-text -y
        elif [ $distro == "Debian" ]; then
			echo "deb https://download.sublimetext.com/ apt/dev/" | tee /etc/apt/sources.list.d/sublime-text.list
			wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
			
			update

			apt install sublime-text -y
        fi
    }

    install_firmware()
    {
        printf "\n"
        printf "\n[+] Instalando os firmware's non-free"        
        printf "\n[+] Instalando os firmware's non-free" >> /tmp/log.txt        
        
        apt install firmware-linux firmware-linux-nonfree \
        			xserver-xorg-input-synaptics blueman  \
        			firmware-brcm80211 -y			
    }     

    install_compton()
    {
    	printf "\n"
        printf "\n[+] Instalando o Compton"        
        printf "\n[+] Instalando o Compton" >> /tmp/log.txt        

    	apt install compton -y
    }

    install_python()
    {
        printf "\n"
        printf "\n[+] Instalando o Pip" >> /tmp/log.txt        

        apt install python3.5 python-pip -y
    }

    install_dropbox()
    {
        printf "\n"
        printf "\n[+] Instalando Dropbox"
        printf "\n[+] Instalando Dropbox" >> /tmp/log.txt

        apt install nautilus-dropbox -y
    }

    install_transmission()
    {
        local var_transmission=$(which transmission-gtk)

        # verificando se transmission está instalado
        if [[ ! -e $var_transmission ]]; then
            printf "\n"
            printf "\n[+] Instalando o Transmission"
            printf "\n[+] Instalando o Transmission" >> /tmp/log.txt    

            apt install transmission-gtk -y
        fi
    }

    install_xfburn()
    {
        printf "\n"
        printf "\n[+] Instalando XFBurn"
        printf "\n[+] Instalando XFBurn" >> /tmp/log.txt

        apt install xfburn -y
    }

    install_wavemon()
    {
        printf "\n"
        printf "\n[+] Instalando o Wavemon"        
        printf "\n[+] Instalando o Wavemon" >> /tmp/log.txt        

        apt install wavemon -y
    }

    install_mugshot()
    {
        printf "\n"
        printf "\n[+] Instalando o Mugshot"        
        printf "\n[+] Instalando o Mugshot" >> /tmp/log.txt        

        apt install mugshot -y
    }

    install_simplescan()
    {
        printf "\n"
        printf "\n[+] Instalando o Simple-scan"        
        printf "\n[+] Instalando o Simple-scan" >> /tmp/log.txt        

        apt install simple-scan -y
    }   

# # # # # # # # # #
# # PROGRAMAS NÃO ESSENCIAIS
    install_wireshark()
    {
        printf "\n"
        printf "\n[+] Instalando o Wireshark"
        printf "\n[+] Instalando o Wireshark" >> /tmp/log.txt

        apt install wireshark -y
    }
# # # # # # # # # #

# # CRIANDO FUNCÕES PARA OTIMIZAR PŔOCESSOS
func_atualiza()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Atualizando"
    else
        notify-send -u normal "Atualizando sistema" -t 10000
    fi

    clear

    update
    upgrade
}

func_corrige()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Corrigindo"
    else
        notify-send -u normal "Corrigindo sistema" -t 10000
    fi

    apt_check
    apt_install
    apt_remove
    apt_clean        

    prelink_preload_deborphan
    pacotes_quebrados    
    config_ntp    

    atualiza_db   

    autologin
    arquivo_hosts
    chaveiro

    icones_temas

	if [[ $v_hostname == 'notebook' ]]; then               
        if [ $distro == "Ubuntu" ]; then        
            apt_update_local
            apt_auto
            apport
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
        printf "\n[-] ERRO CORRIGE!"
    fi

    # realizando atualização
    update
}

func_limpa()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Limpando"
    else
        notify-send -u normal "Limpando sistema" -t 10000
    fi

    clear   

    pacotes_orfaos
    funcao_chkrootkit
    func_localepurge
}

func_instala()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Instalando"
    else
        notify-send -u normal "Instalando programas no sistema" -t 10000
    fi

	install_firefox
	install_chromium
	install_vivaldi
	install_tor  

	install_codecs
	install_vlc
	install_clementine
	install_spotify	   
	install_funcao_gimp
	install_muse_score
	install_simple_screen_recorder
	install_sweethome3d   
	install_tuxguitar 
	install_muse_score                

	install_git
	install_python    
	install_sublime
    install_terminator

    install_stellarium

    install_libreoffice 

	install_xfce4
    install_lm-sensors    
    install_nautilus
    install_openssh    
    install_reaver
    install_redshift
    install_ristretto    
    install_screenfetch
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
    install_firewall_basic            
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

    install_wine
    install_playonlinux

    install_python       	
	install_ntp 
	install_localepurge  

	install_transmission

	if [[ $v_hostname == 'notebook' ]]; then		
        install_cheese
        install_aircrack  
        install_wavemon	

		if [ $distro == "Ubuntu" ]; then		
			printf "\n"
		elif [ $distro == "Debian" ]; then				
	    	install_firmware  		    
		fi
	elif [[ $v_hostname == 'desktop' ]]; then
		install_visualgameboy
	    install_dolphin

        install_kstars
		install_audacity
    	install_kdenlive
        install_nvidia              
	else
		printf "\n[-] ERRO INSTALA!"
	fi
}

func_instala_outros()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Instalando outros"
    else
        notify-send -u normal "Instalando outros programas no sistema" -t 10000
    fi
	
    install_wireshark    
    fonts

    # verificando computador
    if [[ $v_hostname == 'desktop' ]]; then
        install_virtualbox
        install_steam        
    fi
}

func_remove()
{
    ## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Removendo programas"
    else
        notify-send -u normal "Removendo programas no sistema" -t 10000
    fi

	printf "\n\n[+] Removendo programas" >> /tmp/log.txt
    apt purge thunderbird parole inkscape* blender* \
    exfalso* quodlibet* xterm* pidgin* meld* gtkhash* xsane* imagemagick* xsane* chromium-bsu* owncloud* -y
    
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

    # texmaker - trabalhos academicos
    texmaker

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

    # removendo programas pré-instalados, desnecessários
    func_remove

    # corrige possiveis problemas no sistema, se ativa não irá fazer tudo automaticamente
    func_corrige

    # realiza uma limpeza no sistema, removendo coisas desnecessárias
    func_limpa

    # atualizando o sistema novamente | com o objetivo de atualizar os programas instalados
    func_atualiza
}

func_vetor()
{
    # percorrendo vetor atualiza
    for (( i = 0; i <= ${#ATUALIZA[@]}; i++ )); do             
        # saindo do script
        if [[ ${ATUALIZA[$i]} = "$ESCOLHA_VETOR" ]]; then
            # mostrando funcao encontrada
            # echo ${ATUALIZA[$i]}

            # executando funcao encontrada
            ${ATUALIZA[$i]}

            # saindo do script
            exit 1                
        fi
    done

    # percorrendo vetor corrige
    for (( i = 0; i <= ${#CORRIGE[@]}; i++ )); do 
        # saindo do script
        if [[ ${CORRIGE[$i]} = "$ESCOLHA_VETOR" ]]; then
            # mostrando funcao encontrada
            # echo ${CORRIGE[$i]}

            # executando funcao encontrada
            ${CORRIGE[$i]}

            # saindo do script
            exit 1                
        fi
    done

    # percorrendo vetor limpa
    for (( i = 0; i <= ${#LIMPA[@]}; i++ )); do 
        # saindo do script
        if [[ ${LIMPA[$i]} = "$ESCOLHA_VETOR" ]]; then
            # mostrando funcao encontrada
            # echo ${LIMPA[$i]}

            # executando funcao encontrada
            ${LIMPA[$i]}

            # saindo do script
            exit 1                
        fi
    done

    # percorrendo vetor instala
    for (( i = 0; i <= ${#INSTALA[@]}; i++ )); do 
        # saindo do script
        if [[ ${INSTALA[$i]} = "$ESCOLHA_VETOR" ]]; then
            # mostrando funcao encontrada
            # echo ${INSTALA[$i]}

            # executando funcao encontrada
            ${INSTALA[$i]}

            # saindo do script
            exit 1                
        fi
    done

    # percorrendo vetor outros
    for (( i = 0; i <= ${#INSTALA_OUTROS[@]}; i++ )); do 
        # saindo do script
        if [[ ${INSTALA_OUTROS[$i]} = "$ESCOLHA_VETOR" ]]; then
            # mostrando funcao encontrada
            # echo ${INSTALA_OUTROS[$i]}

            # executando funcao encontrada
            ${INSTALA_OUTROS[$i]}

            # saindo do script
            exit 1                
        fi
    done

    # mostrando ajuda para o usuario
    if [[ "$ESCOLHA_VETOR" = "help" ]]; then
        if [[ "$HELP_VETOR" = "atualiza" ]]; then
            printf "\nATUALIZAR\n"
            for (( i = 0; i <= ${#ATUALIZA[@]}; i++ )); do             
                echo ${ATUALIZA[$i]}
            done    

            exit 1
        fi
        
        if [[ "$HELP_VETOR" = "corrige" ]]; then
            printf "\nCORRIGE\n"
            for (( i = 0; i <= ${#CORRIGE[@]}; i++ )); do             
                echo ${CORRIGE[$i]}
            done

            exit 1
        fi

        if [[ "$HELP_VETOR" = "limpa" ]]; then
            printf "\nLIMPA\n"
            for (( i = 0; i <= ${#LIMPA[@]}; i++ )); do             
                echo ${LIMPA[$i]}
            done

            exit 1
        fi

        if [[ "$HELP_VETOR" = "instala" ]]; then
            printf "\nINSTALA\n"
            for (( i = 0; i <= ${#INSTALA[@]}; i++ )); do             
                echo ${INSTALA[$i]}
            done

            exit 1
        fi

        if [[ "$HELP_VETOR" = "instala_outros" ]]; then
            printf "\nINSTALA OUTROS\n"
            for (( i = 0; i <= ${#INSTALA_OUTROS[@]}; i++ )); do             
                echo ${INSTALA_OUTROS[$i]}
            done

            exit 1
        fi

        if [[ "$HELP_VETOR" -eq "help" ]]; then
            printf "\nATUALIZAR\n"
            for (( i = 0; i <= ${#ATUALIZA[@]}; i++ )); do             
                echo ${ATUALIZA[$i]}
            done

            printf "\nCORRIGE\n"
            for (( i = 0; i <= ${#CORRIGE[@]}; i++ )); do             
                echo ${CORRIGE[$i]}
            done

            printf "\nLIMPA\n"
            for (( i = 0; i <= ${#LIMPA[@]}; i++ )); do             
                echo ${LIMPA[$i]}
            done

            printf "\nINSTALA\n"
            for (( i = 0; i <= ${#INSTALA[@]}; i++ )); do             
                echo ${INSTALA[$i]}
            done

            printf "\nINSTALA OUTROS\n"
            for (( i = 0; i <= ${#INSTALA_OUTROS[@]}; i++ )); do             
                echo ${INSTALA_OUTROS[$i]}
            done

            # saindo do script
            exit 1               
        fi
    fi
}

version()
{
	## verificando valor variavel
    if [ $var_mudo == "0" ]; then
        espeak -vpt-br "Versao do script: $VERSAO"
    else
		echo "Versao do script: $VERSAO"
	fi
}

##REALIZANDO VERIFICAÇÕES
    ######VERIFICANDO usuario ROOT
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

func_interface_dialog()
{
    valor=$(
        dialog  --stdout --title "Automatizador de Tarefas" --backtitle "AUTOCONFIG - Versao $VERSAO" \
                --ok-label "Executar" --cancel-label "Cancelar" \
                --menu "Modo de execucao do script..." \
                0 0 0 \
                "0" "Modo Automatico" \
                "1" "Modo Manual" \
    )

    # se valor igual a 1, sai do programa
    [ $? -eq 1 ] && break
    
    # tratando saida - forma de execucao do script
    case $valor in 
    	# modo automatico
        0) 
            escolha=$(
                dialog  --stdout --title "Automatizador de tarefas" --backtitle "AUTOCONFIG - Versao $VERSAO"  \
                    --ok-label "Executar" --cancel-label "Cancelar" \
                    --menu "O que voce deseja fazer?" \
                    0 0 0 \
                    "0" "Executar todas funçoes abaixo" \
                    "1" "Atualizar Sistema" \
                    "2" "Corrigir Sistema" \
                    "3" "Limpar Sistema" \
                    "4" "Instalar programas" \
                    "5" "Instalar outros programas" \
                    "6" "Remover programas" \
            )

            case $escolha in
                0) func_todas ;;
                1) func_atualiza ;;
                2) func_corrige ;;
                3) func_limpa ;;
                4) func_instala  ;;
                5) func_instala_outros ;;        
                6) func_remove ;;
            esac
        ;;

        # modo manual
        1) 
			escolha=$(
                dialog  --stdout --title "Automatizador de tarefas" --backtitle "AUTOCONFIG - Versao $VERSAO"  \
                    --ok-label "Executar" --cancel-label "Cancelar" \
                    --menu "O que voce deseja fazer?" \
                    0 0 0 \
                    "0" "Atualizar Sistema" \
                    "1" "Corrigir Sistema" \
                    "2" "Limpar Sistema" \
                    "3" "Instalar programas" \
                    "4" "Instalar outros programas" \
            )

            # vetor de açoes
            vetor=(atualiza corrige limpa instala instala_outros)

            for (( i = 0; i <= ${#vetor[@]}; i++ )); do 
                # if [[ ${vetor[$i]} == $escolha ]]; then    
                if [[ $i == $escolha ]]; then    
                    # echo ${vetor[$i]}

                    if [[ $escolha == 0 ]]; then    
                        # printf "atualiza"

                        # for (( i = 0; i <= ${#ATUALIZA[@]}; i++ )); do
                        #     # echo ${ATUALIZA[$i]}

						for chave in ${!ATUALIZA[@]}; do 

							# copy[$chave]=${original[$chave]}

							# tamanho=${#array[@]}
							echo "$chave = ${ATUALIZA[$chave]}"; 

							# copy=${$ATUALIZA[*]}
							# echo "$chave"; 

							# escolha=$(
							# 	dialog  --stdout --separate-output \
       #                              --checklist "Escolha algo" \
       #                              0 0 0 \
       #                          	"$chave" "${ATUALIZA[$chave]}" off \
       #                          )
                        done     

                        # echo ${copy[*]}

                    elif [[ $escolha == 1 ]]; then                    
                        printf ""
                    elif [[ $escolha == 2 ]]; then
                        printf ""
                    elif [[ $escolha == 3 ]]; then
                        for chave in ${INSTALA[@]}; do 
							# echo "$chave = ${INSTALA[$chave]}"; 
							echo "$chave";
						done
                    elif [[ $escolha == 4 ]]; then
                        printf ""
                    else
                        printf ""
                    fi                                                            
                fi
            done        
        esac
}


auto_config()
{
    clear

    # chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]
    printf "
                AUTOCONFIG - V4
        Versao do script: $VERSAO
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
    if [ $distro == "Ubuntu" ]; then
        clear
        auto_config_ubuntu
    #executando ações para a distribuição Fedora
    elif [ $distro == "Debian" ]; then
        clear
        auto_config_debian
    else
        printf "Disponivel para Debian ou Ubuntu!!! \n"
        printf "Script incompativel infelizmente \n"
    fi

            #     for (( i = 0; i <= ${#repos[@]}; i++ )); do 
            #     # verify local repo disk
            #     if [[ $LOCAL${repos[$i]} != $LOCAL ]]; then
            #         # verify local repo
            #         if [ -e "$LOCAL${repos[$i]}" ]; then         
            #             printf ""
            #             echo "[+] - Found:" $LOCAL${repos[$i]}

            #             # into folder location
            #             ls $LOCAL${repos[$i]}                               
            #         fi
            #     fi
            # done
		# ;;
  #   esac      
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

# mostrando data/hora log inicilização script   
date > /tmp/log.txt

# tratando saidas
# se script for chamado sem parametro ou
# com apenas o parametro "mudo", sem outro
if [ $# -eq 0 ] || [[ $1 -eq "mudo" ]] || [[ -e $2 ]]; then
    func_help
else
    printf ""
fi

# passando parametro ao vetor
if [[ $1 -eq "mudo" ]]; then
    ESCOLHA_VETOR=$3
    HELP_VETOR=$4
else
    ESCOLHA_VETOR=$2
    HELP_VETOR=$3
fi  

# ## manipulando parametros - parametro acao/mudo(boolean)
for i in "$@"; 
do
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
		-v|-version) version;;
        vetor) func_vetor;;
		interface) func_interface_dialog;;
        *) echo "Parametro desconhecido";;
    esac    
done

date >> /tmp/log.txt
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
