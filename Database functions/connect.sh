#!/bin/bash

while true
do

dbConnect=$(dialog --title "Conecting..." --inputbox "Enter the database name" 8 45 3>&1 1>&2 2>&3)

dbConnect+=.db

if [[ -d databases/$dbConnect ]] && [[ $dbConnect != .db  ]]; then

	cd databases/$dbConnect 
	dbConnect=${dbConnect::-3}
	dialog --title "Connection" --infobox "$dbConnect Database has been connected successfully" 8 50
	sleep 1
	. ../../"Tables functions"/Table_menu.sh
	break

elif [[ ! -d databases/$dbConnect ]] && [[ $dbConnect != .db  ]] ; then

	dbConnect=${dbConnect::-3}
	dialog --title "Connection" --msgbox "$dbConnect does not exist" 8 45
	#echo "Does not exist"
else 
	break
fi
done
