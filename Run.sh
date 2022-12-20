#!/bin/bash

function welcome(){
########################    
# Welcome message 
########################
clear
Green='\033[1;32m'
NC='\033[0m' # No Color
echo ""
echo ""
echo ""
echo ""
echo " ##      ## ######## ##        ######   #######  ##     ## ######## "
echo " ##  ##  ## ##       ##       ##    ## ##     ## ###   ### ##       "
echo " ##  ##  ## ##       ##       ##       ##     ## #### #### ##       "
echo " ##  ##  ## ######   ##       ##       ##     ## ## ### ## ######   "
echo " ##  ##  ## ##       ##       ##       ##     ## ##     ## ##       "
echo " ##  ##  ## ##       ##       ##    ## ##     ## ##     ## ##       "
echo "  ###  ###  ######## ########  ######   #######  ##     ## ######## "
echo "		      "
echo "		      "
echo "		########  #######  "
echo "		   ##    ##     ## "
echo "		   ##    ##     ## "
echo "		   ##    ##     ## "
echo "		   ##    ##     ## "
echo "		   ##    ##     ## "
echo "		   ##     #######  "
echo "          "
echo "		    "
echo -e "${Green}		#### ####    ###    #### ####    ########  ########  ##     ##  ######  "
echo -e "${Green}		#### ####   ## ##   #### ####    ##     ## ##     ## ###   ### ##    ## "
echo -e "${Green}		 ##   ##   ##   ##   ##   ##     ##     ## ##     ## #### #### ##       "
echo -e "${Green}		          ##     ##              ##     ## ########  ## ### ##  ######  "
echo -e "${Green}		          #########              ##     ## ##     ## ##     ##       ## "
echo -e "${Green}		          ##     ##              ##     ## ##     ## ##     ## ##    ## "
echo -e "${Green}		          ##     ##              ########  ########  ##     ##  ######  ${NC}"

sleep 2
clear

}


function DB_menu(){

################################
# Database Menu
################################
DB_Menu=$(dialog --title "DBMS Menu" --fb --menu "Select: " 12 70 4 \
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
		2)
            echo "List & Number of  DataBases"
			cd databases
			databaselist=$(ls -d *.db | rev |cut -c4-| rev )
           		databaseNo=$(ls -d *.db | cut -f1 -d"/" | wc -w)
			dialog --title "Number of DataBases  No-{$databaseNo}" --msgbox "$databaselist" 20 45
			cd ../
			DB_menu
            ;;
		3)
			echo "Connect to Database"
			. ./"Database functions"/connect.sh
			DB_menu
			;;
		4)
			echo "Drop Database"
			. ./"Database functions"/drop.sh
			DB_menu
			;;

		esac
clear
}


welcome
DB_menu
