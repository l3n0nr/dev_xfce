#!/bin/bash
#
######################
# FONTES DE PESQUISA #
######################
#
################################################################################
# por oliveiradeflavio(Flávio Oliveira)
# 	contato: <github.com/oliveiradeflavio/scripts-linux>
#
# por gmanson(Gabriel Manson)
# 	contato: <github.com/gmasson/welcome-debian>
#
# por Lucas Alves Santos
# 	fonte: <https://www.vivaolinux.com.br/script/Instalar-Tor-Browser/>
#
# por Edivaldo Brito
# 	fonte: <http://www.edivaldobrito.com.br/instalando-ide-java-netbeans-8-0-ubuntu-e-derivados>
#
# por Fabiano de Oliveira e Souza
# 	fonte: <https://www.vivaolinux.com.br/script/Mantendo-hora-do-servidor-atualizada-com-NTP>
#
# por Lucas Novo Silva
# 	fonte: <https://www.vivaolinux.com.br/dica/Erro-de-apt-get-update-no-Ubuntu-1604-Xenial-problemas-nos-repositorios-RESOLVIDO>
#
# por Ricardo Ferreira
# 	fonte: <http://www.linuxdescomplicado.com.br/2014/11/saiba-como-acessar-uma-maquina-ubuntu.html>
#
# por Vinícius Vieira
#        fonte: <http://sejalivre.org/instalando-o-tor-browser-no-ubuntu-e-linux-mint/>
#
# por Dionatan Simioni
# 	 fonte: <http://www.diolinux.com.br/2016/12/drivers-mesa-ubuntu-ppa-update.html>
#    	 fonte: <http://www.diolinux.com.br/2016/12/diolinux-paper-orange-modern-theme-for-unity.html>
# 	 fonte: <http://www.diolinux.com.br/2014/08/versao-nova-kdenlive-ppa.html>
# 	 fonte: <http://www.diolinux.com.br/2015/04/como-atualizar-kernel-para-a-ultima-versao-no-ubuntu.html>
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
####################################
# versão do script: 3.0.140.6.17.5 #
####################################
#
# legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script + versões funcionando;
# 	d = correções necessárias;
#		netbeans
#		android
#		vga
#		mutate
#               tor
# 	e = pendencias
#		GBA
#		DeSmuME
#               Openshot
#               K3b
#               Scribus
#               Umbrello
#               Opera
#               Skype
#               Tuxpaint
#               Calibre
#               UNetbootin
#               Code::blocks IDE
#               PgAdminIII
#               Samba
#
# 	f = desenvolver
# 		-Criar uma interface gráfica, possibilitando ao usuário selecionar as ações que o usuário deseja realizar, selecionando apenas com o espaço;
#		-Possibilitar ao usuário o cancelamento das ações selecionadas, dentro de um tempo pré-determinado(10 seg.);
#		-Verificar a arquitetura do sistema, para a instalação de determinados programas;
#               -Facilitar a instalação dos programas, com a opção de instalar todos disponiveis no script;
#               -Implementar uma funcao chamada padrao, onde contenha todos os programas padroes;
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
################################################################################
# FUNCOES
# Atualização
# # [+] Update
# #     [+] Update-Grud
# # [+] Upgrade
# # [+] Kernel 
# #     [+] Remove antigos
# #     [+] Atualiza novo
################################################################################
# CorrigindoErros
# # [+] Swap
# # [+] Prelink, Preload, Deborphan
# # [+] Pacotes com problemas
# # [+] Fontes
################################################################################
# Limpeza
# # [+] Excluindo pacotes antigos
# # [+] Excluindo pacotes orfaõs
# # [+] Removendo arquivos temporários
# # [+] Arquivos obsoletos
# # [+] Kernel's antigos
# # [+] Removendo arquivos (.bak, ~, tmp) pasta Home
# # [+] Excluindo arquivos inuteis do cache do gerenciador de pacotes
################################################################################
# Instalação
# # [-] Todos Programas
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
# # [-] Netbeans
# #     VERIFICAR, INSTALAR TAMBEM JDK
# #     
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
# # [+] Tor
# # VERIFICAR ARQUITETURA PARA INSTALAR
# # [+] Android Studio
# #     VERIFICAR, INSTALAR TAMBEM JDK	
# # 
# # [+] NTP
# # [+] Hollywood
# # [+] Synaptic	
# # [+] Virtualbox
# # [+] Citra
# # [-] DeSmuME 
# #     ENCONTRAR FORMA DE INSTALAÇÃO AUTOMÁTICA
# # [-] GBA - Gameboyadvanced
# # [+] Mesa - ppa
# # [-] Mutate
# # [+] Screenfetch
# # [+] Diolinux_paper(Diolinux Paper Orange Modern)
# # [+] Kdenlive
# # [+] Openssh(Client-Servidor)
# # [+] Bleachbit
# # [+] Supertuxkart
# # [+] Cowsay
# # [+] Chromium
# # [+] Synapse
# # [+] Sweet Home 3d
# # [+] Kate
# # [+] Inkscape
# # [+] Blender
# # [-] Calibre
# # [+] Numix Icon
# # [+] Plank
# # [+] Gnome System Monitor
# # [+] Nautilus
# # [+] Wireshark
# # [+] Gnome-disk-utility
# # [+] Smartgit
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
#
################################################################################	
# Reinicialização
# # [+]Reiniciar
################################################################################

#verificando se o usuário é ROOT
if [[ `id -u` -ne 0 ]]; then
    echo "Você precisa ter poderes administrativos (root)"
    echo "O script está sendo finalizado ..."
    sleep 3
    exit
fi

################################################################################
######CORREÇÃO SISTEMA
update()
{
    echo ""
    echo "Deseja atualizar os repositórios de sua máquina (s/n)?"
    read -p "??" update
}

kernel()
{
    clear
    echo ""
    echo "Deseja realizar atualizar o kernel do sistema (s/n)?"
    read -p "??" kernel
}

upgrade()
{
    clear
    echo ""
    echo "Deseja atualizar os programas de sua máquina (s/n)?"
    read -p "??" upgrade
}

corrigeerros()
{
    clear
    echo ""
    echo "Deseja corrigir possíveis erros em sua distribuição (s/n)?"
    read -p "??" corrigeerros
}

swap()
{
    clear
    echo ""
    echo "Deseja otimizar a utilização da swap (s/n)?"
    read -p "??" swap
}

pacotesquebrados()
{
    clear
    echo ""
    echo "Deseja realizar uma correção nos pacotes quebrados do sistema (s/n)?"
    read -p "??" pacotesquebrados
}

