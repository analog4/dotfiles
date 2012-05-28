# Set Compositing
compton -cCG -o 0.75 -f 0.05 -t 0.01 -l 0.01 -r 2.5 &
# xcompmgr -C -l -O -D1 &

#Dual Monitors
[[ -n "$(xrandr --query | grep "VGA1 connected")" ]] && xrandr --output LVDS1 --auto --output VGA1 --auto --right-of LVDS1

# Start Wicd
#wicd-client -t &
wicd-client -o &

# Start MPD
sleep 10 && mpd &

# Udisk
#udiskie &
#devmon &
#udevil &

# Start Wallpaper with feh
#feh --bg-scale "${HOME}/Pictures/wallpaper-1920134.jpg"
#eval $(cat ~/.fehbg) 
#awsetbg  "/home/dakota/Pictures/wallpaper-1736824.jpg" &

#if [[ $1 == "dwm" ]]
#then
# exec dwm
#elif [[ $1 == "spectrwm" ]]
#then
# exec spectrwm
#else
# exec awesome
#fi

DEFAULT_SESSION=awesome
case $1 in
dwm|awesome|spectrwm|gnome-session) exec ck-launch-session $1 ;;
*) exec $DEFAULT_SESSION ;;
esac

#exec ck-launch-session gnome-session
