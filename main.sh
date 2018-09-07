#!/usr/bin/env bash
#
# Arquivo de referencia
cd Auto_Config

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
	if [[ $1 == "interface" ]]; then
		interface	
	else
		default
	fi
	
}

# chamando funcao principal
main $1
