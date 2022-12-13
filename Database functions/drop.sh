#!/bin/bash

while true
do

dropName=$(dialog --title "Droping..." --inputbox "Enter the database name" 10 60 3>&1 1>&2 2>&3)
dropName+=.db
if [[ -d databases/$dropName ]]; then
	rm -R databases/$dropName
	dialog --title "Drop Databse" --msgbox "$dropName database has been dropped sucessfully" 9 50
	#echo "$dropName database has been dropped sucessfully"
	break
else
	dialog --title "Drop Databse" --msgbox "$dropName database not found!" 9 50
	#echo "Database not found!"
	break
fi
done
