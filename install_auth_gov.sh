#!/bin/bash

# Instala a aplicação Autenticação.gov
# https://www.autenticacao.gov.pt/cc-aplicacao

if ! command -v flatpak &> /dev/null; then
    echo "Error: flatpak is not installed"
    echo "Please install flatpak first: https://flatpak.org/setup/"
    exit 1
fi

if [ ! -f pteid-mw-linux.x86_64.flatpak ]; then
    wget -O pteid-mw-linux.x86_64.flatpak https://aplicacoes.autenticacao.gov.pt/apps/pteid-mw-linux.x86_64.flatpak
    flatpak install --assumeyes flathub org.kde.Platform/x86_64/5.15-23.08
    flatpak install --user --assumeyes pteid-mw-linux.x86_64.flatpak
    rm pteid-mw-linux.x86_64.flatpak
else
    echo "pteid-mw-linux.x86_64.flatpak ja existe"
fi
