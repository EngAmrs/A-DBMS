#!/bin/bash

# create database "make a dir"

while [ 1 ]
do

dbName=$(dialog --title "Create DataBase" --inputbox "Enter the database name" 8 45 3>&1 1>&2 2>&3)

if [[ -d $dbName ]]; then

	echo "DataBase $dbName Already Exists";
	dialog --title "Create Database" --msgbox "DataBase $dbName Already Exists" 9 50

elif [[ $dbName == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+]* ]] || [[ $dbName == [0-9]* ]] ; then

	dialog --title "Create Database" --msgbox "{$dbName} not valid name DB please try again" 9 50

elif [[ $dbName != *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+]* ]] && [[ ! -d $dbName ]] && [[ $dbName != "" ]]; then
	
	dbName+=.db
	mkdir -p databases/$dbName
	dbName=${dbName::-3}
	echo "Your DataBase $dbName sucessfully created"
	dialog --title "Create Database" --infobox "$dbName database has been sucessfully created" 9 50
	sleep 1
	break
else 
	break
fi

done	
