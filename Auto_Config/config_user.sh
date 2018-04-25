#/bin/bash
#
#
## ZSH
printf "Entrando na pasta do usuario"

printf "\n[*] Copiando arquivo padrao ZSH"
cat base/.zshrc > $HOME/.zshrc

printf "Baixando zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/$HOME/.zsh/zsh-autosuggestions

printf "Baixando oh-my-zsh"
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

## REDSHIFT
cat base/redshift.conf > $HOME/.config/redshift.conf 
