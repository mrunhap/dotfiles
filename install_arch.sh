#!/bin/bash

# Packages
packages=(
    # git
    # zsh
    emacs-pgtk-native-comp-git
    neofetch                    # screenfetch
    bat
    fd
    fzf
    ripgrep
    # shadowsocks-qt5

    # npm
    # python-pip
    # rubygems
    # rubyrdoc

    # Fonts
    adobe-source-code-pro-fonts
    powerline-fonts
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
)

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

function check() {
    if ! command -v yay >/dev/null 2>&1 && ! command -v pacman >/dev/null 2>&1; then
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi
}

function install() {
    CMD=''
    if command -v yay >/dev/null 2>&1; then
        CMD='yay -Ssu --noconfirm'
    elif command -v pacman >/dev/null 2>&1; then
        CMD='sudo pacman -Ssu --noconfirm'
    else
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi

    for p in ${packages[@]}; do
        printf "\n${BLUE}➜ Installing ${p}...${NORMAL}\n"
        ${CMD} ${p}
    done
}

function main() {
    check
    install
}

main
