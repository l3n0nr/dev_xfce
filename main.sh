#!/usr/bin/env bash
#
dir="/home/lenonr/Github/dev_xfce/Auto_Config"

interface()
{
	if [[ $? -eq 0 ]]; then
		su root v5.sh interface

		if [[ $? -eq 0 ]]; then
			exit 0
		else
			exit 1
		fi
	fi
}

default()
{
	source v5.sh
}

main()
{
	# Arquivo de referencia
	cd $dir

	if [[ $? == 0 ]]; then
		if [[ $1 == "interface" ]]; then
			interface	
		else
			default
		fi
	else
		clear
		printf "[-] ERRO ao acessar pasta $dir!!\n"
		exit 1
	fi		
}

# chamando funcao principal
main $1
