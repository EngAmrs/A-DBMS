#!/bin/bash

while true
do
if [[ -d $dbConnect ]]; then
	cd $dbConnect 
	dialog --title "Connection" --infobox "$dbConnect Database has been connected successfully" 9 50
	#. ../tablemenu.sh
	
	break
else
	dialog --title "Connection" --msgbox "$dbConnect does not exist" 9 50
        DB_menu
	#echo "Does not exist"
	break
	
fi
done
