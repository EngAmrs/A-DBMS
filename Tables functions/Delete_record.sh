#!/bin/bash

while true 
do

    tableName=$(dialog --title "Table Name" --inputbox "Enter Table Name" 8 45 3>&1 1>&2 2>&3)

    if ! [[ -f $tableName ]] && [[ $tableName != "" ]]; then
        dialog --title "Error Message" --msgbox "$tableName table doesn't exist, please try again" 8 45

    elif [[ -f $tableName ]] && [[ $tableName != "" ]]; then

            colname=$(dialog --title "Table Records to be deleted"  --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
            checkcolumnfound=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'") print i}}}' $tableName)

                if [[ $checkcolumnfound == "" ]]; then
                dialog --title "Selecting Columns..." --msgbox "$colname column doesn't exist, please try again" 8 45
                else

                    value=$(dialog --title "Column Record" --inputbox "Enter the column value of the record" 8 45 3>&1 1>&2 2>&3)
                    recordNo=$(awk 'BEGIN{FS=":"}{if ($'$checkcolumnfound'=="'$value'") print NR}' $tableName)
                    if [[ $recordNo == 1 ]] ; then
                        dialog --title "Error Message" --msgbox "This record can't be delete" 8 45
                    else 

                        if [[ $recordNo == "" ]] ; then
                            dialog --title "Error Message" --msgbox "Record doesn't exist" 8 45
                        else
                            sed -i ''$recordNo'd' $tableName
                            dialog --title "Record" --msgbox "record deleted sucessfully" 8 45
                        fi
                    fi
                fi
    else
        break
    fi

done
