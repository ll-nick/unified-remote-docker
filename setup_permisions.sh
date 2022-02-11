#!/bin/bash

if [ ! -f /etc/udev/rules.d/99-uinput.rules ]; then
    echo "No uinput rules found. Setting them up now."
    echo "To undo: sudo rm /etc/udev/rules/99-uinput.rules"
    sudo groupadd uinput
    echo 'KERNEL=="uinput", GROUP="uinput", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
    sudo udevadm control --reload
    sudo udevadm trigger
else
    echo "uinput rules set up already already."
fi

