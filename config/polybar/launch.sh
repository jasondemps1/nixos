#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

declare -A arrangements=(["DP-4"]="example" ["HDMI-0"]="left" ["USB-C-0"]="bottom")

for MONITOR in "${!arrangements[@]}"; do
  # split at ',' into array
  while IFS=',' read -ra BARLIST; do
    # for each bar (separated by ',') at current key
    for BAR in "${BARLIST[@]}"; do
      MONITOR="$MONITOR" polybar --reload "$BAR" &
    done
  done <<< "${arrangements[$MONITOR]}"
done


#if type "xrandr" > /dev/null; then
#  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#    MONITOR=$m polybar --reload example 2>&1 &
#  done
#else
#  polybar --reload example 2>&1 &
#fi

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1.log # /tmp/polybar2.log
#polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
#polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
