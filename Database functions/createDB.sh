#!/bin/bash

# create database "make a dir"

while [ 1 ]
do

dbName=$(dialog --title "Create DataBase" --inputbox "Enter your data base name to creat" 8 45 3>&1 1>&2 2>&3)

if [[ -d $dbName ]]; then

	echo "DataBase $dbName Already Exists";
	whiptail --title "Create Databse Message" --msgbox "DataBase $dbName Already Exists" 8 45

elif [[ $dbName == *['!'@#\$%^\&*()+]* ]]; then

	dialog --title "Create Databse Message" --msgbox "{$dbName} not valid name DB please try again" 8 45

elif [[ $dbName != *['!'@#\$%^\&*()+]* ]] && [[ ! -d $dbName ]]; then

	mkdir $dbName
	echo "Your DataBase $dbName sucessfully created"
	whiptail --title "Create Databse Message" --msgbox "Your DataBase $dbName sucessfully created" 8 45
	break
else	
	break
fi

done	
