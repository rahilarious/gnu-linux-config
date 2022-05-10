#!/bin/bash
# [ -f ~/.bash_aliases ] && . ~/.bash_aliases


# misc 
alias \
bashaliases='emacsclient -t ~/.bash_aliases && . ~/.bashrc' \
..='cd ..' \
...='cd ../..' \
....='cd ../../..' \
oldpwd='cd "${OLDPWD}"' \
grep='command grep --color=auto' \
egrep='command egrep --color=auto' \
lsmount='mount | column -t' \
ssh-add='eval $(ssh-agent) && ssh-add' \
ls='ls --color=auto' \
l='command exa -lbg --color=always' \
la='command exa -labg --git --group-directories-first --color=always' \
lad='command exa -labgD --git --color=always' \
ip='ip -c' \
rm='rm -I' \
diff='diff --color=always -U 1' \
tree='tree -a' \
c='clear' \
ex='exit' \
e='emacsclient -t' \
lspci='lspci -nn' \
iotop='sudo iotop -o' \
reload='. ~/.bashrc' \
termapp='sudo pkill -15 -i $1' \
colemak='sudo localectl set-x11-keymap "us" pc105 "colemak" "ctrl:swapcaps,rupeesign:4"' \
chckinternet='ping -c 5 goo.gl' \
gen2off='sudo systemctl poweroff' \
gen2sleep='sudo systemctl suspend' \
gen2hibernate='systemctl hibernate' \
finddir='read -p "Search Dir: " searchdir && read -p "Dir to search: " fname && find "${searchdir}" -type d -iname "${fname}" -print 2>/dev/null' \
findfile='read -p "Search Dir: " searchdir && read -p "File to search: " fname && find "${searchdir}" -type f -iname "${fname}" -print 2>/dev/null' \
myip='curl https://ifconfig.me/ip && echo' \
searchkmod='read -p "Enter search term: "; lspci -k | grep -i "${REPLY}" && echo && echo && echo; lsmod | grep -i "${REPLY}"' \
htop='command htop -d 10' \
htop5='command htop -d 5' \
      infoarch='gcc -march=native -Q --help=target | grep -i march && /lib64/ld-linux-x86-64.so.2 --help | grep -i x86-64-v' \
infointelmicrocode='iucode_tool -Sl /lib/firmware/intel-ucode/* | less' \
nvprime='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia ' \
snapsearch='read -p "Search: " && curl -H "Snap-Device-Series: 16" http://api.snapcraft.io/v2/snaps/info/"${REPLY}" | grep -i url' \
mem5='ps auxf | sort -nr -k 4 | head -5' \
mem10='ps auxf | sort -nr -k 4 | head -10' \
cpu5='ps auxf | sort -nr -k 3 | head -5' \
cpu10='ps auxf | sort -nr -k 3 | head -10' \
dir5='du -csh * | sort -hr | head -n 5' \
dir10='du -csh * | sort -hr | head -n 10' \
gitaa='git add .' \
gits='git status' \
gitd='git difftool --no-symlinks --dir-diff' \
gitc='read -p "Enter commit message: " && git commit -m "${REPLY}"' \
gitca='read -p "Enter commit message: " && git commit -am "${REPLY}"' \

#system management
alias \
    sc='sudo systemctl' \
    scu='systemctl --user' \
