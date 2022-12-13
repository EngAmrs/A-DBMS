#!/bin/bash

while true
do
dbConnect=$(dialog --title "Conecting..." --inputbox "Enter the database name" 10 60 3>&1 1>&2 2>&3)
dbConnect+=.db
if [[ -d databases/$dbConnect ]]; then
	cd databases/$dbConnect 
	dialog --title "Connection" --msgbox "$dbConnect Database has been connected successfully" 9 50
	#. ../tablemenu.sh
	
	break
else
	dialog --title "Connection" --msgbox "$dbConnect does not exist" 9 50
	#echo "Does not exist"
	break
	
fi
done