#initially only checking for wifi connectivity

function internet_status_update {
	status_string="$( nmcli | grep -o "^wlan0:.*" | cut -f2- -d:) "
	#remove leading space
	status_string="$(echo -e "${status_string}" | sed -e 's/^[[:space:]]*//')"
	#remove trailing space
	status_string="$(echo -e "${status_string}" | sed -e 's/[[:space:]]*$//')"
	#first check wifi status then if wifi is disconnected or unavailable check etho
	echo $status_string
	if [[ "$status_string" = "unavailable" ]]; then
		#wifi is unavailable, should now check etho in this
		status_string="睊"
		#status_string+="(Wifi Down)"
	elif [[ "$status_string" = "disconnected" ]]; then
		status_string="直ﳤ"
		#status_string+="(Disconnected)"
	else
		#status must be connecting or connected
		#get the connecting/connected state (before to)
		status_left="$(echo $status_string | grep -oP '.*(?=to)' )"
		status_left="$(echo -e "${status_left}" | sed -e 's/^[[:space:]]*//')"
		status_left="$(echo -e "${status_left}" | sed -e 's/[[:space:]]*$//')"
		#get the network name after to
		status_right="$(echo -e $status_string | grep -oP '(?<= )\w')"
		status_right="$(echo -e "${status_right}" | sed -e 's/^[[:space:]]*//')"
		status_right="$(echo -e "${status_right}" | sed -e 's/[[:space:]]*$//')"
		#emoji print
		status_string="直"
		# Just add the connecting icon when connecting otherwise show the wireless icon
		if [[ $status_left = "connecting (configuring)" ]]; then
			status_right+=""
		fi
	fi
	echo $status_string | tee ~/.scripts/dwm/savedata/internet_status_string.txt
	"/home/aaron/.scripts/dwm/update_all.sh"
}

internet_status_update
