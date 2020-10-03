#!/bin/zsh -f
#
# por l3n0nr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
##########################################
# 
# [MODO MANUAL]: 
# Ativar o UFW no modo padrao, para ter uma
#  camada de segurança extra no sistema!
#
##########################################
#
output_file="/tmp/config_user.txt"

f_redshift()
{
	printf "[*] Configuracao padrao do redshift atualizada! \n"
	printf "[*] Configuracao padrao do redshift atualizada!" >> $output_file

	cat ../base/redshift.conf > $HOME/.config/redshift.conf 
}

f_zsh()
{
	var_zsh=$(which zsh)

	## Definindo ZSH como padrao
	if [[ ! -e $var_zsh ]]; then
		printf "[-] ZSH nao esta instalado! \n"
		printf "[-] ZSH nao esta instalado! \n" >> $output_file
	else			
		printf "[*] Alterando bash padrao \n"
		printf "[*] Alterando bash padrao \n"	>> $output_file

		chsh -s /bin/zsh
	fi

	## configuraçoes do ZSH
	printf "[*] Copiando arquivo padrao ZSH \n"
	printf "[*] Copiando arquivo padrao ZSH \n" >> $output_file

	cat ../base/.zshrc > $HOME/.zshrc

	## commands as you type, based on command history
	if [ -e "$HOME/.zsh/zsh-autosuggestions" ]; then
		printf "[-] Voce ja possui o zsh-autosuggestions \n"
		printf "[-] Voce ja possui o zsh-autosuggestions \n" >> $output_file
	else
		printf "[+] Baixando zsh-autosuggestions \n"
		printf "[+] Baixando zsh-autosuggestions \n" >> $output_file

		git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
	fi

	## framework
	if [ -e "$HOME/.oh-my-zsh" ]; then
		printf "[-] Voce ja possui o Oh-my-zsh \n"
		printf "[-] Voce ja possui o Oh-my-zsh \n" >> $output_file
	else
		printf "[+] Baixando oh-my-zsh \n"
		printf "[+] Baixando oh-my-zsh \n" >> $output_file

		cd $HOME
		sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	fi
}

f_mega()
{
	## imagens
	var_mega="/home/lenonr/MEGA"
	var_mega_img="/home/lenonr/MEGA/Imagens"
	var_mega_mus="/home/lenonr/MEGA/Musica"

	var_imagens_user="/home/lenonr/Imagens"
	var_download_user="/home/lenonr/Downloads"
	var_music_user="/home/lenonr/Música"
	
	# verifica se pasta mega existe
	if [ -e $var_mega ]; then 		
		### imagens - /home/$USER/Images
		# lista pasta e monta vetor
		arq_pasta=($(ls -C $var_mega_img))
			
		# percorre lista de arquivos na pasta $var_mega_img
		for (( i = 0; i <= ${#arq_pasta[@]}; i++ )); do	
			# testa se pasta existe
			if [[ -e "$var_imagens_user/${arq_pasta[$i]}" ]]; then 				
				echo "[-] Link $var_imagens_user/${arq_pasta[$i]} ja existe! \n"				
			else
				echo "[+] Link criado: $var_imagens_user/${arq_pasta[$i]} \n"

				ln -rs $var_mega_img/${arq_pasta[$i]} $var_imagens_user
			fi
		done	

		### atalhos mega - /home/$USER/Downloads
		# # se pasta for encontrada
		if [ -e $var_download_user ]; then 		
			# # se pasta for encontrada
			if [[ -e $var_download_user/Arquivos/MEGA ]]; then
				echo "[-] Link $var_download_user/Arquivos/MEGA ja existe! \n "
			else			
				echo "[+] Criando link $var_download_user/Arquivos/MEGA \n"

				mkdir -p $var_download_user/Arquivos
				ln -rs $var_mega/Arquivos $var_download_user/Arquivos/MEGA
			fi
		else
			echo "[-] Pasta $var_download_user nao encontrada! \n"		
		fi

		### arquivos musica - /home/$USER/Music
		# # se pasta for encontrada
		if [ -e $var_music_user ]; then 		
			# # se pasta for encontrada
			if [[ -e $var_music_user/Classic_Music ]]; then
				echo "[-] Link $var_music_user/Classic_Music ja existe! \n"
			else			
				echo "[+] Criando link $var_music_user/Classic_Music \n"

				mkdir -p $var_music_user/Classic_Music
				ln -rs $var_mega_mus/Classic_Music/* $var_music_user/Classic_Music
			fi
		else
			echo "[-] Pasta $var_download_user nao encontrada! \n"		
		fi
	else
		echo "[-] Pasta $var_mega_img nao encontrada! \n"		
	fi	
}

main()
{
	clear

	if [[ $1 == "redshift" ]]; then
		f_redshift
	elif [[ $1 == "zsh" ]]; then
		f_zsh
	elif [[ $1 == "mega" ]]; then
		f_mega
	elif [[ $1 == "ajuda" ]]; then
		echo "Voce pode chamar como paramentros:"
		echo "f_redshift, ou"
		echo "f_zsh, ou"
		echo "f_mega"
		echo "Por enquanto, e isso!!"
	else
		f_redshift
		f_zsh
		f_mega
	fi		
}

# chamando script
main $1
