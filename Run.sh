#!/bin/bash

# Welcome message
clear 

echo " _ _ _       _                       "
echo "| | | | ___ | | ___  ___ ._ _ _  ___ "
echo "| | | |/ ._>| |/ | '/ . \| ' ' |/ ._>"
echo "|__/_/ \___.|_|\_|_.\___/|_|_|_|\___."
echo "                                     "

echo "		 _ _ ___  _ _  ___  ___  ___  ___  ___  ___  ___  ___ "
echo "		|/|/| . ||/|/ | . \| . ||_ _|| . || . >| . |/ __>| __>"
echo "		    |   |     | | ||   | | | |   || . \|   |\__ \| _> "
echo "		    |_|_|     |___/|_|_| |_| |_|_||___/|_|_|<___/|___>"
echo "		                                                      "

sleep 3
clear


function DB_menu(){
   
# Database Menu
DB_Menu=$(dialog --title "DBMS Menu" --fb --menu "Select: " 11 70 4 \
		"1" "Create new Database" \
		"2" "List your Databases" \
		"3" "Conect to Database" \
		"4" "Drop Database" 3>&1 1>&2 2>&3)
	case $DB_Menu in
		1)
			echo "Create DataBase"
			. ./createDB.sh
		        DB_menu
			;;
		2)
                        echo "List & Number of  DataBases"
			databaselist=$(ls -d */)
                        databaseNo=$(ls -d */ | cut -f1 -d"/" | wc -w)
			dialog --title "Number of DataBases  No-{$databaseNo}" --msgbox "$databaselist" 20 45
			DB_menu
                        ;;

	esac
}

DB_menu
