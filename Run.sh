#!/bin/bash

function welcome(){
########################    
# Welcome message
########################

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

}


function DB_menu(){

################################
# Database Menu
################################
DB_Menu=$(dialog --title "DBMS Menu" --fb --menu "Select: " 20 80 6 \
		"1" "Create new Database" \
		"2" "List your Databases" \
		"3" "Connect to Database" \
		"4" "Drop Database" 3>&1 1>&2 2>&3)
	case $DB_Menu in
		1)
			echo "Create DataBase"
			. ./"Database functions"/createDB.sh
		        DB_menu
			;;
		3)
				echo "Connect to Database"
				dbConnect=$(dialog --title "Conecting..." --inputbox "Enter the database name" 10 60 3>&1 1>&2 2>&3)
				echo $dbConnect
				. ./"Database functions"/connect.sh	
			;;
		4)
			echo "Drop Database"
			dropName=$(dialog --title "Droping..." --inputbox "Enter the database name" 10 60 3>&1 1>&2 2>&3)
			echo $dropName
			. ./"Database functions"/drop.sh
				;;

		esac
}

welcome
DB_menu
