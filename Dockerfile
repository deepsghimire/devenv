from archlinux:latest
COPY mirrorlist /etc/pacman.d/mirrorlist
RUN pacman -Syu --noconfirm git zsh tmux neovim make
