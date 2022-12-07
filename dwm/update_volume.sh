function volume_update {
	#use the right because I only set the volume as one. not individually
	#sometimes the mute command went after the get so sleep here
	#sleep 0.2s
	#0-30  , 31-60  , 61 && > 
	#querying the volume with start the pulseaudio!
#old...	volume_level="$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')"
	# Adding this myself too. Fiddled around until I found way to isolate volume percentage
	volume_level="$(amixer sget Master | awk -F'[][]' '{ print $2 }')"
	volume_level="${volume_level%?}"
#old..	mute_state="$(pacmd list-sinks | awk '/muted:/ { print $2 }')"
	# Adding this after finding have 2 audio devices because of nvidia, here getting second one...maybe..
	mute_state="$(pacmd list-sinks | awk '/muted:/ { print $2 }' | awk 'FNR == 2')"
    #echo "$mute_state,len${#mute_state}" | tee ~/.scripts/dwm/savedata/volume_debug.txt
	if [[ "$mute_state" = "no" ]]; then
		if ((volume_level >= 0 && volume_level <= 30)); then
			volume_string="$volume_level"
		elif ((volume_level >= 31 && volume_level <= 60)); then
			volume_string="$volume_level"
		elif ((volume_level >= 61 && volume_level <= 100)); then
			volume_string="$volume_level"
		else
			volume_string="+$volume_level"
		fi
	else
		volume_string="婢$volume_level"
	fi
	echo $volume_string | tee ~/.scripts/dwm/savedata/volume_string.txt
	"/home/aaron/.scripts/dwm/update_all.sh"
}

volume_update

