#!/bin/bash

#verificando se o usuário é ROOT
if [[ `id -u` -ne 0 ]]; then
    clear
    echo "Você precisa ter poderes administrativos (root)"
    echo "O script está sendo finalizado ..."
    sleep 3
    exit
fi

################################################################################
######CORREÇÃO SISTEMA
atualiza_tudo()
{
    clear
    echo ""
    echo "Deseja realizar todas as funções do 'atualiza tudo' (s/n)? "
    read -p "??" atualiza_tudo
}

update()
{
    clear
    echo ""
    echo "Deseja atualizar os repositórios de sua máquina (s/n)?"
    read -p "??" update        
}

upgrade()
{
    clear
    echo ""
    echo "Deseja atualizar os programas de sua máquina (s/n)?"
    read -p "??" upgrade        
}


if [[ $atualiza_tudo == "s" || $upgrade == "s" ]]; then
    clear
    echo "Atualizando os programas da máquina"
    echo "----------------------------------------------------------------------"
    apt upgrade -y
    apt-get dist-upgrade    
fi

if [[ $atualiza_tudo == "s" || $update == "s" ]]; then
    clear
    echo "Atualizando os repositórios na máquina"
    echo "----------------------------------------------------------------------"
    apt update
    update-grub                
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
    clear
    case $escolha in
    
    #atualizando o sistema
    1) echo        
    
        #verificando
        clear
        echo ""
        echo "Deseja corrigir todos os problemas do sistema(s/n)?"
        read -p "??" atualizatudo   
        
        if [[ $atualizatudo == "s" ]]; then
        {       
            update
            upgrade	
            kernel
        }
        fi
        ;;
            
    #corrigindo erros
    2) echo
        
        #verificando
        clear
        echo ""
        echo "Deseja corrigir todos os problemas do sistema(s/n)?"
        read -p "??" corrigetudo        
        
        if [[ $corrigetudo == "s" ]]; then
        {
            echo $corrigetudo
            corrigetudo
        }
        else
        {
            corrigeerros
            swap
            pacotesquebrados
            fontes
        }
        fi
        ;;
    
    #limpando a máquina
    3) echo
    
        #verificando
        clear
        echo ""
        echo "Deseja corrigir todos os problemas do sistema(s/n)?"
        read -p "??" limpatudo 
        
        if [[ $limpatudo == "s" ]]; then
        {
            limpatudo
        }
        else
        {
            temporario
            obsoleto
            lixeira
            firefoxcache
            firefoxcookie
            arquivosorfaos
            arquivosinuteis
            prelink_preload_deborphan
            pacotes_antigos
        }
        fi
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
                    audacity
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
                    midori 
                    tor                         	                                                                                              
                    ;;
                        
                #desenvolvimento        
                5) echo 
                    kate
                    xampp
                    java
                    nodejs
                    atom
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
                    ubuntudesktop
                    vivacious
                    flatabulous
                    materialdesign
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
                    figler                
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
                    gitkraken
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