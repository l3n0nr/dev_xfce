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
# por Lucas Alves Santos
# 	<https://www.vivaolinux.com.br/script/Instalar-Tor-Browser/>
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
# por Vinícius Vieira
#        <http://sejalivre.org/instalando-o-tor-browser-no-ubuntu-e-linux-mint/>
#
# por Dionatan Simioni
# 	 <http://www.diolinux.com.br/2016/12/drivers-mesa-ubuntu-ppa-update.html>
#    	 <http://www.diolinux.com.br/2016/12/diolinux-paper-orange-modern-theme-for-unity.html>
# 	 <http://www.diolinux.com.br/2014/08/versao-nova-kdenlive-ppa.html>
# 	 <http://www.diolinux.com.br/2015/04/como-atualizar-kernel-para-a-ultima-versao-no-ubuntu.html>
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
# versão do script: 1.0.156.0.17.5 #
####################################
#
# legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1];
# 	b = erros na execução;	
# 	c = interações com o script + versões funcionando;
# 	d = correções necessárias;
# 	e = pendencias
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
# FUNCOES
#
################################################################################
######ATUALIZA SISTEMA
# # [+] Update
# #     [+] Update-Grud
# # [+] Upgrade
# # [+] Kernel 
# #     [+] Remove antigos
# #     [+] Atualiza novo
# # 
################################################################################
######CORRIGE SISTEMA
# # [+] Swap
# # [+] Prelink, Preload, Deborphan
# # [+] Pacotes com problemas
# # [+] Fontes
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
# # [+] Tor
# # [+] NTP
# # [+] Hollywood
# # [+] Synaptic	
# # [+] Virtualbox
# # [+] Citra
# # [+] Mesa - ppa
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
# #
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
    echo "Digite 5 para reiniciar a máquina."
    echo "Digite 6 para sair do script;"
    echo "----------------------------------------" 
    read -n1 -p "Ação:" escolha
    
    ##CHAMANDOS FUNCOES    
    #     
    ################################################################################
    ######ATUALIZA SISTEMA
        clear
        case $escolha in    
            #atualizando o sistema
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
        esac
        
    ################################################################################
    ######CORRIGE SISTEMA
        clear
        case $escolha in    
            #corrigindo erros
            2) echo              
            
                if [ "$distro" == "Ubuntu" ]; then
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
                else
                    echo "Função incompativel"
                fi
        esac
        
#                 
        #entrada inválida	
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