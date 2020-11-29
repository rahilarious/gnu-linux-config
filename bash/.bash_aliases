
# [ -f ~/.bash_aliases ] && . ~/.bash_aliases


#########	misc	##########
#if [[ -t 0 && $(tty) == "/dev/tty1" && ! $DISPLAY ]] ; then
#        startx
# fi



############ 	aliases 	###########

alias bashaliases='vim ~/.bash_aliases && . ~/.bashrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias oldpwd='cd "${OLDPWD}"'
alias grep='command grep --color=auto'
alias egrep='command egrep --color=auto'
alias lsmount='mount | column -t'
alias ssh-add='eval $(ssh-agent) && ssh-add'
alias l='command ls -AF --color=auto --group-directories-first'
alias ll='command ls -lAhF --color=auto --group-directories-first'
alias ip='ip -c'
alias diff='diff --color=always -U 1'
alias c='clear'
alias e='exit'
alias lspci='lspci -nn'
alias iotop='sudo iotop -o'
alias reload='. ~/.bashrc'
alias termapp='sudo pkill -15 -i $1'
alias chckinternet='ping -c 5 goo.gl'
alias strtapache='sudo rc-service apache2 start'
alias poweroff='sudo poweroff'
alias finddir='read -p "Search Dir: " searchdir && read -p "Dir to search: " fname && find "${searchdir}" -type d -iname "${fname}" -print 2>/dev/null'
alias findfile='read -p "Search Dir: " searchdir && read -p "File to search: " fname && find "${searchdir}" -type f -iname "${fname}" -print 2>/dev/null'
# get current ip
alias myip='curl https://ifconfig.me/ip && echo'
alias grubupdate='sudo grub-mkconfig -o /boot/efi/grub/grub.cfg'
alias searchkmod='read -p "Enter search term: "; lspci -k | grep -i "${REPLY}" && echo && echo && echo; lsmod | grep -i "${REPLY}"'

# gcc system info
alias infogcc='gcc -march=native -Q --help=target'
alias nvprime='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia '

#mount specific devices
alias mntrouterusb='read -p "What is the name of USB? " usbname && sudo mount -t cifs -o guest,uid=1000 //192.168.1.1/"${usbname}" /mnt/router'

#set delay in 10th of second for htop
alias htop='command htop -d 10'
alias htop5='command htop -d 5'

# Download .snap of packages
alias snapsrch='read -p "Search: " && curl -H "Snap-Device-Series: 16" http://api.snapcraft.io/v2/snaps/info/"${REPLY}" | grep -i url'

## get top process eating memory
alias mem5='ps auxf | sort -nr -k 4 | head -5'
alias mem10='ps auxf | sort -nr -k 4 | head -10'

## get top process eating cpu ##
alias cpu5='ps auxf | sort -nr -k 3 | head -5'
alias cpu10='ps auxf | sort -nr -k 3 | head -10'

## List largest directories (aka "ducks")
alias dir5='du -cksh * | sort -hr | head -n 5'
alias dir10='du -cksh * | sort -hr | head -n 10'

#system management
alias wifidc='iwctl station wlan0 disconnect'
alias wifils='iwctl station wlan0 scan && sleep 3 && iwctl station wlan0 get-networks'
alias wifinc='iwctl station wlan0 scan && read -p "Enter wifi SSID: " mssid && read -p "Enter wifi password: " mpasswd && sudo iwctl --password "${mpasswd}" station wlan0 connect "${mssid}" && iwctl station wlan0 show'
alias wific='iwctl station wlan0 scan && read -p "Enter wifi SSID: " mssid && sudo iwctl station wlan0 connect "${mssid}" && iwctl station wlan0 show'
alias wifistatus='iwctl station wlan0 show'
alias displayoff='xset dpms force off'

#Arch specifics
alias archinstll='sudo pacman -S --needed'
alias archrm='sudo pacman -Rs'
alias archupdt='sudo pacman -Syu'
alias archsrch='pacman -Ss'
alias rflctr='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# Privates
alias startopenvpn='sudo openvpn --config /common/userconfig/openvpn/anony.ovpn'

