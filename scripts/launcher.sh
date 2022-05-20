#!/usr/bin/env bash

FILE="$HOME/.config/polybar/scripts/rofi/colors.rasi"

## random accent color
#COLORS=('#EC7875' '#EC6798' '#BE78D1' '#75A4CD' '#00C7DF' '#00B19F' '#61C766' \
#		'#B9C244' '#EBD369' '#EDB83F' '#E57C46' '#AC8476' '#6C77BB' '#6D8895')
#AC="${COLORS[$(( $RANDOM % 14 ))]}"
#SE="${COLORS[$(( $RANDOM % 14 ))]}"
#sed -i -e "s/ac: .*/ac:   ${AC}FF;/g" $FILE
#sed -i -e "s/se: .*/se:   ${SE}FF;/g" $FILE

#!/bin/bash

Audio () {
source="$(pactl list short sinks | cut -f 2 | rofi -dpi 1 -dmenu -p "Change audio:")";
inputs="$(pactl list sink-inputs short | cut -f 1)";

for input in $inputs; do
  pactl move-sink-input "$input" "$source";
done

pactl set-default-sink "$source";

# Info about some states are available here:
# https://www.freedesktop.org/software/systemd/man/systemd-sleep.conf.html#Description
}

chosen=$(echo -e "[Cancel]\nMenu\nAudio-Selection\nVs-Code\nSpotify\nAudio-Vis\nFirefox" | rofi -dmenu -i -p run:)
if [[ $chosen = "Menu" ]]; then
	rofi -no-config -no-lazy-grab -show drun -modi drun -theme ~/.config/polybar/scripts/rofi/launcher.rasi
elif [[ $chosen = "Audio-Selection" ]]; then
	Audio
elif [[ $chosen = "Vs-Code" ]]; then
	code
elif [[ $chosen = "Spotify" ]]; then
	spotify
elif [[ $chosen = "Audio-Vis" ]]; then
	xterm vis
elif [[ $chosen = "Firefox" ]]; then
	firefox
fi
