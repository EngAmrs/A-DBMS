#!/bin/bash

while true
do

dbConnect=$(dialog --title "Conecting..." --inputbox "Enter the database name" 8 45 3>&1 1>&2 2>&3)

dbConnect+=.db

if [[ -d databases/$dbConnect ]] && [[ $dbConnect != .db  ]]; then

	
	dbConnect=${dbConnect::-3}

	if [[ ! -f databases/".$dbConnect" ]] ; then 

		dbConnect+=".db"
		cd databases/$dbConnect 
		dbConnect=${dbConnect::-3}
		dialog --title "Connection" --infobox "$dbConnect Database has been connected successfully" 8 50
		sleep 1
		. ../../"Tables functions"/Table_menu.sh
		break
	else 
		
		while true ;do

		userNam=$(dialog  --title "Login" --inputbox "Enter the User Name" 8 45 3>&1 1>&2 2>&3)
       		passUs=$(dialog --title "Login..."  --passwordbox   "Password" 8 45 3>&1 1>&2 2>&3)
		
		if [[ $(cut -d':' -f1 databases/.$dbConnect) == $userNam && $(cut -d':' -f2 databases/.$dbConnect) == $passUs ]] ;then
			dbConnect+=".db"
			cd databases/$dbConnect 
			dbConnect=${dbConnect::-3}
			dialog --title "Connection" --infobox "$dbConnect Database has been connected successfully" 8 50
			sleep 1
			. ../../"Tables functions"/Table_menu.sh
			break 2
		else
			dialog --title "Error" --msgbox "Wrong User Name or Password try again" 12 45

		fi 
		
		done
	fi

elif [[ ! -d databases/$dbConnect ]] && [[ $dbConnect != .db  ]] ; then

	dbConnect=${dbConnect::-3}
	dialog --title "Connection" --msgbox "$dbConnect does not exist" 8 45
	#echo "Does not exist"
else 
	break
fi
done
