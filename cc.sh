#!/bin/bash

# Instala o plugin Autenticação.Gov (https://autenticacao.gov.pt/fa/ajuda/autenticacaogovpt.aspx#installAgent)



if [ ! -f plugin-autenticacao-gov.deb ]; then
    wget -O plugin-autenticacao-gov.deb https://aplicacoes.autenticacao.gov.pt/plugin/plugin-autenticacao-gov.deb
    sudo apt install -y ./plugin-autenticacao-gov.deb
    rm plugin-autenticacao-gov.deb
else
    echo "plugin-autenticacao-gov.deb ja existe"
fi