prelink_preload_deborphan()
{
    clear
    echo ""
    echo "Deseja executar o Prelink, Preload e Deborphan(s/n)?"
    read -p "??" prelink_preload_deborphan
}

pacotes_antigos()
{
    clear
    echo ""
    echo "Deseja remover os pacotes antigos do sistema(s/n)?"
    read -p "??" pacotes_antigos
}

fontes()
{
    clear
    echo ""
    echo "Deseja corrigir possiveis erros de fontes(s/n)?"
    read -p "??" fontes
}

################################################################################
######LIMPANDO A MÁQUINA
temporario()
{
    clear
    echo ""
    echo "Deseja remover os arquivos temporários do sistema operacional (s/n)?"
    read -p "??" temporario
}

obsoleto()
{
    clear
    echo ""
    echo "Deseja remover os arquivos obsoletos do sistema operacional (s/n)?"
    read -p "??" obsoleto
}

arquivosorfaos()
{
    clear
    echo ""
    echo "Deseja realizar a limpeza nos arquivos orfãos do sistema (s/n)?"
    read -p "??" arquivosorfaos
}

arquivosinuteis()
{
    clear
    echo ""
    echo "Deseja realizar a limpeza nos arquivos obsoletos do sistema (s/n)?"
    read -p "??" arquivosinuteis
}

################################################################################
######INSTALANDO PROGRAMAS

todos()
{
    clear
    echo ""
    echo "Deseja instalar todos os programas? (s/n)"
    read -p "??" todos
}

firefox()
{
    clear
    echo ""
    echo "Deseja instalar o Firefox? (s/n)"
    read -p "?? " firefox
}

steam()
{
    clear
    echo ""
    echo "Deseja instalar o Steam? (s/n)"
    read -p "?? " steam
}

xampp()
{
    clear
    echo ""
    echo "Deseja instalar o Xampp? (s/n)"
    read -p "?? " xampp
}

spotify()
{
    clear
    echo ""
    echo "Deseja instalar o Spotify? (s/n)"
    read -p "??" spotify
}

mac()
{
    clear
    echo ""
    echo "Deseja instalar o tema e ícones do MAC OS X? (s/n)"
    read -p "??" mac
}

codecs()
{
    clear
    echo ""
    echo "Deseja instalar codecs multimidia em seu sistema (s/n)?"
    read -p "??" codecs
}

gimp()
{
    clear
    echo ""
    echo "Deseja instalar o Gimp em seu sistema (s/n)?"
    read -p "??" gimp
}

xfce()
{
    clear
    echo ""
    echo "Deseja instalar componentes adicionais do XFCE em sua máquina (s/n)?"
    read -p "??" xfce
}

wine()
{
    clear
    echo ""
    echo "Deseja instalar o Wine (s/n)?"
    read -p "??" wine
}

playonlinux()
{
    clear
    echo ""
    echo "Deseja instalar o Playonlinux (s/n)?"
    read -p "??" playonlinux
}

java()
{
    clear
    echo ""
    echo "Deseja instalar o Java 8 (s/n)?"
    read -p "??" java;
}

redshift()
{
    clear
    echo ""
    echo "Deseja instalar o Red Shift (s/n)?"
    read -p "??" redshift
}

flux()
{
    clear
    echo ""
    echo "Deseja instalar o Flux (s/n)?"
    read -p "??" flux
}

libreoffice()
{
    clear
    echo ""
    echo "Deseja instalar o LibreOffice (s/n)?"
    read -p "??" libreoffice
}

vlc()
{
    clear
    echo ""
    echo "Deseja instalar o VLC (s/n)?"
    read -p "??" vlc
}

netbeans()
{
    clear
    echo ""
    echo "Deseja instalar o Netbeans (s/n)?"
    read -p "??" netbeans
}

clementine()
{
    clear
    echo ""
    echo "Deseja instalar o Clementine (s/n)?"
    read -p "??" clementine
}

gparted()
{
    clear
    echo ""
    echo "Deseja instalar o Gparted (s/n)?"
    read -p "??" gparted
}

tlp()
{
    clear
    echo ""
    echo "Deseja instalar o Tlp (s/n)?"
    read -p "??" tlp
}

rar()
{
    clear
    echo ""
    echo "Deseja instalar o Rar (s/n)?"
    read -p "??" rar
}

git()
{
    clear
    echo ""
    echo "Deseja instalar o Git (s/n)?"
    read -p "??" git
}

lmsensors()
{
    clear
    echo ""
    echo "Deseja instalar o Lm-Sensors (s/n)?"
    read -p "??" lmsensors
}

stellarium()
{
    clear
    echo ""
    echo "Deseja instalar o Stellarium (s/n)?"
    read -p "??" stellarium
}

texmaker()
{
    clear
    echo ""
    echo "Deseja instalar o Texmaker (s/n)?"
    read -p "??" texmaker
}

gnometerminal()
{
    clear
    echo ""
    echo "Deseja instalar o Gnome-Terminal (s/n)?"
    read -p "??" gnometerminal
}

reaver()
{
    clear
    echo ""
    echo "Deseja instalar o Reaver (s/n)?"
    read -p "??" reaver
}

tor()
{
    clear
    echo ""
    echo "Deseja instalar o Navegador Tor (s/n)?"
    read -p "??" tor
}

android()
{
    clear
    echo ""
    echo "Deseja instalar o Android Studio (s/n)?"
    read -p "??" android
}

ntp()
{
    clear
    echo ""
    echo "Deseja instalar o NTP e atualizar a data/hora do seu sistema (s/n)?"
    read -p "??" ntp
}

hollywood()
{
    clear
    echo ""
    echo "Deseja instalar o recurso Hollywood, que irá torná-lo um super hacker? (s/n)?"
    read -p "??" hollywood
}

synaptic()
{
    clear
    echo ""
    echo "Deseja instalar o Synaptic? (s/n)?"
    read -p "??" synaptic
}

dolphin()
{
    clear
    echo ""
    echo "Deseja instalar o Dolphin? (s/n)?"
    read -p "??" dolphin
}

virtualbox()
{
    clear
    echo ""
    echo "Deseja instalar o Virtualbox? (s/n)?"
    read -p "??" virtualbox
}

citra()
{
    clear
    echo ""
    echo "Deseja instalar o Citra? (s/n)?"
    read -p "??" citra
}

mesa()
{
    clear
    echo ""
    echo "Deseja instalar o Mesa? (s/n)?"
    read -p "??" mesa
}

mutate()
{
    clear
    echo ""
    echo "Deseja instalar o Mutate? (s/n)?"
    read -p "??" mutate
}

screenfetch()
{
    clear
    echo ""
    echo "Deseja instalar o Screenfetch? (s/n)?"
    read -p "??" screenfetch
}

