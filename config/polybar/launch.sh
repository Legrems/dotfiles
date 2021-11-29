#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

sleep 2

# Launch bar1 and bar2
polybar primary &
if [ `$HOME/.config/count_monitors.sh` -eq 2 ]; then

	polybar additional &
fi


echo "Bars launched..."
