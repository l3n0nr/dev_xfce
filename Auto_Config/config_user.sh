#/bin/bash
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# variaveis
var_zsh=$(which zsh)

## REDSHIFT
printf "\n[*] Copiando configuracao padrao do Redshift\n"
cat base/redshift.conf > $HOME/.config/redshift.conf 

## Definindo ZSH como padrao
if [[ ! -e $var_zsh ]]; then
	printf "\n[-] ZSH nao esta instalado!\n"
else	
	printf "\n[*] Alterando bash padrao\n"	
	chsh -s /bin/zsh
fi

## configuraçoes do ZSH
printf "\n[*] Copiando arquivo padrao ZSH\n"
cat base/.zshrc > $HOME/.zshrc

## commands as you type, based on command history
if [ -e "$HOME/.zsh/zsh-autosuggestions" ]; then
	printf "\nVoce ja possui o zsh-autosuggestions"
else
	printf "\n[+] Baixando zsh-autosuggestions\n"
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
fi

## framework
if [ -e "$HOME/.oh-my-zsh" ]; then
	printf "\nVoce ja possui o Oh-my-zsh"
else
	printf "\n[+] Baixando oh-my-zsh"
	printf "\n[*] Entrando na pasta do usuario"
	cd $HOME
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

