# ArchSetup

# To Do:
* last list of packages
* get more packages from the main script
* rename the list of packages and incorporate in the script
* ask for edit and then read it: how to read locally
* install the dotfiles from their repo
* remove dotfiles at the end 
* R and python packages
* apply the numix and the cursor

# Less immediate:
* comment a bunch of uncertain packages and see which ones are still installed
* services
* lateste youtube-dl
* repo and github
* bash2rc for Desk scope
* ask for passwords or have the instance script call the distro install one (password for email and transmission, sftp etc)

# longer term
* find a way to sort and tag the packages
* find a way to hide more questions: (should we exit chroot or reboot or not etc)
* rename project to encompass more than a single distrubution
* arduino packages
* define scope of installation
* make the choosing of the drive and the time zone more interactive
* Pass argument to avoid questions
* best solution to enable/disable services ?
* reboot if not argument otherwise plug in the instance's script here
* download repos 
* would you like to run the script as is or have a chance to edit it firts ?
*  scope, make add onto a list including empty lines and comment. Then asking if need editing. Grep the final result and then pacman and yaourt 
* pacman -S -noconfirm docker
* systemctl enable docker.service and  usermod -G docker $user
* Portainer and other ask about other various docker images
*  jupyter labextension install @jupyterlab/google-drive



---
notes:  
```pacman -S $(cat remaining_packages | grep -v "^-" | grep -v "^#" |  sed 's/$/ /' | tr -d "\n") ```

```yaourt -S $(cat remaining_packages | grep  "^-" | grep -v "^#" |  sed 's/$/ /' | sed '/./s/^-//g' | tr -d "\n") ```
