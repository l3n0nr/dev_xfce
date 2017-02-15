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
# versão do script: 1.0.140.6.17.5 #
####################################
#
# legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1];
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
#
################################################################################
######VERIFICANDO USUARIO ROOT
if [[ `id -u` -ne 0 ]]; then
    clear
    echo "Você precisa ter poderes administrativos (root)"
    echo "O script está sendo finalizado ..."
    sleep 3
    exit
fi
################################################################################
######ATUALIZA SISTEMA
atualiza()
{
    clear
    echo ""
    echo "Deseja atualizar o sistema (s/n)? "
    read -p "??" atualiza
}

################################################################################
######CORRIGE SISTEMA
corrige()
{
    clear
    echo ""
    echo "Deseja corrigir os problemas do sistema (s/n)? "
    read -p "??" corrige
}

################################################################################
######LIMPA SISTEMA
limpa()
{
    clear
    echo ""
    echo "Deseja realizar um limpeza no sistema (s/n)? "
    read -p "??" limpa
}

################################################################################
######INSTALANDO PROGRAMAS
instala()
{
    clear
    echo ""
    echo "Deseja instalar os programas padrões no sistema (s/n)? "
    read -p "??" instala
}

################################################################################
######REINICIANDO SISTEMA
reinicia()
{
    clear
    echo ""
    echo "Deseja reiniciar o sistema (s/n)? "
    read -p "??" reinicia
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
            atualiza
            
        #corrigindo erros
        2) echo
            corrige
            
        #realizando limpeza
        3) echo
            limpa
            
        #instalando programas
        4) echo
            instala
            
        #reiniciando	
        5) echo
            reinicia 
            
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