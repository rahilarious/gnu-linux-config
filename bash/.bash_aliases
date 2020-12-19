# [ -f ~/.bash_aliases ] && . ~/.bash_aliases


# misc 
alias \
bashaliases='vim ~/.bash_aliases && . ~/.bashrc' \
..='cd ..' \
...='cd ../..' \
....='cd ../../..' \
oldpwd='cd "${OLDPWD}"' \
grep='command grep --color=auto' \
egrep='command egrep --color=auto' \
lsmount='mount | column -t' \
ssh-add='eval $(ssh-agent) && ssh-add' \
ll='command exa -labg --git --group-directories-first --color=always' \
lld='command exa -labgD --git --color=always' \
ip='ip -c' \
diff='diff --color=always -U 1' \
c='clear' \
e='exit' \
lspci='lspci -nn' \
iotop='sudo iotop -o' \
reload='. ~/.bashrc' \
termapp='sudo pkill -15 -i $1' \
chckinternet='ping -c 5 goo.gl' \
strtapache='sudo rc-service apache2 start' \
poweroff='sudo poweroff' \
finddir='read -p "Search Dir: " searchdir && read -p "Dir to search: " fname && find "${searchdir}" -type d -iname "${fname}" -print 2>/dev/null' \
findfile='read -p "Search Dir: " searchdir && read -p "File to search: " fname && find "${searchdir}" -type f -iname "${fname}" -print 2>/dev/null' \
myip='curl https://ifconfig.me/ip && echo' \
grubupdate='sudo grub-mkconfig -o /boot/efi/grub/grub.cfg' \
searchkmod='read -p "Enter search term: "; lspci -k | grep -i "${REPLY}" && echo && echo && echo; lsmod | grep -i "${REPLY}"' \
htop='command htop -d 10' \
htop5='command htop -d 5' \
infogcc='gcc -march=native -Q --help=target' \
nvprime='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ' \
mntrouterusb='read -p "What is the name of USB? " usbname && sudo mount -t cifs -o guest,uid=1000 //192.168.1.1/"${usbname}" /mnt/router' \
snapsearch='read -p "Search: " && curl -H "Snap-Device-Series: 16" http://api.snapcraft.io/v2/snaps/info/"${REPLY}" | grep -i url' \
mem5='ps auxf | sort -nr -k 4 | head -5' \
mem10='ps auxf | sort -nr -k 4 | head -10' \
cpu5='ps auxf | sort -nr -k 3 | head -5' \
cpu10='ps auxf | sort -nr -k 3 | head -10' \
dir5='du -csh * | sort -hr | head -n 5' \
dir10='du -csh * | sort -hr | head -n 10' \
gitaa='git add .' \
gits='git status' \
gitd='git diff' \
gitc='read -p "Enter commit message: " && git commit -m "${REPLY}"' \

#system management
alias \
wifidc='iwctl station wlan0 disconnect' \
wifils='iwctl station wlan0 scan && sleep 3 && iwctl station wlan0 get-networks' \
wifinc='iwctl station wlan0 scan && read -p "Enter wifi SSID: " mssid && read -p "Enter wifi password: " mpasswd && sudo iwctl --password "${mpasswd}" station wlan0 connect "${mssid}" && iwctl station wlan0 show' \
wific='iwctl station wlan0 scan && read -p "Enter wifi SSID: " mssid && sudo iwctl station wlan0 connect "${mssid}" && iwctl station wlan0 show' \
wifistatus='iwctl station wlan0 show' \
displayoff='xset dpms force off' \

#Arch specifics
alias \
btwinstall='sudo pacman -S --needed' \
btwrm='sudo pacman -Rs' \
btwupdate='sudo pacman -Syu' \
btwsearch='pacman -Ss' \
rflctr='sudo reflector --latest 20 --protocol https --sort rate --save /etc/pacman.d/mirrorlist' \

