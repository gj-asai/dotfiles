#!/bin/sh

command_exists() {
    command -v $1 > /dev/null 2>&1
}

# install paru if not exists
if ! command_exists paru; then
    sudo pacman --noconfirm -S base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg --noconfirm -si
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

# sddm theme
paru --noconfirm -S sddm-theme-corners-git
sudo mkdir /etc/sddm.conf.d/
sudo cp $HOME/.config/sddm/sddm.conf /etc/sddm.conf.d/
sudo cp $HOME/.config/wallpapers/wall_secondary.png /usr/share/sddm/themes/corners/backgrouds/
sudo cp $HOME/.config/sddm/themes/corners/theme.conf /usr/share/sddm/themes/corners/theme.conf