diolinux_paper()
{
    clear
    echo ""
    echo "Deseja instalar o Diolinux Paper Orange Modern? (s/n)"
    read -p "??" diolinux_paper
}

kdenlive()
{
    clear
    echo ""
    echo "Deseja instalar o Kdenlive? (s/n)"
    read -p "??" kdenlive
}

openssh()
{
    clear
    echo ""
    echo "Deseja instalar o Openssh(Client-Servidor)? (s/n)"
    read -p "??" openssh
}

bleachbit()
{
    clear
    echo ""
    echo "Deseja instalar o Bleachbit? (s/n)"
    read -p "??" bleachbit
}

supertuxkart()
{
    clear
    echo ""
    echo "Deseja instalar o Supertuxkart? (s/n)"
    read -p "??" supertuxkart
}

cowsay()
{
    clear
    echo ""
    echo "Deseja instalar o Cowsay? (s/n)"
    read -p "??" cowsay
}

chromium()
{
    clear
    echo ""
    echo "Deseja instalar o Chromium? (s/n)"
    read -p "??" chromium
}

synapse()
{
    clear
    echo ""
    echo "Deseja instalar o Synapse? (s/n)"
    read -p "??" synapse
}

sweethome3d()
{
    clear
    echo ""
    echo "Deseja instalar o Sweet Home 3D? (s/n)"
    read -p "??" sweethome3d
}

kate()
{
    clear
    echo ""
    echo "Deseja instalar o Kate? (s/n)"
    read -p "??" kate
}

inkscape()
{
    clear
    echo ""
    echo "Deseja instalar o Inkscape? (s/n)"
    read -p "??" inkscape
}

blender()
{
    clear
    echo ""
    echo "Deseja instalar o Blender? (s/n)"
    read -p "??" blender
}

cheese()
{
    clear
    echo ""
    echo "Deseja instalar o Cheese? (s/n)"
    read -p "??" cheese
}

numixicon()
{
    clear
    echo ""
    echo "Deseja instalar o Numix Icon? (s/n)"
    read -p "??" numixicon
}

plank()
{
    clear
    echo ""
    echo "Deseja instalar o Plank Dock? (s/n)"
    read -p "??" plank
}

gnomesystemmonitor()
{
    clear
    echo ""
    echo "Deseja instalar o Gnome System Monitor? (s/n)"
    read -p "??" gnomesystemmonitor
}

nautilus()
{
    clear
    echo ""
    echo "Deseja instalar o Nautilus? (s/n)"
    read -p "??" nautilus
}

wireshark()
{
    clear
    echo ""
    echo "Deseja instalar o Wireshark? (s/n)"
    read -p "??" wireshark
}

gnomediskutility()
{
    clear
    echo ""
    echo "Deseja instalar o Gnome System Utility? (s/n)"
    read -p "??" gnomediskutility
}

smartgit()
{
    clear   
    echo ""
    echo "Deseja instalar o Smart Git? (s/n)"
    read -p "??" smartgit
}

chkrootkit()
{
    clear
    echo ""
    echo "Deseja instalar o Chkrootkit? (s/n)"
    read -p "??" chkrootkit    
}

vivacious()
{
    clear
    echo ""
    echo "Deseja instalar o Vivacious? (s/n)"
    read -p "??" vivacious
}

lampp()
{
    clear
    echo ""
    echo "Deseja instalar o Lampp? (s/n)"
    read -p "??" lampp
}

php()
{
    clear
    echo ""
    echo "Deseja instalar o Php? (s/n)"
    read -p "??" php
}

mysql()
{
    clear
    echo ""
    echo "Deseja instalar o MySQL? (s/n)"
    read -p "??" mysql
}

ftp()
{
    clear
    echo ""
    echo "Deseja instalar o FTP? (s/n)"
    read -p "??" ftp
}

quota()
{
    clear
    echo ""
    echo "Deseja instalar o Quota? (s/n)"
    read -p "??" quota
}

flatabulous()
{
    clear
    echo ""
    echo "Deseja instalar o tema do Flatabulous? (s/n)"
    read -p "??" flatabulous
}

gnomesystemtools()
{
    clear
    echo ""
    echo "Deseja instalar o Gnome System Tools? (s/n)"
    read -p "??" gnomesystemtools
}

brightside()
{
    clear
    echo ""
    echo "Deseja instalar o Brightside? (s/n)"
    read -p "??" brightside
}

squarebeam()
{
    clear
    echo ""
    echo "Deseja instalar o tema de icones Square Bean? (s/n)"
    read -p "??" squarebeam
}

liquorix()
{
    clear
    echo ""
    echo "Deseja instalar o Kernel Liquorix? (s/n)"
    read -p "??" liquorix
}

moka()
{
    clear
    echo ""
    echo "Deseja instalar o Tema Moka? (s/n)"
    read -p "??" moka
}

mousepad()
{
    clear
    echo ""
    echo "Deseja instalar o Mousepad? (s/n)"
    read -p "??" mousepad
}

################################################################################
######REINICIANDO
reinicia()
{
    clear
    echo ""
    echo "Deseja reiniciar a máquina agora, para concluir a instalação? (s/n)"
    read -p "??" reinicia;
}

