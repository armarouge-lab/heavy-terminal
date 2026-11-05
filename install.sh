#!/bin/sh
# ==========================================
# TeufortBSD - Heavy Terminal Installer
# ==========================================
# Este script instala e configura o Heavy.
# Deve ser executado como root (ou com sudo).

set -e

echo "Iniciando a instalação do Heavy (TeufortBSD)..."

# 1. Instalar dependências (Detecta se é Debian/Ubuntu ou FreeBSD)
if command -v apt >/dev/null 2>&1; then
    echo "Detectado Debian/Ubuntu. Instalando dependências..."
    apt update
    apt install -y urxvt tmux zsh fonts-hack-ttf
elif command -v pkg >/dev/null 2>&1; then
    echo "Detectado FreeBSD. Instalando dependências..."
    pkg update
    pkg install -y rxvt-unicode tmux zsh
else
    echo "Erro: Gerenciador de pacotes não suportado."
    exit 1
fi

# 2. Copiar os dotfiles para o HOME do usuário
# O script assume que está sendo rodado na pasta raiz do repositório
echo "Copiando configurações..."
cp dotfiles/.Xresources ~/.Xresources
cp dotfiles/.tmux.conf ~/.tmux.conf

# 3. Instalar o script "heavy" no sistema
echo "Instalando o comando 'heavy'..."
cp heavy /usr/local/bin/heavy
chmod +x /usr/local/bin/heavy

# 4. Aplicar as configurações do X11
if command -v xrdb >/dev/null 2>&1; then
    xrdb -merge ~/.Xresources
fi

echo "Instalação concluída!"
echo "Digite 'heavy' para iniciar o seu terminal."
