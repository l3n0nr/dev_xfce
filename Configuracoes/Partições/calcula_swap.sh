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
# Referência: <http://sejalivre.org/entendendo-as-variaveis-em-shell-script/>
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
# # versão do script:           [0.0.5.0.0.0]    #
# # data de criação do script:    [29/09/17]      #
# # ultima ediçao realizada:      [29/09/17]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script;
# 	d = correções necessárias;
# 	e = pendencias    
# 	f = desenvolver
#
################################################################################
#
# # Script testado em
#	- Xubuntu 16.04
#       - Debian 9
#
# # Compativel com
#       - Ubuntu
#       - Debian 9
# 
################################################################################
# # FUNCOES
# 
# # # Calcula a quantidade de memória, de acordo com a máquina.
# 
################################################################################

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CORPO DO SCRIPT                                   #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

clear
echo "##############################################################"
echo "CALCULANDO DE MEMÓRIA SWAP"
echo "##############################################################"
# capturando a quantidade de memoria
tam_mem=$(free -mt | grep Mem: | awk '{ print $2 " MB" }' | sed -e "s; MB;;")

# mostrando memoria instalada
echo "Tamanho da memória do seu computador é $tam_mem MB."

# # # # # # # # # # # # # # # # # #
# TABELA DE APOIO PARA CONVERSAO  #
# # # # # # # # # # # # # # # # # #
# 
# 5 == 6  | [ 5 -eq 6 ]
# 5 != 6  | [ 5 -ne 6 ]
# 5 < 6   | [ 5 -lt 6 ]
# 5 <= 6  | [ 5 -le 6 ]
# 5 > 6   | [ 5 -gt 6 ]
# 5 >= 6  | [ 5 -ge 6 ]
# 
# # # # # # # # # # # # # # # # # 

# # realizando calculos
    # se valor for menor ou igual a 2GB
    if [ "$tam_mem" -le "2048" ]; then
        # aplicando taxa de calculo, baseando em 50% da memória real
        swap=$((($tam_mem * 5)/10))

    # se valor for menor ou igual a 4GB
    elif [ "$tam_mem" -lt "4092" ]; then
        # aplicando taxa de calculo, baseando em 30% da memória real
        swap=$((($tam_mem * 3)/10))    
        
    # qual outra opção 
    else
        # aplicando taxa de calculo, baseando em 10% da memória real
        swap=$((($tam_mem * 1)/10))    
    fi
    
    # mostrando valores
    echo
    echo "Tamanho da memória SWAP recomendada: $swap MB."
    
    echo     
    # realizando soma das memorias
    total=$(($tam_mem+$swap))
    
    # mostrand memoria total do computador
    echo "O seu computador ira conter $total MB de memória total."
    echo    
    
echo "##############################################################"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                  #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
