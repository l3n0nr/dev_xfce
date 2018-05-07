#/bin/bash
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
## ZSH
printf "Entrando na pasta do usuario"
printf "\n[*] Copiando arquivo padrao ZSH\n"
cat base/.zshrc > $HOME/.zshrc

printf "\nBaixando zsh-autosuggestions\n"
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/$HOME/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

if [ -e "$HOME/.oh-my-zsh" ]; then
	printf "\nVoce ja possui o Oh-my-zsh"
else
	printf "\nBaixando oh-my-zsh"
	cd $HOME
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

## REDSHIFT
cat base/redshift.conf > $HOME/.config/redshift.conf 
