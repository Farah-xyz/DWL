#!/bin/bash
recorder_all="ALL DISPLAY"
recorder_area="AREA OF DISPLAY"

# Store each option in a single string seperated by newlines.
options=$(printf "$recorder_all\n$recorder_area")

# Prompt the user with fuzzel
choice="$(echo -e "$options" | wmenu -il 2 -f "JetBrains Mono Nerd Font 12" -p "RECORDE: " -N 1d2021 -n ebdbb2 -M 689d6a -m 1d2021 -S 689d6a -s 1d2021)"

case $choice in
    $recorder_all)
        wf-recorder --audio --file=$(xdg-user-dir VIDEOS)/$(date +'%F_%H:%M:%S_REC.mp4') && notify-send "DONE RECEORDER ALL DISPLAY"
        ;;
    $recorder_area)
        wf-recorder -g "$(slurp)" --audio --file=$(xdg-user-dir VIDEOS)/$(date +'%F_%H:%M:%S_REC_AREA.mp4') && notify-send "DONE RECEORDER AREA OF DISPLAY"
        ;;
esac
