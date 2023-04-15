xrandr --output eDP1 --auto
xrandr --output DP-1-0.2 --off
xrandr --output DP-1-0.3 --off

sleep 2

xrandr --output eDP1 --mode 2560x1440 --scale 1x1 --primary
