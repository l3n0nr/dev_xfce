#!/bin/zsh -f
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
output_file="/tmp/config_user.txt"

f_redshift()
{
	printf "\n[*] Copiando configuracao padrao do Redshift\n" >> $output_file

	cat base/redshift.conf > $HOME/.config/redshift.conf 
}

f_zsh()
{
	var_zsh=$(which zsh)

	## Definindo ZSH como padrao
	if [[ ! -e $var_zsh ]]; then
		printf "\n[-] ZSH nao esta instalado!\n" >> $output_file
	else	
		printf "\n[*] Alterando bash padrao\n"	>> $output_file
		chsh -s /bin/zsh
	fi

	## configuraçoes do ZSH
	printf "\n[*] Copiando arquivo padrao ZSH\n" >> $output_file
	cat base/.zshrc > $HOME/.zshrc

	## commands as you type, based on command history
	if [ -e "$HOME/.zsh/zsh-autosuggestions" ]; then
		printf "\nVoce ja possui o zsh-autosuggestions" >> $output_file
	else
		printf "\n[+] Baixando zsh-autosuggestions\n" >> $output_file
		git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
	fi

	## framework
	if [ -e "$HOME/.oh-my-zsh" ]; then
		printf "\nVoce ja possui o Oh-my-zsh" >> $output_file
	else
		printf "\n[+] Baixando oh-my-zsh" >> $output_file
		printf "\n[*] Entrando na pasta do usuario" >> $output_file
		cd $HOME
		sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	fi
}

f_mega()
{
	## imagens
	var_mega="/home/lenonr/MEGA"
	var_mega_img="/home/lenonr/MEGA/Imagens"

	var_imagens_user="/home/lenonr/Imagens"
	var_download_user="/home/lenonr/Downloads"

	# verifica se pasta mega existe
	if [ -e $var_mega ]; then 
		# lista pasta e monta vetor
		arq_pasta=($(ls -C $var_mega_img))	# verifica vetor zsh
			
		# percorre lista de arquivos na pasta $var_mega_img
		for (( i = 0; i <= ${#arq_pasta[@]}; i++ )); do	
			# testa se pasta existe
			if [[ -e "$var_imagens_user/${arq_pasta[$i]}" ]]; then 				
				# echo "Link ja existe!"
				echo >> /dev/null
			else
				ln -rs $var_mega_img/${arq_pasta[$i]} $var_imagens_user
			fi
		done	

		# ## arquivo mega
		# # se pasta for encontrada
		if [ -e $var_download_user ]; then 		
			# # se pasta for encontrada
			if [[ -e $var_download_user/Arquivos/MEGA ]]; then
				echo >> /dev/null
			else			
				mkdir -p $var_download_user/Arquivos
				ln -rs $var_mega/Arquivos $var_download_user/Arquivos/MEGA
			fi
		else
			echo "Pasta $var_download_user nao encontrada!"		
		fi

	else
		echo "Pasta $var_mega_img nao encontrada!"		
	fi	
}

main()
{
	f_redshift
	f_zsh
	f_mega
}

# chamando script
main
