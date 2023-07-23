#!/bin/bash

# bootstrap development environment

set -xeuo pipefail
CONFIG_DIR=~/.config/devenv

die () {
    printf "%s\n" "$*" >&2 
    exit 1
}

warn () {
    printf "[WARNING]: %s\n" "$*" >&2 
}


arch_install () {
    [[ "$#" -eq 0 ]] || {
    pacman -Syu --noconfirm "$@"
    }
}

is_installed () {
    command -v "$1" &> /dev/null
}

ensure_installed=(git zsh make)
install_required=()

for prog in "${ensure_installed[@]}";do
    is_installed "$prog" || { install_required+=("$prog") ;}
done


zsh_git_config="https://github.com/deepsghimire/dotzsh.git"

if ! arch_install "${install_required[@]}" ; then
    echo unable to install required packages aborting... >&2
    exit 1
fi

(
mkdir -p "${CONFIG_DIR}";
cd "${CONFIG_DIR}";
if ! git clone "$zsh_git_config" 2> /dev/null; then
    echo git clone dotzsh to "$zsh_git_config" failed
    if [[ -d "${CONFIG_DIR}/dotzsh" ]]; then
        echo directory exists
    fi
fi
cd dotzsh
make
)&

wait
