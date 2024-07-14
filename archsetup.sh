#!/bin/sh

command_exists() {
    command -v $1 > /dev/null 2>&1
}

# install paru if not exists
if ! command_exists paru; then
    sudo pacman --noconfirm -S base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd pau && makepkg --noconfirm -si
fi

# firewall
sudo pacman --noconfirm -S ufw
sudo systemctl enable ufw
sudo ufw enable
# TODO configure ufw

# zsh
sudo pacman --noconfirm -S zsh
chsh -s /usr/bin/zsh ${USER}

# additional packages
sudo pacman --noconfirm -S neovim neofetch bat ripgrep grim zoxide fzf starship ttf-inconsolata-nerd chafa poppler

# dotfiles
sudo pacman --noconfirm -S chezmoi
chezmoi init --apply gj-asai

# timeshift
sudo pacman --noconfirm -S timeshift
# TODO configure timeshift