################################################################################
install_yes()
{
#relatorio de instalacao
    echo "As seguintes tarefas serão realizadas..."
    echo "----------------------------------------------"

    ######CORREÇÃO SISTEMA
        if [[ $update == "s" ]]; then
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
        fi
            
        #atualizando os programas
        if [[ $upgrade == "s" ]]; then
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
        fi

        #corrigindo possiveis erros no sistema
        if [[ $corrigeerros == "s" ]]; then
            clear
            echo "Corrigindo possiveis erros no Sistema"
            echo "----------------------------------------------------------------------"
            apt-get check -y 
            dpkg --configure -a -y
            apt-get -f install 
            apt-get -f remove -y 
            apt-get autoremove -y 
            apt-get clean -y 
            apt-get install auto-apt -y 
            auto-apt update-local -y 
            auto-apt update -y 
            auto-apt updatedb -y
        fi
        
        #configurando a swap
        if [[ $swap == "s" ]]; then
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
        fi
        
        #otimizando sistema
        if [[ $prelink_preload_deborphan == "s" ]]; then		
            echo "Instalando Prelink, Preload e Deborphan"
            #prelink =
            #preload =
            #deborphan = remove pacotes obsoletos do sistema, principalmente após as atualizações de programas
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
        fi
        
        #corrigindo pacotes quebrados
        if [[ $pacotesquebrados == "s" ]]; then
            #VERIFICAR AÇÕES
            echo "Corrigindo pacotes quebrados"
            echo "----------------------------"
            dpkg --configure -a
            #VERIFICAR AÇÕES
            rm -r /var/lib/apt/lists  sudo mkdir -p /var/lib/apt/lists/partial
        fi	
        
        if [[ $fontes == "s" ]]; then
            echo "Instalando pacotes de fontes"
            echo "----------------------------"
            #baixando pacote
            wget http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
            
            #instalando pacote
            dpkg -i ttf-mscorefonts-installer_3.6_all.deb
            
            #removendo pacote
            rm -f ttf-mscorefonts-installer_3.6_all.deb
        fi
    
    ######LIMPANDO A MAQUINA
        #removendo kernel antigo
        if [[ $kernel == "s" ]]; then
                echo "Removendo os kernel's temporários do sistema"
                echo "--------------------------------------------"

                #removendo kernel's antigos
                dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^]*\).*/\1/;/[0-9]/!d' | xargs apt-get -y purge
                
                #removendo arquivos
                apt autoremove -y
                
                echo "Instalando kernel's novos"
                echo "--------------------------------------------"
                
                #instalando lynx
                apt install lynx -y
                
                #Baixa a lista de kernel e atributos
                list=$(lynx --dump http://kernel.ubuntu.com/~kernel-ppa/mainline/ | awk '/http/{print $2}')
                AddressLastVersion=$( echo "${list}"  | grep -v rc | tail -n 1)
                LastKernelAvaliable=$(echo $AddressLastVersion | cut -d "/" -f 6 | cut -d "-" -f1 | tr -d v )
        
                if [ -z $(echo $LastKernelAvaliable | cut -d "." -f3) ]  ; then LastKernelAvaliable=${LastKernelAvaliable}.0; fi  

                        #kernel instalado
                        LastKernelInstalled=$(ls /boot/ | grep img | cut -d "-" -f2 | sort -V | cut -d "." -f1,2,3 | tail -n 1)

                        #tipo do processador
                        arch=`uname -m`
                        if  [ $arch = i686 ] || [ $arch = i386 ]; then 
                                myarch="i386" 
                        elif [ $arch = "x86_64" ]; then
                                myarch="amd64"
                        else 
                                echo "Não foram encontrados pacotes para o seu processador :("
                        exit 0
                fi

                #comparação
                if [ $LastKernelInstalled = $LastKernelAvaliable ]; then
                        echo
                        echo
                        echo "Seu Kernel" $LastKernelInstalled  "e' a versão mais recente disponível."
                        echo "Até mais! :)"
                        echo
                        echo
                        exit 0		
                else
                        echo
                        echo "Seu Kernel e' o" $LastKernelInstalled "está disponível" $LastKernelAvaliable
                        echo
                        echo "Baixando o novo Kernel"
                        DownloadFolder=/tmp/kernel_$LastKernelAvaliable; mkdir -p $DownloadFolder; cd $DownloadFolder
                        wget $(lynx -dump -listonly $AddressLastVersion | awk '/http/{print $2}' | egrep 'all.deb|generic(.){1,}'$myarch'.deb')
                        echo
                        echo "...e vamos instalar"
                        echo
                        sudo dpkg -i *.deb
                        echo
                        echo "Para usar o novo Kernel vocẽ deve reiniciar o computador"
                fi
        fi
            
        #removendo arquivos temporarios
        if [[ $temporario == "s" ]]; then
                clear
                echo "Removendo arquivos temporários do sistema"
                echo "-----------------------------------------"
                find ~/.thumbnails -type f -atime +2 -exec rm -Rf {} \+
                
                #arquivo temporaritos pasta home
#			for i in *~ *.bak *.tmp; do
#				find $HOME -iname "$i" -exec rm -f {} \	
        fi
        
        #removendo arquivos obsoletos
        if [[ $obsoleto == "s" ]]; then
                clear
                echo "Removendo os arquivos obsoletos do sistema"
                echo "-----------------------------------------"
                apt-get clean -y && apt-get autoclean -y
        fi             

        #limpando arquivos orfaos
        if [[ $arquivosorfaos == "s" ]]; then
                clear
                echo "Removendo Pacotes Órfãos"
                echo "------------------------"
                apt-get remove $(deborphan) -y ; apt-get autoremove -y
        fi
        
        #limpando arquivos inuteis
        if [[ $arquivosinuteis == "s" ]]; then
                if [ "$distro" == "Ubuntu" ]; then
                        clear
                        echo "Removendo Pacotes inúteis"
                        echo "------------------------"
                        apt-get clean -y
                elif [ "$distro" == "Fedora" ]; then
                        clear
                        echo "Removendo Pacotes inúteis"
                        echo "------------------------"				
                        dnf autoremove -y 
                        dnf clean all 
                fi
        fi	
        
        #removendo pacotes antigos
        if [[ $pacotes_antigos == "s" ]]; then		
                apt-get autoremove -y
        fi
    
    ######INSTALANDO PROGRAMAS
        if [[ $firefox == "s" ]]; then
            #|| if[[ $todos == "s" ]]
                        clear
                echo "Firefox, "

                        #instalando o firefox
                apt install firefox -y
        fi

        if [[ $steam == "s" ]]; then
                clear
                echo "Steam"

                #instalando o steam
                apt install steam -y
        fi

        #instalando o xampp
        if [[ $xampp == "s" ]]; then
                clear
                echo "Xampp, (Ele irá precisar da sua atenção)"
                echo "Instalando XAMPP em sua máquina"
                echo "----------------------------------------------------------------------"

                #baixando o pacote
                wget http://nbtelecom.dl.sourceforge.net/project/xampp/XAMPP%20Linux/5.6.14/xampp-linux-x64-5.6.14-0-installer.run -O xampp-installer.run
                echo "Realizando a instalação..."
                echo "---------------------"

                #dando permissão para execução
                chmod +x xampp-installer.run

                #executando o arquivo
                ./xampp-installer.run

                #removendo o arquivo
                rm xampp-installer.run
        fi

        if [[ $spotify == "s" ]]; then
                clear
                echo "Instalando Spotify"
                echo "----------------------------------------------------------------------"

                #baixando pacote
                sh -c "echo 'deb http://repository.spotify.com stable non-free' >> /etc/apt/sources.list"

                #baixando chave
                apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886

                #atualizando lista de repositorios
                apt update -y

                #instalando o spotify
                apt install spotify-client -y
        fi

        if [[ $mac == "s" ]]; then
                clear
                echo "Instalando icones e temas do MacOS X"
                #adicionando repositorio
                add-apt-repository ppa:noobslab/macbuntu -y

                #atualizando lista de repositorios
                apt update

                #instalando icones do MacOS
                apt-get install macbuntu-os-icons-lts-v7 -y

                #instalando tema do MacOS
                apt-get install macbuntu-os-ithemes-lts-v7 -y
        fi

        if [[ $codecs == "s" ]]; then
                clear
                echo "Instalando Pacotes Multimidias (Codecs)"
                echo "----------------------------------------------------------------------"

                #instalando pacotes multimidias
                apt install ubuntu-restricted-extras faac faad ffmpeg gstreamer0.10-ffmpeg flac icedax id3v2 lame libflac++6 libjpeg-progs libmpeg3-1 mencoder mjpegtools mp3gain mpeg2dec mpeg3-utils mpegdemux mpg123 mpg321 regionset sox uudeview vorbis-tools x264 arj p7zip p7zip-full p7zip-rar rar unrar unace-nonfree sharutils uudeview mpack cabextract libdvdread4 libav-tools libavcodec-extra-54 libavformat-extra-54 easytag gnome-icon-theme-full gxine id3tool libmozjs185-1.0 libopusfile0 libxine1 libxine1-bin libxine1-ffmpeg libxine1-misc-plugins libxine1-plugins libxine1-x nautilus-script-audio-convert nautilus-scripts-manager tagtool spotify-client prelink deborphan oracle-java7-installer -y --force-yes
        fi

        if [[ $gimp == "s" ]]; then
                clear
                echo "Instalando o Gimp"
                echo "----------------------------------------------------------------------"

                #instalando o gimp
                apt install gimp* -y
        fi

        if [[ $xfce == "s" ]]; then
                if [ "$distro" == "Ubuntu" ]; then
                        clear
                        echo "Instalando Adicionais do XFCE4"
                        echo "----------------------------------------------------------------------"
                        #instalando componentes do XFCE
                        apt install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin smartmontools -y -f -q

                        #dando permissão de leitura, para verificar temperatura do HDD
                        chmod u+s /usr/sbin/hddtemp
                        
                elif [ "$distro" == "Fedora" ]; then
                        clear
                        echo "Instalando Adicionais do XFCE4"
                        echo "----------------------------------------------------------------------"
                        #instalando componentes do XFCE
                        dnf install xfce4-battery-plugin xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-indicator-plugin xfce4-linelight-plugin xfce4-mailwatch-plugin xfce4-mpc-plugin xfce4-notes-plugin xfce4-places-plugin xfce4-netload-plugin xfce4-quicklauncher-plugin xfce4-radio-plugin xfce4-screenshooter-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-systemload-plugin xfce4-timer-plugin xfce4-time-out-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-wmdock-plugin xfce4-xkb-plugin xfce4-mount-plugin -y -f -q
                        
                        #dando permissão de leitura, para verificar temperatura do HDD
                        chmod u+s /usr/sbin/hddtemp
                fi
        fi

        if [[ $wine == "s" ]]; then
                clear
                echo "Instalando Wine"
                echo "----------------------------------------------------------------------"
                #adicionado o repositorio
                add-apt-repository ppa:ubuntu-wine/ppa -y

                #instalando o wine
                apt install wine* -y
        fi

        if [[ $playonlinux == "s" ]]; then
                clear
                echo "Instalando o Playonlinux"
                echo "----------------------------------------------------------------------"

                #instalando o playonlinux
                apt install playonlinux* -y
        fi

        if [[ $java == "s" ]]; then
                clear
                echo "Instalando o Java 8"
                echo "----------------------------------------------------------------------"
                #adicionando repositorio
                add-apt-repository ppa:webupd8team/java -y

                #instalando o java8
                apt-get install oracle-java8-installer -y
                
                #instalando java jre
                apt-get install default-jre -y
        fi

        if [[ $redshift == "s" ]]; then
                clear
                echo "Instalando o Redshift"
                echo "----------------------------------------------------------------------"

                #instalando o redshift
                apt install redshift gtk-redshift -y
        fi

        #instalando o flux
        if [[ $flux == "s" ]]; then
#                     #instalando via arquivo
#                     clear
#                     echo "Instalando o Flux"
#                     echo "----------------------------------------------------------------------"
#                     #instalando dependencias
#                     apt-get install git python-appindicator python-xdg python-pexpect python-gconf python-gtk2 python-glade2 libxxf86vm1 -y
# 
#                     #realizando download do flux
#                     cd /tmp && git clone "https://github.com/xflux-gui/xflux-gui.git" && cd xflux-gui &&
# 
#                     #executando instalacao
#                     sudo python download-xflux.py &&
#                     sudo python setup.py install &&
#                     sudo python setup.py install --user

            #instalando via ppa
            #adicionando repositorio
            add-apt-repository ppa:nathan-renniewaldock/flux -y
            
            #atualizando lista pacotes
            apt update
            
            #instalando flux
            apt install fluxgui* -y
        fi
        
        #instalando o libreoffice
        if [[ $libreoffice == "s" ]]; then
                #adicionando ppa
                add-apt-repository ppa:libreoffice/ppa -y
               
               #instalando libreoffice
                apt install libreoffice* -y
        fi

        #instalando o vlc
        if [[ $vlc == "s" ]]; then
                apt install vlc* -y
        fi

        #instalando o netbeans
        if [[ $netbeans == "s" ]]; then
                echo "Baixando o Netbeans + JDK8"
                echo "A INSTALAÇÃO, PRECISARÁ DE SUA ATENÇÃO"
                echo "----------------------------------------------------------------------"
                #baixando o arquivo
                wget -c http://download.oracle.com/otn-pub/java/jdk-nb/8-8.0/jdk-8-nb-8-linux-x64.sh?AuthParam=1395311377_7cbe28b25486a89be5d8399b8a43c7a6 -O netbeans.sh
                echo "Realizando a instalação..."
                echo "----------------------------------------------------------------------"
                #alterando permissao de execucao
                chmod +x netbeans.sh

                #execuntando arquivo
                ./netbeans.sh

                #removendo arquivo
                rm netbeans-8.2-linux.sh
        fi

        if [[ $clementine == "s" ]]; then
                #instalando o clementine
                apt install clementine* -y
        fi

        if [[ $gparted == "s" ]]; then
                #instalando o gparted
                apt install gparted* -y
        fi

        if [[ $tlp == "s" ]]; then
                #instalando o tlp
                apt install tlp* -y
        fi

        if [[ $rar == "s" ]]; then
                #instalando o rar
                apt install rar* -y
        fi

        if [[ $git == "s" ]]; then                    
                #instalando o git
                apt install git-core git* gitg* -y                                                        
        fi

        if [[ $lmsensors == "s" ]]; then
                #instalando o lmsensors
                apt install lm-sensors -y
        fi

        if [[ $stellarium == "s" ]]; then
                #instalando o stellarium
                apt install stellarium* -y
        fi

        if [[ $texmaker == "s" ]]; then
                #instalando o texmaker
                apt install texmaker* -y
        fi

        if [[ $gnometerminal == "s" ]]; then
                #instalando o gnometerminal
                apt install gnometerminal* -y
        fi

        if [[ $reaver == "s" ]]; then
                #instalando o reaver
                apt install reaver
        fi

        if [[ $tor == "s" ]]; then
                #baixando o tor
#               wget https://dist.torproject.org/torbrowser/6.0.7/tor-browser-linux32-6.0.7_en-US.tar.xz -O tor-browser.tar.xz

                #extraindo o arquivo
#               sudo tar -xvJf tor-browser.tar.xz -C /opt/

                #movendo arquivos
#               sudo mv /opt/tor-browser*/ /opt/tor-browser

                #VERIFICAR
#               sudo ln -sf /opt/tor-browser/Browser/start-tor-browser /usr/bin/torbrowser

                #removendo arquivo download
#               rm tor-browser.tar.xz
                
                #32bits
                #add-apt-repository ppa:upubuntu-com/tor64 -y
                #apt update
                #apt-get install tor-browser* -y

                #64bits
                #adicinando repositorio
                add-apt-repository ppa:upubuntu-com/tor64 -y
                
                #atualizando lista de pacotes
                apt-get update            
                
                #instalando tor
                apt-get install tor-browser -y
        fi

        if [[ $vba == "s" ]]; then
#VERIFICAR NAO ESTA FUNCIONANDO	
                #corrigindo dependencias
                apt install -f -y

                #adicionando dependencias
                apt install cmake libgtkmm-2.4-dev libglademm-2.4-dev libgtkglextmm-x11-1.2-dev libsdl1.2-dev checkinstall -y

                #corrigindo dependencias
                apt install -f -y

                #baixando vba
                wget https://sourceforge.net/projects/vbam/files/Linux%20Binaries/VBA-M%202.0.0%20Beta%201%20-%20Ubuntu%20-%2064%20bits.zip/download

                #extraindo pasta
                unzip vba.zip -d vba && clear && echo "Arquivo extraido com sucesso!"

                #entrando na pasta
                cd vba/VBA-M\ 2.0.0\ Beta\ 1\ -\ Ubuntu\ -\ 64\ bits/15.04

                #instalando pacotes deb
                dpkg -i *.deb

                #voltando pasta origem
                cd .. && cd .. && cd ..

                #removendo arquivos criados
                rm -rf vba && rm vba.zip
        fi
        
        if [[ $android == "s" ]]; then
                #adicionando repositorio
                apt-add-repository ppa:paolorotolo/android-studio

                #atualizando lista de repositorios
                apt update

                #instalando android studio
                apt install android-studio
        fi
            
        if [[ $ntp == "s" ]]; then
                #instalando software necessario
                apt install ntpdate* -y

                #realizando atualizacao hora/data
                echo "Atualizando hora do servidor"
                echo "Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"

                #servidor 1
                echo "Servidor ntp.cais.rnp.br"
                        /usr/sbin/ntpdate ntp.cais.rnp.br

                #servidor 2			
                echo "Servidor ntp.ansp.br"
                        /usr/sbin/ntpdate ntp.ansp.br

                echo "Data e hora atual: `date +%d/%m/%Y" "%H:%M:%S`"
                echo "Hora do servidor atualizada!"
        fi
        
        if [[ $hollywood == "s" ]]; then
                #instalando recurso para hackear a matrix
                apt install hollywood
        fi
        
        if [[ $synaptic == "s" ]]; then
            #instalando o synaptic
            apt install synaptic* -y
        fi
        
        if [[ $dolphin == "s" ]]; then
                #adicionando repositorio do dolphin
                add-apt-repository ppa:glennric/dolphin-emu -y
                
                #atualizando lista de repositorios
                apt update
                
                #corrigindo problemas de dependencias
                apt-get install -f

                #instalando dolphin
                apt install dolphin-emu* -y
                #apt-get install dolphin-emu-master
        fi

        if [[ $visualbox == "s" ]]; then
                #baixando o arquivo 		
                wget http://download.virtualbox.org/virtualbox/5.1.10/virtualbox-5.1_5.1.10-112026~Ubuntu~yakkety_amd64.deb -O virtualbox.deb
                #executando o arquivos
                dpkg -i virtualbox.deb

                #removendo o arquivo baixando
                rm virtualbox.deb
        fi
        
        
        if [[ $citra == "s" ]]; then
                #SDL2
                #apt-get install sdl2
                #apt-get install libsdl2-2.0-0
                apt-get install libsdl2-dev

                #Qt
                apt-get install qtbase5-dev libqt5opengl5-dev

                #GCC
                apt-get install build-essential

                #Cmake
                apt-get install cmake

                #Clang
                apt-get install clang libc++-dev

                #copiando repositorio
                git clone --recursive https://github.com/citra-emu/citra
                
                #entrando na pasta
                cd citra
                
                #construindo o citra
                mkdir build && cd build
                cmake ..
                make
                make install 	
        fi
        
        if [[ $mesa == "s" ]]; then
                #instalando ppa-purge
                apt install ppa-purge -y

                #adicionando repositorio
                add-apt-repository ppa:paulo-miguel-dias/pkppa -y

                #atualizando lista pacotes
                apt update 
                
                #atualizando sistema
                apt-get dist-upgrade
        
                #removendo caso erro
                #ppa-purge ppa:paulo-miguel-dias/pkppa
        fi
            
        if [[ $mutate == "s" ]]; then
                #instalando dependencias
                #apt-get install build-essential qt5-qmake qt5-default libgtk2.0-dev libqt5x11extras5-dev libboost-regex-dev
        
                #baixando pacote
                #wget https://github.com/qdore/Mutate/releases/download/v2.3/Mutate-2.3.deb -O Mutate-2.3.deb
                
                #instalando			
                #sudo dpkg -i Mutate-2.3.deb
                
                #removendo 
                #rm -r Mutate-2.3.deb
                
                #adicionando ppa
                #add-apt-repository ppa:mutate/ppa -y

                #atualizando sistema
                #apt-get update -y

                #atualizando mutate
                #apt-get install mutate -y
                
                #git clone https://github.com/qdore/Mutate.git
                #cd Mutate/src
                #qmake
                #make
                #sudo make install
                
                #cd ..
                #sudo cp info/mutate.png /usr/share/icons
                #sudo cp info/Mutate.desktop /usr/share/applications
                #mkdir -p ~/.config/Mutate
                #cp -R config/* ~/.config/Mutate
                #chmod -R a+x ~/.config/Mutate/scripts
                #chmod -R a+w ~/.config/Mutate
                #sed -i "s|{home}|$HOME|g" ~/.config/Mutate/config.ini
                echo
        fi
        
        if [[ $screenfetch == "s" ]]; then
                #instalando o screenfetch
                apt install screenfetch -y
        fi
        
        if [[ $diolinux_paper == "s" ]]; then
                #adicionando ppa			
                add-apt-repository ppa:tiagosh/diolinux-paper-orange -y

                #atualizando sistema
                apt update

                #instalando tema
                apt install diolinux-paper-orange -y
        fi
        
        if [[ $kdenlive == "s" ]]; then
                #adicionando ppa
                add-apt-repository ppa:sunab/kdenlive-release -y

                #atualizando sistema
                apt update

                #instalando kdenlive	
                apt install kdenlive -y
        fi
        
        if [[ $openssh == "s" ]]; then
                #instalando modo servidor
                apt install openssh-server -y

                #instalando modo cliente	
                apt install openssh-client -y
                
                #mostrando ao usuario como acessar
                echo "----------------------------------------------"
                echo "Você pode utilizar o acesso remoto através de:"
                echo "ssh nomeusuario@iproteador"
                echo "----------------------------------------------"
        fi
        
        if [[ $bleachbit == "s" ]]; then
                #instalando bleachbit		
                apt install bleachbit -y
        fi	
        
        if [[ $supertuxkart == "s" ]]; then
                #instalando supertuxkart				
                apt install supertuxkart -y	
        fi	
                
        if [[ $cowsay == "s" ]]; then
                #instalando cowsay
                apt install cowsay* -y
        fi
        
        if [[ $chromium == "s" ]]; then
                #instalando chromium		
                apt install chromium-browser -y
        fi
        
        if [[ $synapse == "s" ]]; then
                #instalando o synapse
                apt install synapse* -y
        fi
        
        if [[ $sweethome3d == "s" ]]; then
                #instalando o sweethome3d
                apt install sweethome3d* -y
        fi	
        
        if [[ $kate == "s" || $padrao == "y" ]]; then
                #instalando o kate
                apt install kate* -y
        fi
        
        if [[ $inkscape == "s" ]]; then
                #instalando inkscape
                apt-get install inkscape* -y                
        fi
            
        if [[ $blender == "s" ]]; then
                #instalando o blender
                apt-get install blender* -y
        fi
                
        if [[ $cheese == "s" ]]; then
                #instalando o cheese
                apt-get install cheese* -y
        fi
        
        if [[ $numixicon == "s" ]]; then
                #adicionando PPA
                add-apt-repository ppa:numix/ppa -y
                
                #atualizando lista repositorios
                apt-get update
            
                #instalando numixicon
        fi    
        
        if [[ $plank == "s" ]]; then
                #adicionando ppa
                add-apt-repository ppa:noobslab/apps -y
                
                #atualizando lista repositorios
                apt-get update
                
                #instalando plank
                apt-get install plank* plank-themer -y
        fi
        
        if [[ $gnomesystemmonitor == "s" ]]; then
                #instalando gnomesystemmonitor
                apt install gnome-system-monitor* -y                                        
        fi
                
        if [[ $nautilus == "s" ]]; then
                #adicionando ppa
                add-apt-repository ppa:gnome3-team/gnome3 -y
                
                #atualizando lista repositorio
                apt update
        
                #instalando o nautilus
                apt install nautilus* -y            
        fi
        
        if [[ $wireshark == "s" ]]; then
                #instalando o wireshark
                apt install wireshark* -y
        fi
        
        if [[ $gnomediskutility == "s" ]]; then
                #instalando o gnomediskutility
                apt install gnome-disk-utility* -y
        fi
        
        if [[ $smartgit == "s" ]]; then
                #adicionando repositorio
                add-apt-repository ppa:eugenesan/ppa -y

                #atualizando lista pacotes
                apt-get update

                #instalando smartgit
                apt-get install smartgit smartgithg* -y
        fi
        
        if [[ $chkrootkit == "s" ]]; then
                #instalando o chkrootkit
                apt install chkrootkit* -y
        fi
        
        if [[ $vivacious == "s" ]]; then
            #adicionando ppa
            add-apt-repository ppa:ravefinity-project/ppa -y

            #atualizando lista pacotes
            apt-get update

            #instalando vivacious
            apt-get install vivacious-colors* -y
            apt-get install vivacious-folder-colors-addon* -y
            apt-get install vivacious-colors-gtk-dark* -y
            apt-get install vivacious-colors-gtk-light* -y
        fi
        
        if [[ $lampp == "s" ]]; then
            #instalando apache
            apt-get install apache2 apache2-utils -y
            
            #instalando ssl(paginas seguras)
            apt-get install ssl-cert		                
        fi
        
        if [[ $php == "s" ]]; then
            #instalando php
            apt-get install php5 -y
            
            #instalando modulo apache php
            apt-get install libapache2-mod-php5 -y				
            
            #integração postgreSQL
            apt-get install php5-pgsql -y
            
            #reiniciando o apache
            /etc/init.d/apache force-reload
            
            #instalando phpmyadmin
            apt-get install phpmyadmin -y
        fi
        
        if [[ $mysql == "s" ]]; then
            #integração mysql
            apt-get install php5-mysql -y
            
            #instalando mysql server
            apt-get install mysql-server -y
            
            #carregamento automatico boot
            chkconfig mysqld on
            
            #criando base dados padrao
            mysql_install_db
            
            #ativando servidor mysql
            /etc/init.d/mysql start
        fi
        
        if [[ $ftp == "s" ]]; then
            #instalando o proftpd
            apt-get install proftpd -y
            
            #instalando o tls
            apt-get install openssl -y
            
            #criando diretorio para armazenar os certificados de validação
            mkdir /etc/proftpd/cert
            
            #gerando certificados
            openssl req -new -x509 -days 3650 -nodes -out \ /etc/proftpd/cert/proftpd.cert.pem -keyout /etc/proftpd/cert/proftpd.key.pem
        fi
        
        if [[ $quota == "s" ]]; then
            #instalando o quota
            apt-get install quota quotatool -y
            
            #ativando o modulos
            modprobe quota_v2
        fi
        
        if [[ $flatabulous == "s" ]]; then
            #adicionando ppa
            add-apt-repository ppa:noobslab/icons -y
            
            #atualizando lista pacotes
            apt-get update 
            
            #instalando o flatabulous
            apt-get install ultra-flat-icons-orange -y
        fi
                
        if [[ $gnomesystemtools == "s" ]]; then
            #instalando o gnomesystemtools
            apt install gnome-system-tools -y
        fi
        
        if [[ $brightside == "s" ]]; then
            #instalando o brightside
            apt install brightside* -y
        fi
        
        if [[ $squarebeam == "s" ]]; then
            #adicionando ppa
            add-apt-repository ppa:noobslab/icons -y
            
            #atualizando lista pacotes repositorio
            apt-get update
            
            #instalando tema de icones
            apt-get install square-beam-icons -y
        fi

        if [[ $liquorix == "s" ]]; then
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
        fi
        
        if [[ $moka == "s" ]]; then
            #adicionando ppa
            add-apt-repository ppa:moka/stable -y

            #atualizando lista repositorio
            apt-get update 

            #instalando tema
            apt-get install moka-icon-theme -y
        fi
        
        if [[ $mousepad == "s" ]]; then
            #instalando mousepad
            apt install mousepad* -y
        fi        
            
################################################################################		
######REINICIANDO
    #reiniciando a maquina
    if [[ $reinicia == "s" ]]; then
            #reiniciando a maquina em dois minutos
#VERIFICAR	sudo reboot -t 120
            reboot
    fi
}

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
    echo "Digite 5 para reiniciar a máquina."
    echo "Digite 6 para sair do script;"
    echo "----------------------------------------" 
    read -n1 -p "Ação:" escolha
    clear
    case $escolha in
    
    #atualizando o sistema
    1) echo            
        update
        upgrade	
        kernel
        ;;    
        
    #corrigindo erros
    2) echo
        corrigeerros
        swap
        pacotesquebrados
        fontes
        ;;
    
    #limpando a máquina
    3) echo
        temporario
        obsoleto
        arquivosorfaos
        arquivosinuteis
        prelink_preload_deborphan
        pacotes_antigos
        ;;
            
    #instalando programas	
    4) echo
            echo "Categorias"            
            #chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]
            echo "---------------------------------------------------------"
            #######VERIFICAR
            echo "Digite 0 para instalar todos os programas das categorias,"
            echo "---------------------------------------------------------"
            echo "Digite 1, para entrar na área de Jogos,"
            echo "Digite 2, para entrar na área de Multimidia, "
            echo "Digite 3, para entrar na área de Escritório," 
            echo "Digite 4, para entrar na área de Internet," 
            echo "Digite 5, para entrar na área de Desenvolvimento,"
            echo "Digite 6, para entrar na área de Gráficos,"
            echo "Digite 7, para entrar na área de Personalização do sistema,"
            echo "Digite 8, para entrar na área de outros programas,"
            echo "Digite 9, para instalar os programas padrões;"
            echo "---------------------------------------------------------"
            echo "Digite X, para sair do script;"
            echo "---------------------------------------------------------"
            read -n1 -p "Ação:" categoria
            clear
            case $categoria in
                #instalando todos os programas
                0) echo
