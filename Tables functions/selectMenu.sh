#!/bin/bash
function selectMenu () {

menu=$(dialog --title "Select Menu" --fb --menu "select options:" 12 60 4\
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

							cat $tableName | awk -F: 'BEGIN{OFS="\t"}{for(n = 0; n <= NF; n++) $n=$n} 1' > fil
							numCol="$(cat $tableName | awk -F ":" 'END{print NF}')"
							cat fil | sed -r 's/[┘]+/ /g' > fil2

							typeset -i length
							length=0							
							for (( i=1;i<=$numCol;i++)) 
							do 
							length+=$(cut -d$'\t' -f$i fil2| awk -F "" 'BEGIN{len=0}{if(len<NF)len=NF}END{print len}')
							done
							
							. ../../.prettytable
							whiptail --title "Table Records" --scrolltext --msgbox "$(cat fil2 | prettytable ${numCol})" 20\
								 $(("$length"+(("$numCol"+1)*4)))
							rm fil fil2
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
