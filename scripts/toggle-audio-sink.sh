#!/usr/bin/env bash

NOTIFICATIONS="yes"
ACTIVE_SINK=

declare -A sinks=(
    ["Headphones"]="alsa_output.usb-Macronix_Razer_Barracuda_X_2.4_1234-00.analog-stereo" 
    ["Speakers"]="alsa_output.pci-0000_0d_00.4.analog-stereo"
)

if [ "$(pactl get-default-sink)" = "${sinks[Speakers]}" ]; then
    ACTIVE_SINK="Headphones"
else
    ACTIVE_SINK="Speakers"
fi

pactl set-default-sink "${sinks[$ACTIVE_SINK]}"

echo "$ACTIVE_SINK"

if [ $NOTIFICATIONS = "yes" ]; then
    if command -v dunstify &>/dev/null; then
        notify="dunstify --replace 201839192"
    else
        notify="notify-send"
    fi

    $notify "PulseAudio" "Changed to $ACTIVE_SINK" --icon=audio-headphones-symbolic &
fi
