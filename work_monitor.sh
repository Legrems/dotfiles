xrandr --output DP-1-0 --pos 0x0
xrandr --output DP-1-3 --pos 2560x0
xrandr --output eDP-1 --off

i3-msg workspace 1
i3-msg move workspace to output DP-1-3

i3-msg workspace 2
i3-msg move workspace to output DP-1-3

i3-msg workspace 3
i3-msg move workspace to output DP-1-0

i3-msg workspace 4
i3-msg move workspace to output DP-1-0

i3-msg workspace 3
i3-msg workspace 1
