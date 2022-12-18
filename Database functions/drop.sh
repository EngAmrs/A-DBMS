#!/bin/bash

while true
do

dropName=$(dialog --title "Droping..." --inputbox "Enter the database name" 10 60 3>&1 1>&2 2>&3)

dropName+=.db

if [[ -d databases/$dropName ]] && [[ $dropName != .db  ]] ; then
	
	rm -R databases/$dropName
	dropName=${dropName::-3}
	dialog --title "Drop Databse" --infobox "$dropName database has been dropped sucessfully" 9 50
	sleep 1
	break

elif [[ ! -d databases/$dropName ]] && [[ $dropName != .db  ]] ; then
 	
	dropName=${dropName::-3}
	dialog --title "Drop Databse" --msgbox "$dropName database not found!" 9 50

else	
	break
fi
done