#                   tudo
                    ;;
                    
                #jogos
                1) echo 
                    steam
                    supertuxkart
                    wine
                    playonlinux
                    citra
                    dolphin
                    ;;
                
                #multimidia
                2) echo 
                    cheese    
                    spotify
                    vlc
                    clementine
                    kdenlive
                    ;;
                
                #escritorio
                3) echo 
                    libreoffice            
                    texmaker 
                    ;;
                        
                #internet
                4) echo 
                    firefox    
                    chromium
                    tor                         	                                                                                              
                    ;;
                        
                #desenvolvimento        
                5) echo 
                    kate
                    xampp
                    java
                    android
                    netbeans
                    lammp
                    php
                    mysql
                    ftp
                    quota
                    ;;
                
                #graficos
                6) echo 
                    sweethome3d            
                    inkscape
                    blender
                    gimp
                    ;;
                    
                #personalizacao    
                7) echo    
                    cowsay
                    mac
                    codecs
                    screenfetch
                    diolinux_paper
                    xfce
                    redshift
                    flux
                    numixicon
                    plank                    
                    nautilus
                    vivacious
                    flatabulous
                    gnomesystemtools
                    brightside
                    squarebeam
                    liquorix
                    moka
                    ;;                    
                    
                #outros programas
                8) echo 
                    ntp
                    openssh
                    bleachbit                           
                    synapse
                    tlp
                    rar
                    git
                    lmsensors
                    gnometerminal
                    reaver
                    gnomesystemmonitor
                    hollywood
                    synaptic            
                    mesa
                    mutate
                    gparted            
                    stellarium            
                    virtualbox
                    wireshark
                    gnomediskutility
                    smartgit
                    chkrootkit                    
                    ;;
                    
                #programas padroes    
                9) echo
                    #desenvolvimento
                        kate
                        xampp
                        java
                        netbeans
                    
                    #internet
                        firefox
                        tor
                    
                    #escritorio
                        libreoffice
                        texmaker
                        mousepad
                    
                    #graficos
                        sweethome3d
                        gimp
                        inkscape
                    
                    #jogos
                        wine
                        playonlinux
                        dolphin
                        steam
                        visualgameboyadvanced
                    
                    #multimidia
                        cheese
                        spotify
                        vlc
                        clementine
                    
                    #personalização
                        mac
                        codecs
                        xfce
                        plank
                        gnomesystemmonitor
                        nautilus
                        moka
                    
                    #outros
                        ntp
                        tlp
                        rar
                        git 
                        stellarium
                        virtualbox
                        flux
                    ;;
                    
                #voltando ao menu anterior        
                v|V) echo 
                    menu
                    ;;
                        
                #fechando        
                x|X)echo Finalizando o script...
                    sleep 1
                    clear        
                    exit                    
                    ;;

                *)  echo Alternativa incorreta!!
                    sleep 1
                    menu
                    exit
                    ;;
            esac
            ;;
    #reiniciando	
    5) echo
            reinicia
            ;;
    
    #saindo
    6) echo 	
            exit
            ;;
            
    #entrada inválida	
    *) echo
            echo Alternativa incorreta!!
            sleep 1
            menu
            exit
            ;;
    esac

#inicia as funções que o usuário escolheu, executando primeiro as que ele deseja, posteriormente mostrando as que ele não quis realizar.
    install_yes
    #install_no

    echo "TAREFAS FINALIZADAS, SAINDO.."
    clear
}

################################################################################
auto_config_fedora()
{
    echo "INICIANDO AS TAREFAS"
            #chama as funções para serem realizadas[pergunta ao usuário quais ações ele deseja realizar]
            
    #inicia as funções que o usuário escolheu, executando primeiro as que ele deseja, posteriormente mostrando as que ele não quis realizar.
        update
        upgrade	
        arquivosinuteis		
}

################################################################################
#mostrando mensagem inicial
menu()
{
    clear
    echo "Bem vindo ao script de automação de tarefas em Linux"
    echo "Ele irá realizar os seguintes passos"
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
                                clear
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