# Gentoo Specifics
alias \
ggit='git --git-dir=/gentoo-config --work-tree=/' \
ggita='git --git-dir=/gentoo-config --work-tree=/ add' \
ggits='git --git-dir=/gentoo-config --work-tree=/ status' \
ggitd='git --git-dir=/gentoo-config --work-tree=/ diff' \
ggitc='read -p "Enter commit message: " && git --git-dir=/gentoo-config --work-tree=/ commit -m "${REPLY}"' \
gen2crossdevi686='crossdev --b "2.34-r2" --k "5.4-r1" --g "9.3.0-r2" --l "2.32-r2" -oO /var/db/repos/crossdev --target i686-pc-linux-gnu' \
gen2update='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf && sudo emerge -avuND --keep-going --quiet-build @world' \
gen2world='sudo vim /var/lib/portage/world' \
gen2use='sudo vim /etc/portage/package.use/allinone' \
gen2license='sudo vim /etc/portage/package.license/allinone' \
gen2keyword='sudo vim /etc/portage/package.accept_keywords/allinone' \
gen2env='sudo vim /etc/portage/package.env/allinone' \
gen2makeconf='sudo vim /etc/portage/make.conf' \
gen2mask='sudo vim /etc/portage/package.mask/allinone' \
gen2reposconf='sudo vim /etc/portage/repos.conf/gentoo.conf' \
gen2inforepos='portageq repos_config /' \
gen2install='sudo emerge -va --quiet-build --keep-going' \
gen2search='sudo emerge -s' \
gen2rm='sudo emerge -cav' \
gen2rmforce='sudo emerge -Cav' \
gen2elog='cd /var/log/portage/elog/ && ll' \
gen2ecleanp='sudo eclean-dist -p -d -t2w' \
gen2eclean='sudo eclean-dist -d -t2w' \
gen2lvmsnapshot='read -p "comment for snapshot? " && sudo lvcreate -v -s -L 10G -n "ss_gentoo_$(date +%d_%m_%Y)_${REPLY}" gnulinux/gentooroot' \
gen2k='cd /usr/src/linux && make nconfig' \
gen2kc='time make $(portageq envvar MAKEOPTS)' \
gen2ki='command ls -lah --color=auto /lib/modules && read -p "Enter the kernel version: " kernelversion && make modules_install && emerge -q x11-drivers/nvidia-drivers && make install && sleep 3 && dracut -f /boot/initramfs-"${kernelversion}".img "${kernelversion}" && rm -I /boot/*old' \
eq='equery -h' \
eqb='equery belongs' \
eqd='equery depends' \
eqg='equery depgraph' \
eqf='equery files' \
eqh='equery hasuse' \
eqy='equery keywords' \
equ='equery uses' \
eqm='equery meta' \
eqw='equery which' \
eql='equery list' \
eqs='equery size' \
glt='genlop -t' \
gle='genlop -e' \
glc='genlop -c' \
glr='genlop -r | tail -n 20' \
gli='genlop -i' \
gll='genlop -l | tail -n 20' \
glu='genlop -u | tail -n 20' \


# Open Config and RC files
alias \
cfgi3='vim ~/.config/i3/config' \
cfgkitty='vim ~/.config/kitty/kitty.conf' \
cfgxinit='vim ~/.xinitrc' \
cfgpolybar='vim ~/.config/polybar/config' \

# Program specifics
alias \
nwallpaper='nitrogen --set-zoom-fill --random /common/wallpapers/' \
dwallpaper='nitrogen --set-zoom-fill /common/wallpapers/gentoo/btw-i-use-gentoo-1.png' \
kssh='kitty +kitten ssh' \
icat='kitty +kitten icat' \
dccstatus='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf' \
dcclenovo="sudo distcc-config --set-hosts 'localhost/6 192.168.1.96/3' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j9 -l7.5\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dcchp="sudo distcc-config --set-hosts 'localhost/6 192.168.1.143/4' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j10 -l7.5\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccboth="sudo distcc-config --set-hosts 'localhost/6 192.168.1.96/3 192.168.1.143/4' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j13 -l7.5\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccoff="sudo distcc-config --set-hosts 'localhost' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccmon='DISTCC_DIR="/var/tmp/portage/.distcc" distccmon-gnome' \
dccfix='[ -f /var/tmp/portage/.distcc/lock/cpu_localhost_0 ] && sudo ls -lahF --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo chown portage:portage /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo ls -lahF --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0' \

#LAN aliases
alias \
logindell='ssh root@dell' \
loginlenovo='ssh root@lenovo' \
loginhp='ssh root@hp' \

