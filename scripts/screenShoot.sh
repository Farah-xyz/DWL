#!/bin/bash
screenshot_all_displays="ALL DISPLAYS"
screenshot_area_of_display="AREA OF DISPLAY "
screenshot_area_and_edit="AREA AND EDIT"
# Store each option in a single string seperated by newlines.
options=$(printf "$screenshot_all_displays\n$screenshot_area_of_display\n$screenshot_area_and_edit\n")
# Prompt the user with wmenu
choice="$(echo -e "$options" | wmenu -il 3 -f "JetBrains Mono Nerd Font 12" -p "SCREENSHOOT: " -N 1d2021 -n ebdbb2 -M 689d6a -m 1d2021 -S 689d6a -s 1d2021)"

case $choice in
    $screenshot_all_displays)
        grim $(xdg-user-dir PICTURES)/screenshots/$(date +'%F_%H:%M:%S_GRIM.png') && notify-send "SCREENSHOOT ALL DISPLAY TOOKEN"
        ;;
    $screenshot_area_of_display)
        grim -g "$(slurp)" $(xdg-user-dir PICTURES)/screenshots/$(date +'%F_%H:%M:%S_GRIM_AREA.png') && notify-send "SCREENSHOOT AREA TOOKEN"
        ;;
    $screenshot_area_and_edit)
        grim -g "$(slurp)" - | swappy -f - && notify-send "NOTION AREA TOKEN"
        ;;
	*) exit 1 ;;
esac
