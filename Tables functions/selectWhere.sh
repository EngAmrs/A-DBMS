#!/bin/bash
     tableName=$(dialog --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

                                         if ! [[ -f $tableName ]]; then
                                                dialog --title "Error Message" --msgbox "Table doesn't exist" 8 45

                                                . ../selectmenu.sh
                                        else

                                                colname=$(dialog --title "Table Records"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
                                                checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)

                                                if [[ checkcolumnfound == "" ]]; then

                                                        dialog --title "Error Message" --msgbox "Column doesn't exist" 8 45

                                                else
                                                      	value=$(dialog --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
							record=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$value'")  print $0}' $tableName) 
							if [[ $record == "" ]] ; then
								dialog --title "Error Message" --msgbox "Record not found" 8 45
							else
								dialog --title "Record" --msgbox "$record" 15 45
								#echo "hello"
							fi
                                                fi
						
                                                . ../selectmenu.sh
                                        fi

