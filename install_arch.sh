# passwd && yes | pacman -Sy openssh net-tools && systemctl start sshd && ifconfig | grep 192 
    ## connect through ssh and paste this file
# OR 
# Source <(culr url.of/script)
# ====================
 
# change to some dialog stuff especially for drive and scope selection 
# would you like to run the script as is or have a chance to edit it firts ?
# read answer 
# if answer is yes 
# dl the script, edit and run upon quitting
clear
echo "Choose a username:"
read user 
clear
echo "Choose a password:"
read pw
clear
echo "What is the name of this computer?"
read host
clear
lsblk
echo " 
*********************************
The chosen drive will be erased.
*********************************
"
lsblk -l 
read drive
clear
echo "
*********************************
What is the scope of this installation?
*********************************

base: will install barebone arch without extra user 
server: will add more services and a non root user 
workstation: will install all computanional tool, xorg and i3
home: will install everything
also available: docker and vbox

"
read scope
clear

# Is that really useful ?
export user
export pw
export drive
export host
export scope


wipefs -a $drive 
## alternatively could try the following 
## parted rm /dev/sda 1
## wipefs -a -n 5 or nothing 
## dd 
## scrub

timedatectl set-ntp true
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $drive
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +100M # 100 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +12G # SWAP partition
  n # new partition
  p # primary partition
  3 # parition number 3
    # default - start at the beginning of disk
  +25G # root partition
  n # new partition 
  p # primary partition 
  4 # home partition 
    # default start 
    # until the end
  w # write the partition table
  q # Done 
EOF
mkfs.ext4 -F $drive"1"
mkfs.ext4 -F $drive"2"
mkfs.ext4 -F $drive"3"
mkswap -f $drive"2"
swapon $drive"2"
mount $drive"3" /mnt
mkdir /mnt/boot
mkdir /mnt/home
mount $drive"1" /mnt/boot
mount $drive"4" /mnt/home
pacstrap /mnt base base-devel vim ranger 
genfstab -U /mnt >> /mnt/etc/fstab


cat << EOF | arch-chroot /mnt /bin/bash
 

pacman -S --noconfirm networkmanager git curl lm_sensors
systemctl enable NetworkManager
echo "en_US.UTF-8 UTF-8  " >> /etc/locale.gen
echo "en_US ISO-8859-1  " >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
rm /etc/localtime
ln /usr/share/zoneinfo/America/Montreal /etc/localtime
pacman -S --noconfirm grub 
grub-install --target=i386-pc $drive
grub-mkconfig -o /boot/grub/grub.cfg
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash admin
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
echo "root:$pw" ｜chpasswd
pacman -S --noconfirm openssh net-tools curl
echo -e "\nPermitRootLogin yes\n" >> /etc/ssh/sshd_config
systemctl enable sshd
echo -e "[options] \n colors\n ILoveCandy\n HoldPkg     = pacman glibc\n Architecture = auto\n Color\n CheckSpace\n SigLevel    = Required DatabaseOptional\n LocalFileSigLevel = Optional\n \n [core]\n Include = /etc/pacman.d/mirrorlist\n \n [extra]\n Include = /etc/pacman.d/mirrorlist\n \n [community]\n Include = /etc/pacman.d/mirrorlist\n \n [multilib]\n Include = /etc/pacman.d/mirrorlist" > /etc/pacman.conf
pacman -Sy
cd /root

su -c "
cd /tmp
git clone https://aur.archlinux.org/package-query.git
cd package-query
yes | makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
yes | makepkg -si
cd ..
cd /tmp
git clone https://aur.archlinux.org/mingetty.git 
cd mingetty 
yes | makepkg -si " - admin

userdel -r admin

cd
mkdir /etc/systemd/system/getty@tty1.service.d/
useradd -m -g users -G audio,lp,optical,storage,video,wheel,games,power,scanner -s /bin/bash $user 
echo "$user|$pw" | chpasswd
echo -e "[Service]\nExecStart=\nExecStart=-/usr/bin/agetty --autologin $user --noclear %I $TERM" >> /etc/systemd/system/getty@tty1.service.d/override.conf 

############################
# install R 
pacman -Sy -noconfirm python-pip tmux neofetch R  gcc-fortran rofi feh htop pulseaudio alsa-utils transmission-cli mpv mupdf dunst compton  gparted nerd-fonts-complete pandoc texlive-most cava mutt beep scrot ncmpcpp mpd mpc tk gdal zsnes gdal proj geos  lib32-gconf qutebrowser ack libreoffice mariadb
# Potentially add t he following:
# arduino blender calcurse cups dosbox dosfstools dunst fish gimp glxosd google-drive-ocamlfuse htop-vim-git nmap noto-fonts-git npm ntfs-3g oni p7zip pacutils peco python-eyed3 python-igraph quicklisp radeontop rofi-greenclip rsync samba sbcl scrot sshfs tmsu todotxt-git tremc-git uswsusp-git w3m wget wine-staging xbindkeys xclip xdotool xsel ympd-git zsnes
sudo pip3 install jedi rice rtv rice hangups stig  pywal wal-steam bpython ptpython jupyterlab pirate-get pandas numpy matplotlib todotxt-machine rtichoke menu4rofi buku #terminatables and jupyetr stuff 
jupyter labextension install @jupyterlab/google-drive
echo " 
NOCONFIRM=1
BUILD_NOCONFIRM=1
EDITFILES=0" > /home/$user/.yaourtrc
yaourt -S polybar bash-pipes ncmatrix cli-visualizer i3-gaps zathura-pdf-poppler cool-retro-term unified-remote-server jq-git udunits #dofus
sudo pip install youtube_dl==2017.07.30.1
sudo pip3 install greenlet==0.4.10
#github and ranger stuff 
# replace yaourt by su command
# download repos 
# install dotfiles 
############################

scope_notbasic='server workstation home vbox'
if [[ $scope == *"scope_notbasic"* ]]; then
    cd /home/$user 
    git clone https://github.com/Nevrage/Dotfiles.git /home/$user
    mkdir -p /home/$user/.vim/bundle/
    git clone https://github.com/VundleVim/Vundle.vim.git /home/$user/.vim/bundle/Vundle.vim
    cp /home/$user/Dotfiles/tty/vimrc ~/.vimrc
    vim +PluginInstall +qall
fi


scope_server='server workstation home'
if [[ $scope == *"scope_server"* ]]; then
  pacman -S -noconfirm docker
  cp ~/Dotfiles/tty/bashrc ~/.bashrc 
  systemctl enable docker.service
  # portainer
  # .profile here for non graphic
  usermod -G docker $user
fi


scope_graph='workstation home'
if [[ $scope == *"scope_server"* ]]; then
  # different .profile from here 
  pacman -S --noconfirm xorg xorg-xinit xterm
  yaourt -S i3-gaps 
  cp /home/$user/Dotfiles/profile /home/$user/.profile
  chmod 755 /home/$user/.profile
  cp /home/$user/Dotfiles/desktopSpace/xinitrc /home/$user/.xinitrc
  cp /home/$user/Dotfiles/desktopSpace/i3/* /home/$user/i3/
fi


if [ $scope = "home" ]; then
    pacman -S steam
    yaourt -S dropbox steam-fonts multimc5 openspades leagueoflegends glxosd
fi

echo $host > /etc/hostname
pacman -Syu
# rm -r /home/$user/DotFiles
exit
EOF
umount -r /mnt
reboot

