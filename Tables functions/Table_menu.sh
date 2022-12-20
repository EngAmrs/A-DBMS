#!/bin/bash

function Table_menu (){

Table_menu=$(dialog --title "Table options" --fb --menu "select... :" 16 70 8\
                                "1" "Create Table" \
                                "2" "List Tables" \
                                "3" "Drop Table" \
                                "4" "Insert Into Table" \
                                "5" "Select from Table" \
                                "6" "Delete from Table" \
                                "7" "Update Table" \
                                "8" "Back to DBMS menu" 3>&1 1>&2 2>&3)

                        case $Table_menu in
                                1)
                                        . ../../"Tables functions"/Create_table.sh
                                        Table_menu
                                        ;;

				2)
					table_list=`ls`
					table_list_count=$(ls | cut -f1 -d" " | wc -w)
                           		dialog --title "Number of tables {$table_list_count}" --msgbox "$table_list" 10 50
					Table_menu
					;;
				3)
					. ./../../"Tables functions"/droptable.sh
					Table_menu
					;;

				4) 	. ./../../"Tables functions"/insertData.sh
					Table_menu
					;;

				5) 	. ./../../"Tables functions"/selectMenu.sh
					Table_menu
					;;
                                6)
                                        . ./../../"Tables functions"/Delete_record.sh
                                        Table_menu
                                        ;;        
				
				7) 	. ./../../"Tables functions"/Update_table.sh
					Table_menu
					;;	
                                8)
                                        cd ../../
                                        ;;
                                *)
                                        cd ../../
                                        ;;
                        esac
}

Table_menu
