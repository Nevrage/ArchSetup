# ArchSetup

* scope are just sed script that preppare the list of packages before prompting the user in vim, this is skipped if a list of packages has been downloaded by the instance script 
* user is only prompted for variable if they are not already defined
* stop removing the lisyt of packages after installation 
* chpasswd requires a colon not a pipe 
* ln needs to be handled by the user, not root

# To Do:
* make sure pacman update stuff 
* look into the option in fdisk to automatically remove signature 
* install wallpapper from the dotfiles as well
* double multilib?
* enable sftp for the users
* update default list packages and find better way to handle failures 
* colors still wonky for pacman 
* repalce yaourt by yay trizen or the aurman
* how to know how long each package took to install?
* the innefective wiping of the drive 
* better way to create the partition 
* link neovim as vim
* source the tmux config
* R install and libraries
* python module installation 
* depersonalize and ask for password or at least do the switch with the variable
* update list of sensors: once (here) or always (Dotfiles)bbbbb)
* make it better looking clear screen at the end of steps, show some progress 
* Hook by setting up variable or running certain commands only if variable is not set such as reboot 


# Why

# What

# Installation process

## Less immediate:
* comeup with a tag, scope and assumption system
* timezone selector as extended question 
* comment a bunch of uncertain packages and see which ones are still installed
* services
* lateste youtube-dl
* repo and github
* bash2rc for Desk scope
* ask for passwords or have the instance script call the distro install one (password for email and transmission, sftp etc)

## longer term
* no auto login if barebobe - can be an extended question
* detect if running from iso and just deploy the specific software and dotfiles
* find a way to hide more questions: (should we exit chroot or reboot or not etc)
* rename project to encompass more than a single distribution
* arduino packages
* make the choosing of the drive and the time zone more interactive
* Pass argument to avoid questions
* reboot if not argument otherwise plug in the instance's script here (instance runs install which checks how it was initalized through a variable)
* pacman -S -noconfirm docker
* systemctl enable docker.service and  usermod -G docker $user
* Portainer and other ask about other various docker images
*  jupyter labextension install @jupyterlab/google-drive

