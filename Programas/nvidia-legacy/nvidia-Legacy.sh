#!/bin/bash
# Nvidia-Legacy Driver Installer-Jessie
# GNU Public License V.3
#Script desenvolvido pela robolinux https://www.robolinux.org/
#traduzido e adaptdado por claudio a. silva

echo "Este driver supporta legacy GeForce 6xxx e 7xxx GPUs"
echo "se o seu modelo for diferente, favor abortar a instalação do driver"
echo "pressionando control+C ou fechando o terminal"
echo "Em seguida, você deve instalar o driver de Proprietary Nvidia correto"
sleep 20
echo "Atualizando o repositório [aguarde um instante]"
sleep 2
sudo apt-get update update
sleep 2
echo "No final desta instalar o Xorg vai reclamar que você"
echo "não tem um arquivo xorg"
echo "Por favor, ignore o aviso como nvidia-xorg está sendo instalado"
sleep 5
sudo aptitude -r install linux-headers-$(uname -r|sed 's,[^-]*-[^-]*-,,') nvidia-legacy-304xx-kernel-dkms
sleep 2
sudo aptitude install nvidia-xconfig
sleep 2
sudo nvidia-xconfig
sleep 2
echo "É necessário reiniciar a fim de aplicar as alterações"
echo "Após a reinicialização você vai encontrar o aplicativo Configurações Nvidia"
echo "em Sistema no menu principal"
sleep 7
sudo reboot
