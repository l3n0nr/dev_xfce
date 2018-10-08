#!/usr/bin/env bash
#
##################################################################
### DESCRICAO
# 	Trabalhando com chave publica no git
# 			github.com/articles/connecting-to-github-with-ssh/
# 
## INI_MOD: 08/10/18
## ULT_MOD: 08/10/18
##################################################################
#
# VARIAVEIS
email="lenonrmsouza@gmail.com"
vetor=(f_localhome f_checkkeyssh f_ssh_key f_eval f_ssh_add f_xclip f_checkssh)

f_checkkeyssh()
{
	ls -la ~/.ssh | grep id_rsa >> 2

	if [[ $? -eq 0 ]]; then
		echo "Voce ja possui a chave SSH... "
		exit 1
	fi
}

f_localhome()
{
	cd $HOME
}

f_ssh_key()
{
	## generate key
	ssh-keygen -t rsa -b 4096 -C "$email"
}

f_eval()
{
	eval "$(ssh-agent -s)"
}

f_ssh_add()
{
	ssh-add ~/.ssh/id_rsa
}

f_xclip()
{
	xclip -sel clip < ~/.ssh/id_rsa.pub
}

f_help()
{
	echo "Now... Access you account in the github and add xclip code in ~Setting/New SSH key~ "
}

f_checkssh()
{
	ssh -T git@github.com
}

# chamando funcoes
main()
{
	clear 

    for (( i = 0; i <= ${#vetor[@]}; i++ )); do             
        # executando acoes
        ${vetor[$i]} 
    done
}

# chamando funcao principal
main

##################################################################
### RODAPE
##################################################################