wifidc='iwctl station wlan0 disconnect' \
wifils='iwctl station wlan0 scan && sleep 2 && iwctl station wlan0 get-networks' \
wifinc='iwctl station wlan0 scan && sleep 2 && iwctl station wlan0 get-networks && read -p "Enter wifi SSID: " mssid && read -p "Enter wifi password: " mpasswd && sudo iwctl --passphrase "${mpasswd}" station wlan0 connect "${mssid}" && iwctl station wlan0 show' \
wific='iwctl station wlan0 scan && sleep 2 && iwctl station wlan0 get-networks && read -p "Enter wifi SSID: " mssid && sudo iwctl station wlan0 connect "${mssid}" && iwctl station wlan0 show' \
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
ggitd='git --git-dir=/gentoo-config --work-tree=/ difftool --no-symlinks --dir-diff' \
ggitca='read -p "Enter commit message: " && git --git-dir=/gentoo-config --work-tree=/ commit -am "${REPLY}"' \
gen2crossdevi686='crossdev --overlays "gentoo" --stable --ov-output /var/db/repos/crossdev --portage "--quiet-build -v" --target i686-pc-linux-gnu' \
gen2update='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf && sudo emerge -avuND --keep-going --quiet-build @world' \
gen2fetch='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf && sudo emerge -favuND @world' \
gen2world='sudoedit /var/lib/portage/world' \
gen2log='tail -f /var/tmp/portage/*/*/temp/build.log' \
gen2use='sudoedit /etc/portage/package.use/allinone' \
gen2license='sudoedit /etc/portage/package.license/allinone' \
gen2keyword='sudoedit /etc/portage/package.accept_keywords/allinone' \
gen2env='sudoedit /etc/portage/package.env/allinone' \
gen2makeconf='sudoedit /etc/portage/make.conf' \
gen2mask='sudoedit /etc/portage/package.mask/allinone' \
gen2reposconf='sudoedit /etc/portage/repos.conf/gentoo.conf' \
gen2inforepos='portageq repos_config /' \
gen2install='sudo emerge -va --quiet-build --keep-going' \
gen2search='sudo emerge -s' \
gen2rm='sudo emerge -ca' \
gen2rmforce='sudo emerge -Ca' \
gen2elog='cd /var/log/portage/elog/ && ll' \
gen2ecleanp='sudo eclean-dist -p -t2w' \
gen2eclean='sudo eclean-dist -t2w' \
gen2ecleank='sudo eclean-kernel -Aa' \
gen2lvmsnapshot='read -p "comment for snapshot (underscores only)?" comment && read -p "what size of snapshot (gb digit only)?" gb && sudo lvcreate -v -s -L ${gb}G -n "ss_gentoo_$(date +%d_%m_%Y)_${comment}" gnulinux/gentooroot' \
gen2k='cd /usr/src/linux && make nconfig' \
gen2kc='eselect kernel list && sleep 2 && make -s $(portageq envvar MAKEOPTS)' \
gen2kmi='make -s modules_install' \
gen2ki='make install' \
gen2nvidia='emerge -v --quiet-build x11-drivers/nvidia-drivers' \
gen2ka='time { gen2kc && gen2kmi && gen2ki && gen2nvidia; }' \
gen2diff='eix-update && eix-diff' \
gen2sync='sudo systemctl start portage-sync.service' \
gen2mirrors='mirrorselect -H -6 -D -s 4 -o' \
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


# Open Config and RC files
alias \
cfgi3='emacsclient -c ~/.config/i3/config' \
cfgdwm='sudoedit /etc/portage/savedconfig/x11-wm/dwm-6.3 && sudo emerge -v --quiet-build x11-wm/dwm' \
cfgkitty='emacsclient -c ~/.config/kitty/kitty.conf' \
cfgalacritty='emacsclient -c ~/.config/alacritty/alacritty.yml' \
cfgxinit='emacsclient -c ~/.xinitrc' \
cfgpolybar='emacsclient -c ~/.config/polybar/config' \
cfglxqtob='emacsclient -c ~/.config/openbox/lxqt-rc.xml' \
cfgawesome='emacsclient -c ~/.config/awesome/rc.lua' \

# Program specifics
alias \
nwallpaper='nitrogen --set-zoom-fill --random /common/wallpapers/' \
dwallpaper='nitrogen --set-zoom-fill /common/wallpapers/gentoo/btw-i-use-gentoo-1.png' \
kssh='kitty +kitten ssh' \
icat='kitty +kitten icat' \
kdiff='kitty +kitten diff' \
dccstatus='distcc-config --get-hosts && grep -i -e "makeopts" /etc/portage/make.conf' \
dcclenovo="sudo distcc-config --set-hosts 'localhost/6 lenovo.local/2,lzo' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j8 -l7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dcchp="sudo distcc-config --set-hosts 'localhost/6 hp.local/3,lzo' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j9 -l7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccboth="sudo distcc-config --set-hosts 'localhost/6 hp.local/3,lzo lenovo.local/2,lzo' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j11 -l7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccoff="sudo distcc-config --set-hosts 'localhost' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j6 -l7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dcczeroconf="sudo distcc-config --set-hosts 'localhost/6 +zeroconf' && distcc-config --get-hosts && sudo sed -i -E {s:'MAKEOPTS=\".+\"':'MAKEOPTS=\"-j10 -l7\"':g} /etc/portage/make.conf && grep -i -e 'makeopts' /etc/portage/make.conf" \
dccmon='DISTCC_DIR="/var/tmp/portage/.distcc" distccmon-gnome' \
dccfix='[ -f /var/tmp/portage/.distcc/lock/cpu_localhost_0 ] && sudo ls -lah --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo chown portage:portage /var/tmp/portage/.distcc/lock/cpu_localhost_0 && sudo ls -lah --color=auto /var/tmp/portage/.distcc/lock/cpu_localhost_0' \

#LAN aliases
alias \
logindell='ssh root@dell.local' \
loginlenovo='ssh root@lenovo.local' \
loginhp='ssh root@hp.local' \




#temp
alias \
psdfix='rm ~/.mozilla/firefox/k2siix9a.NiceBoi ~/.mozilla/firefox/yl39bnc3.Cooku ~/.config/google-chrome && mv ~/.config/google-chrome-backup ~/.config/google-chrome && mv ~/.mozilla/firefox/k2siix9a.NiceBoi-backup/ ~/.mozilla/firefox/k2siix9a.NiceBoi && mv ~/.mozilla/firefox/yl39bnc3.Cooku-backup/ ~/.mozilla/firefox/yl39bnc3.Cooku && systemctl --user restart psd && psd p' \
