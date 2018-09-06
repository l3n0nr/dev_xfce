#!/usr/bin/env bash
#
cd /home/lenonr/Github/dev_xfce/Auto_Config
#
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

main()
{
	interface
}

# chamando funcao principal
main