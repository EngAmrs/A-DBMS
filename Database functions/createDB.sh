#!/bin/bash

# create database "make a dir"

while [ 1 ]
do

dbName=$(dialog --title "Create DataBase" --inputbox "Enter the database name" 8 45 3>&1 1>&2 2>&3)

if [[ -d $dbName ]]; then

	dialog --title "Create Database" --msgbox "DataBase $dbName Already Exists" 8 45

elif [[ $dbName == *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+]* ]] || [[ $dbName == [0-9]* ]] ; then

	dialog --title "Create Database" --msgbox "{$dbName} not valid name DB please try again" 8 45

elif [[ $dbName != *['!'@#\$%^\&*().\,\:\;\/\\\"\'\{\}\`\~\-\^\%\$\<\>\?\|+]* ]] && [[ ! -d $dbName ]] && [[ $dbName != "" ]]; then
	
	dbName+=.db
	mkdir -p databases/$dbName
	dbName=${dbName::-3}

	dialog --yesno "Do you wont to make user name & password for data base?" 10 31

	response=$?
	case $response in
	   0) echo "File deleted."
	userNam=""
	passUs=""
	fasel=":"
	while true ;do
	user_record=$(dialog                                             \
            --separate-widget $'\n'                            \
            --title "Make User Name and Password"          \
            --form ""                                          \
            0 0 0                                              \
            "User Name:"   1 1 "$userNam"      1 30 40 30      \
            "Password:"  2 1 "$passUs"    2 30 40 30      \
            3>&1 1>&2 2>&3 3>&- )

            userNam=$(echo "$user_record" | sed -n 1p)
            passUs=$(echo "$user_record" | sed -n 2p)

		if [[ -z "${userNam// }" || -z "${passUs// }" ]] ;then
			dialog --title "User"  --msgbox "Empty feild try again" 8 45
		else

			touch databases/".$dbName"
			echo -n $userNam$fasel$passUs  >> databases/".$dbName"
			dialog --title "User" --msgbox "$dbName database has been sucessfully created \n with user name and password" 8 45
			break
		fi 
		
	done
	break
		;;
	   1) echo "File not deleted."


	dialog --title "Create Database" --infobox "$dbName database has been sucessfully created" 8 45
	sleep 1
	break
;;
	esac


else 
	break
fi

done	
