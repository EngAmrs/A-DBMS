#!/bin/bash

while true
do

table=$(dialog --title "Creating table..." --inputbox "Enter the table name" 9 50 3>&1 1>&2 2>&3)

if [[ -f $table ]] && [[ $table != "" ]]; then
dialog --title "Creating table..." --msgbox "$table is already exist!" 9 50

else
	colNumber=$(dialog --title "Creating columns..." --inputbox "Enter column number" 9 50 3>&1 1>&2 2>&3)
	touch $table
	touch .$table
break

fi
done