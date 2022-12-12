#!/bin/bash

while true
do
if [[ -d $dropName ]]; then
	rm -R $dropName
	dialog --title "Drop Databse" --msgbox "$dropName database has been dropped sucessfully" 9 50
	#echo "$dropName database has been dropped sucessfully"
	break
else
	dialog --title "Drop Databse" --msgbox "$dropName database not found!" 9 50
	#echo "Database not found!"
	DB_menu
	break
fi
done
