#!/bin/bash


# Load standard keymap
xkbcomp -I$HOME/.xkb ~/.xkb/keymap.xkb $DISPLAY


# Load special keymap variation for Filco Majestouch Minila keyboard
minila_device_id=$(xinput list | sed -n 's/.*FILCO FILCO\s*id=\([0-9]*\).*keyboard.*/\1/p')

if [ -n "$minila_device_id" ]; then
    xkbcomp -i $minila_device_id -I$HOME/.xkb ~/.xkb/keymap_minila.xkb $DISPLAY
else
    echo "Warning: Minila keyboard not found."
fi
