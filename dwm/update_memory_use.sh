#!/bin/sh


echo free -h | awk 'NR==2{printf "memgay:%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }' > /home/aaron/.scripts/dwm/savedata/memory_string.txt

echo "fuck you all"

/home/aaron/.scripts/dwm/update_all.sh



# function memory_update {


#	memory_use="free -h | awk 'NR==2{printf "memgay:%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'"

#	echo $memory_use | tee ~/.scripts/dwm/savedata/memory_string.txt
#	"/home/aaron/.scripts/dwm/update_all.sh"
#}

#memory_update
