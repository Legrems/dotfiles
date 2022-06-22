xrandr --output eDP-1 --scale 1x1
xrandr --auto

sleep 5

xrandr --output DP-1-0.2 --pos 0x0
xrandr --output DP-1-0.3 --pos 2560x0
xrandr --output eDP-1 --off

xrandr --output DP-1-0.3 --primary

i3-msg workspace 1
i3-msg move workspace to output DP-1-0.3

i3-msg workspace 2
i3-msg move workspace to output DP-1-0.3

i3-msg workspace 3
i3-msg move workspace to output DP-1-0.2

i3-msg workspace 4
i3-msg move workspace to output DP-1-0.2

i3-msg workspace 3
i3-msg workspace 1
