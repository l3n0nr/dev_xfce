#!/usr/bin/env bash
#
dir="/home/lenonr/Github/dev_xfce/Auto_Config"

main()
{
	# Arquivo de referencia
	cd $dir

	if [[ $? == 0 ]]; then
		su root v5.sh $@
	else
		clear
		printf "[-] ERRO ao acessar pasta $dir!!\n"
		exit 1
	fi		
}

# chamando funcao principal
main $@