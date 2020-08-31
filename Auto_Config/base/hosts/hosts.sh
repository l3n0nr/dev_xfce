#!/usr/bin/env bash
#
########################
#
# DATA_CRICAO: 	30/07/19
# ULT_MODIFIC: 	30/07/19
#
########################
#
## gerando arquivo hosts
wget -O - http://www.mvps.org/winhelp2002/hosts.txt > hosts

## adicionado spotify
cat spotify >> hosts