# Gentoo Specifics
alias gentooworldpretend='emerge -puNDv @world'
alias gentooworldfile='sudo vim /var/lib/portage/world'
alias gentoouse='sudo vim /etc/portage/package.use/allinone'
alias gentoolicense='sudo vim /etc/portage/package.license/allinone'
alias gentookeyword='sudo vim /etc/portage/package.accept_keywords/allinone'
alias gentooenv='sudo vim /etc/portage/package.env/allinone'
alias gentoomakeconf='sudo vim /etc/portage/make.conf'
alias gentoomask='sudo vim /etc/portage/package.mask/allinone'
alias gentooreposconf='sudo vim /etc/portage/repos.conf/gentoo.conf'
alias gentooreposinfo='portageq repos_config /'
alias gentooinstll='sudo emerge -a'
alias gentoorm='sudo emerge -cav'
alias gentoormforce='sudo emerge -Cav'
alias gentooelog='vim /var/log/portage/elog/summary.log'
alias gentooecleanp='sudo eclean-dist -dp'
alias gentooeclean='sudo eclean-dist -d'
alias gentoolvmsnapshot='sudo lvcreate -v -s -L 10G -n "ss_gentoo_$(date +%d_%m_%Y)" vg_linux/lv_gentoo'
# kernel compile
alias gentookc='grep MAKEOPTS /etc/portage/make.conf && read -p "how many jobs? " jobs && time make -j"${jobs}" -l7'
# kernel install
alias gentooki='command ls -lahF --color=auto /lib/modules && read -p "Enter the kernel version: " kernelversion && make modules_install && emerge -q x11-drivers/nvidia-drivers && make install && sleep 3 && dracut -f /boot/initramfs-"${kernelversion}".img "${kernelversion}"'
alias eq='equery -h'
alias eqb='equery belongs'
alias eqd='equery depends'
alias eqg='equery depgraph'
alias eqf='equery files'
alias eqh='equery hasuse'
alias eqy='equery keywords'
alias equ='equery uses'
alias eqm='equery meta'
alias eqw='equery which'
alias eql='equery list'
alias eqs='equery size'

# Open Config and RC files
alias cfgi3='vim ~/.config/i3/config'
alias cfgkitty='vim ~/.config/kitty/kitty.conf'
alias cfgxinit='vim ~/.xinitrc'
alias cfgdmenu='sudo vim /etc/portage/savedconfig/x11-misc/dmenu*'
alias cfgpolybar='vim ~/.config/polybar/config'

# Program specifics
alias nwallpaper='nitrogen --set-zoom-fill --random /common/wallpapers/'
alias dwallpaper='nitrogen --set-zoom-fill /common/wallpapers/gentoo/btw-i-use-gentoo-1.png'
alias kssh='kitty +kitten ssh'
alias icat='kitty +kitten icat' #image cat
alias dccstatus='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf'
alias dcclenovo="sudo distcc-config --set-hosts 'localhost/6 192.168.1.96/3' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j9 -l8\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf"
alias dcchp="sudo distcc-config --set-hosts 'localhost/6 192.168.1.143/4' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j10 -l8\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf"
alias dccboth="sudo distcc-config --set-hosts 'localhost/6 192.168.1.96/3 192.168.1.143/4' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j13 -l8\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf"
alias dccoff="sudo distcc-config --set-hosts 'localhost' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf"
alias dccmon='DISTCC_DIR="/var/tmp/portage/.distcc" distccmon-gnome'
alias dccfix='[ -f /var/tmp/portage/.distcc/lock/cpu_localhost_0 ] && sudo ls -lahF --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo chown portage:portage /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo ls -lahF --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0'

#LAN aliases
alias logindell='ssh gentoo@dell'
alias loginlenovo='ssh gentoo@lenovo'
alias loginhp='ssh gentoo@hp'
