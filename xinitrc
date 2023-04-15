#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# twm &

# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
xrandr --output eDP1 --mode 2560x1440 --scale 1x1 --primary

# Swap caps + escape
setxkbmap -option caps:swapescape

# Set background
#feh --bg-fill ~/Downloads/atlantis-nexus-nebula-black-background-digital-render-3840x2400-3704.jpg
#feh --bg-fill ~/Downloads/digital-abstract-3d-render-pattern-minimal-art-black-3840x2160-7124.jpg
feh --bg-fill ~/Downloads/wp2618248-blackarch-wallpaper.png

xfsettingsd --sm-client-disable &

# Launch i3
exec i3
/usr/bin/prime-offload
