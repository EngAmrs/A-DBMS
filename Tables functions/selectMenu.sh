#!/bin/bash
function selectMenu () {

menu=$(dialog --title "Select Menu" --fb --menu "select options:" 17 60 0\
                                "1" "Select All Columns" \
                                "2" "Select Specific Columns" \
                                "3" "Select With Where Condition" \
                                "4" "Back to Table Menu" 3>&1 1>&2 2>&3)

                        case $menu in
                                1)
					while true ; do 

		                                tableName=$(dialog --title "List DataBases" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)
						if [[ ! -f $tableName ]] && [[ $tableName != "" ]]; then 
							dialog --title "Error Message" --msgbox "Table doesn't exist" 8 45

						elif [[ -f $tableName ]] && [[ $tableName != "" ]]; then 

							cat $tableName | awk -F: 'BEGIN{OFS="\t"}{for(n = 0; n <= NF; n++) $n=$n}  1' > fil
							numCol="$(cat $tableName | awk -F ":" 'END{print NF}')"
							. ../../.prettytable
							whiptail --title "Table Records" --msgbox "$(cat fil | prettytable ${numCol})" 18 70
							rm fil
							break
						else
							break
						fi
					done
					selectMenu
				
                                        ;;
                                2)
					 
					. ./../../"Tables functions"/selectColumns.sh
					selectMenu
                                        ;;
                                3)
                           		. ./../../"Tables functions"/selectWhere.sh
					selectMenu
                                        ;;
                                4)
                                        . ./../../"Tables functions"/Table_menu.sh
					;;
                              
                        esac
}



selectMenu
