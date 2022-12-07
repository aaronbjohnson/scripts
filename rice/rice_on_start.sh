#!/bin/bash

#create the color array
color_array=()
#create a random list of colors
for (( i=1; i<=16; i++ ));
do
   color_array+=("#$(openssl rand -hex 3)")
done
#some basic colors first and constant wallpapers here 
#pywal can read a color scheme in json so we build a json string
jsonstr="{\"wallpaper\":\"/home/john/Pictures/Anime/Fate/rin_arch_blue_back.png\",\"alpha\":\"100\",\"special\":{\"background\":\"#000000\",\"foreground\":\"#000000\",\"cursor\":\"#000000\"},"
colorsstr="\"colors\":{\"color0\":\"#231f20\", "
index=1
#skip the first index because black is probably the best background for all the random generating
#colors
for ((i=1; i<${#color_array[@]}; i++)); do
 if((index != 15)); then
  colorsstr+="\"color$i\":\"${color_array[$i]}\", "
 ((index++))
 else
  colorsstr+="\"color$i\":\"${color_array[$i]}\""
 fi
done
jsonstr+="$colorsstr""}}"
#debug strings
#echo $jsonstr
#echo $jsonstr  output.txt
#echo $jsonstr | jq

#save the json file and make it pretty with jq
echo "$jsonstr" | jq > ~/.scripts/rice/random_color_theme.json 

#set the theme
#-q quiet mode, -n dont change the wallpaper, -e don't change previous, -f load the colorscheme
wal -q -n -e -f ~/.scripts/rice/random_color_theme.json
