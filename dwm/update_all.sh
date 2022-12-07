#update xsetroot function
function run_update {
	date_string="$(cat /home/aaron/.scripts/dwm/savedata/date_string.txt)"
	volume_string="$(cat /home/aaron/.scripts/dwm/savedata/volume_string.txt)"
#	battery_string="$(cat /home/aaron/.scripts/dwm/savedata/battery_string.txt)"
	internet_status_string="$(cat /home/aaron/.scripts/dwm/savedata/internet_status_string.txt)"
#	bright_string="$(cat /home/aaron/.scripts/dwm/savedata/brightness_string.txt)"
	weather_string="$(cat /home/aaron/.scripts/dwm/savedata/weather_string.txt)"
	disk_use_string="$(cat /home/aaron/.scripts/dwm/savedata/disk_use_string.txt)"
	memory_string="$(cat /home/aaron/.scripts/dwm/savedata/memory_string.txt)"

	final_string="$memory_string | $weather_string | $disk_use_string | $internet_status_string | $volume_string | $date_string "
	compare_string="$(cat /home/aaron/.scripts/dwm/savedata/final_string.txt)"

	#only update the gui when a new string is made
	if [ "$final_string" = "$compare_string" ]; then
		#debug
		#echo "no up" |tee ~/.scripts/dwm/savedata/up_no.txt
		exit 0
	else
		xsetroot -name "$final_string"
		echo $final_string | tee ~/.scripts/dwm/savedata/final_string.txt
	fi
}

run_update
