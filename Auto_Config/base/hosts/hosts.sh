#!/usr/bin/bash
#
########################
#
# DATA_CRICAO: 	30/07/19
# ULT_MODIFIC: 	30/07/19
#
########################
#
## iniciando arquivo
cat base > hosts

## gerando arquivo hosts
wget -O - http://www.mvps.org/winhelp2002/hosts.txt >> hosts

## adicionado spotify
cat spotify >> hosts