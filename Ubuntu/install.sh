#! /bin/bash

# Install stuff 
sudo apt update 
sudo apt upgrade 
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake git ranger qutebrowser xterm python3pip feh xclip xsel xdotools mpv pandoc tmux neofetch r-base r-base-dev libssl-dev cifs-utils openssh-server  htop  evolution evolution-ews libmariadbclient-dev compton i3lock libssl-dev net-tools curl dunst
sudo pip3 install pywal rice jedi wal-steam  rtichoke  neovim
sudo apt-get install r-cran-curl r-cran-openssl r-cran-xml2

# pull the dotfiles now 
git clone https://github.com/Nevrage/DotFile.git ~

# i3-gaps
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

# remove stuff 
sudo remove --purge nautilus gnome-terminal firefox google-chrome-stable eog

## Pull dotfiles 

# vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ~/Dotfile/tty/vimrc ~/.vimrc 
vim +PluginInstall +qall

cd ~/Downloads 

wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf

cp ~/Downloads/DejaVu Sans Mono Nerd Font Complete.ttf/ /usr/local/share/fonts/TTF/

# R stuff
R --no-save <<EOF
.libPaths("~/R/library")
options("http://cran.us.r-project.org")
install.packages("tidyverse")
install.packages("knitr")
install.packages("rmarkdown")
install.packages("RMySQL")
install.packages("kableExtra")
install.packages("lintr")
install.packages("shiny")
install.packages("devtools")
devtools::install_github("jalvesaq/colorout")
EOF
cp ~/Dotfile/tty/R/Rprofile ~/.Rprofile 
mkdir ~/R/library
echo ".libPaths(\"~/R/library\")" >> ~/.Rprofile 


# Copying dotfiles 
cp ~/DotFile/tty/bashrc ~/.bashrc 
cp ~/DotFile/tty/inputrc ~/.inputrc
cp ~/DotFile/desktopSpace/Xressources ~/.Xresources
cp ~/DotFile/desktopSpace/Xdefaults ~/.Xdefaults
cp -r ~/DotFile/desktopSpace/i3/*  ~/.config/i3/
cp -r ~/DotFile/tty/ranger/* ~/.config/ranger/ 
cp -r ~/DotFile/desktopSpace/qutebrowser/* ~/.config/qutebrowser/
cp ~/DotFile/tty/tmux ~/.tmux.conf


wal -i ~/Dotfile/wallpaper/wallpaper.png
wal --theme hybrid-material


# notes 
# fix qutebrowser (higer version required)
# fix vim (is it really broken?)

# Changes in dotfile 
## Changed i3lock-fancy to i3lock in i3
# add on boot davmail and its tmux script 
# Install the newmail.sh  and various scripts 
# that offlineimaprc and its permissions 
# install notmuch libs and mock and alot program
# the gdrive thingy 
# things about the dbeaver, finch and tasksh
# snap apps: Rocketchat and skype
# add shortcuts for those
# mount shared drive as reg user 


rm -r ~/DotFile
sudo apt update 
sudo apt upgrade 

passwd 

reboot

