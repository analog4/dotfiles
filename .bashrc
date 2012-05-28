# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
export EDITOR='vim'

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# ANSI color codes
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="$FGRN┌─$HC$FBLK \h$HC$FYEL $RS $FYEL\w $RS\n$FGRN └─ $RS$FWHT"
    PS2="$FRED> $RS$HC$FMAG"
    ;;
*)
    ;;
esac
### Functions ###
# --// Cleanup \\--

cleanup () {
    echo -e "-->> Cleaning Thumbnails <<--"
#   sudo /bin/rm -rfv ~/.thumbnails/*
    echo "-->> Removing Flash Player cache <<--"
    sudo /bin/rm -rfv ~/.adobe/*
    sudo /bin/rm -rfv ~/.macromedia/*
    echo "-->> Cleaning Cache <<--"
    sudo /bin/rm -rfv ~/.cache/*
    echo "-->> Cleaning Trash <<--"
    sudo /bin/rm -rfv ~/.local/share/Trash/*
#   sudo /bin/rm -rfv /tmp/*
}

## Weather ##
whosup ()
{ 

search=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
sudo nmap -sS $search/24
}

# --// Update Clock \\--

update-clock () {
	sudo ntpdate -s time.ien.it
	sudo hwclock -w
}

#Automaticaly ls after cd
function cd()
{
 builtin cd "$*" && ls
}

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
alias l='ls -CF'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias fullupdate='sudo pacman -Syu && packer -Su'
alias update='sudo pacman -Syu'
alias search='packer -Ss'
alias clean='sudo pacman -Scc && /home/dakota/./deltrash.sh && sudo pacman -Syy'
alias lsorphans='sudo pacman -Qdt'
alias rmorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias lspac='comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)'
alias list='comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)'
alias pachist='/home/dakota/./pachist'
#alias pacsize='pacman -Qi | gawk '/^Name/ { x = $3 }; /^Installed Size/ { sub(/Installed Size  *:/, ""); print x":" $0 }' | sort -k2,3rn | head -n10 | gawk 'BEGIN { print "\n""These are your 10 largest programs:""\n" }; { print }''
#alias lspacsize='awk 'BEGIN{while (("pacman -Qi" |getline) > 0){ if ($0 ~ /Name/) {name=$3};{if ($0 ~ /Size/) {size=$4/1024;printf "%-25s %d Mb\n", name, size|"sort -k2 -n"}}}}''
alias countpac='pacman -Q|wc -l'
alias aurman='sudo pacman -U'
alias aur='packer -S'
alias mkpkg='makepkg -s'
alias k='killall'
alias c='clear'
alias e='espeak'
alias scripts='cd /home/dakota/scripts/'
alias wifire='cd /home/dakota/scripts/pentest/ && sudo ./WiFire.sh'
alias colors='cd /home/dakota/scripts/ ; ./colors.sh'
#alias line='printf "%$(tput cols)s\n"|tr ' ' '=''

# personal aliases
alias ls='ls -hF --color'    # add colors for filetype recognition
alias lx='ls -lXB'        # sort by extension
alias la='ls -Al'        # show hidden files
alias lr='ls -lR'        # recursice ls
alias lt='ls -ltr'        # sort by date
alias lm='ls -al |more'        # pipe through 'more'
alias ll='ls -l'        # long listing
alias lssize='du -h --max-depth=1  | sort -hr | head -13' # list by size
alias lsize='du -h --max-depth=1  | sort -hr | head -13' # list by size
alias lsd='ls -l | grep "^d"'   #list only directories
alias lalf='ls -alF'
alias reboot='sudo shutdown -r now'
alias shutdown='sudo shutdown -h now'
alias web='luakit'
alias matrix='cmatrix -sa -C blue'
alias mat='cmatrix -sa -C green'
alias youtube='youtube-viewer'
alias playcd='mplayer cdda://'
alias webcam='mplayer tv://'
alias webcam1='mplayer tv:// device=/dev/video1'
#alias webcam='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -title Webcam  -fps 25 -vf screenshot '
alias wifi='wicd-curses'
alias volume='alsamixer'
alias screencap='ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq /tmp/out.mpg'
alias remoteshutdown='./scripts/pentest/nmap_scan.sh'
alias whoson='nmap -sP 192.168.1.254/24'

#Command substitution
alias h='history | grep $1'
alias rm='rm -r -v -i'
alias cp='cp -v -i'
alias mv='mv -i'
alias which='type -all'
alias cd..='cd ..'
alias px='chmod +x'
alias x='exit'

# CD
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias home='cd ~'

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# ARCHIVES
# usage: ex <file>
ex ()
{
  if [[ -f "$1" ]]; then
    case "$1" in
      *.lrz)      lrztar -d "$1" && cd $(basename "$1" .lrz)    ;;
      *.tar.bz2)  tar xjf "$1" && cd $(basename "$1" .tar.bz2)  ;;
      *.tar.gz)   tar xzf "$1" && cd $(basename "$1" .tar.gz)   ;;
      *.tar.xz)   tar Jxf "$1" && cd $(basename "$1" .tar.xz)   ;;
      *.bz2)      bunzip2 "$1" && cd $(basename "$1" .bz2)      ;;
      *.rar)      rar x "$1" && cd $(basename "$1" .rar)        ;;
      *.gz)       gunzip "$1" && cd $(basename "$1" .gz)        ;;
      *.xz)       tar xvJf "$1" && cd $(basename "$1" .xz)      ;;
      *.tar)      tar xf "$1" && cd $(basename "$1" .tar)       ;;
      *.tbz2)     tar xjf "$1" && cd $(basename "$1" .tbz2)     ;;
      *.tgz)      tar xzf "$1" && cd $(basename "$1" .tgz)      ;;
      *.zip)      unzip "$1" && cd $(basename "$1" .zip)        ;;
      *.Z)        uncompress "$1" && cd $(basename "$1" .Z)     ;;
      *.7z)       7z x "$1" && cd $(basename "$1" .7z)          ;;
      *.rar)      unrar x "$1" && cd $(basename "$1" .rar)      ;;
      *)          echo "don't know how to extract '$1'..."      ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# CONFIGS
# usage: conf <name>
conf ()
{
  case $1 in
    bash) nano ~/.bashrc ;;
    nano) nano ~/.nanorc ;;
    xinit) nano ~/.xinitrc ;;
    xdef) nano ~/.Xdefaults ;;
    boot) sudo nano /boot/grub/menu.lst ;;
    fstab) sudo nano /etc/fstab ;;
    rc) sudo nano /etc/rc.conf ;;
    pacman) sudo nano /etc/pacman.conf ;;
  esac
}
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

#Coloured Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

##################
# WELCOME SCREEN #
##################

#echo -ne "${LIGHTGREEN}" "Hello, $USER. today is, "; date

